//
//  project_cell_imp.cpp
//  lapse
//
//  Created by dyno on 8/14/16.
//
//

#include "project_cell_imp.hpp"
#include "macro.h"
#include "instance_getter_gen.hpp"
#include "platform_utility_gen.hpp"
#include "file_info_gen.hpp"
#include "language_store_gen.hpp"
#include "moive_info_manager_gen.hpp"
#include "moive_info_gen.hpp"

using namespace lpase;
using namespace gearsbox;

std::shared_ptr<ProjectCellGen> ProjectCellGen::create(const std::string & path, int32_t out_w, int32_t out_h){
    std::shared_ptr<ProjectCellImp> rt = std::make_shared<ProjectCellImp>();
    CHECK_RTNULL(rt->initializ(path, out_w, out_h), "ProjectCellGen::create initialize failed");
    return rt;
}

bool ProjectCellImp::initializ(const std::string& path, int out_w, int out_h){
    CHECK_RTF(m_video_info==nullptr, "alread initialized");
    m_video_info = VideoInfoGen::getVideoInfo(path, out_w, out_h);
    CHECK_RTF(m_video_info!=nullptr, "create video info failled");
    
    //G_LOG_C(LOG_INFO, "%s frames:%d w:%d h:%d fps:%d duration:%d", m_video_info->getName().c_str(), m_video_info->getFrameAmount(), m_video_info->getWidth(), m_video_info->getHeight(), m_video_info->getFPS(), m_video_info->getDuration());
    
    m_path = path;
    
    if (m_video_info->getDuration() < 1){
        m_length = std::to_string(m_video_info->getFrameAmount()) + LanguageStoreGen::instance()->getString("cell_frame");
    }
    else{
        m_length = std::to_string(m_video_info->getDuration()) + LanguageStoreGen::instance()->getString("cell_duration");
    }
    
    m_fps = LanguageStoreGen::instance()->getString("cell_fps");
    m_fps += ":";
    m_fps += std::to_string(m_video_info->getFPS());
    
    std::shared_ptr<FileInfoGen> file_info = InstanceGetterGen::getPlatformUtility()->getFileInfo(path);
    CHECK_RTF(file_info!=nullptr,"get file info failed:%s", path.c_str());
    m_name = file_info->getPrefix();
    std::chrono::system_clock::time_point tp = file_info->getCreateDate();
    std::time_t t = std::chrono::system_clock::to_time_t(tp);
    
    char mbstr[128] = {0};
    if (std::strftime(mbstr, sizeof(mbstr), LanguageStoreGen::instance()->getString("projests_review_time").c_str(), std::localtime(&t))) {
        m_create_time = mbstr;
    } else {
        G_LOG_FC(LOG_ERROR, "get datetime failed,fmt:",LanguageStoreGen::instance()->getString("projects_review_date").c_str());
    }
    
    auto moive_info = MoiveInfoManagerGen::instance()->findMoiveInfo(file_info->getPrefix());
    if (moive_info!=nullptr){
        moive_info->setFPS(m_video_info->getFPS());
        moive_info->setFrameAmount(m_video_info->getFrameAmount());
        moive_info->setDurationSecond(m_video_info->getDuration());
        sprintf(mbstr, "%.01f%s", moive_info->getRecordDuration(),LanguageStoreGen::instance()->getString("cell_duration").c_str());
        m_record_duration = mbstr;
        //G_LOG_C(LOG_INFO,"moive info file:%s, record duration:%.03f, record lapse:%.03f",moive_info->getName().c_str(), moive_info->getRecordDuration(), moive_info->getRecordLapse());
    }
    
    return true;
}
