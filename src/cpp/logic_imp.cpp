//
//  logic_imp.cpp
//  lapse
//
//  Created by dyno on 7/27/16.
//
//

#include "logic_imp.hpp"
#include "uilogic_gen.hpp"

#include "macro.h"
#include "task_manager_gen.hpp"
#include "instance_getter_gen.hpp"
#include "const_define.hpp"
#include "camera_controller_gen.hpp"
#include "lapse_event.hpp"
#include "platform_utility_gen.hpp"
#include "project_list_gen.hpp"
#include "timer_gen.hpp"
#include "language_store_gen.hpp"

using namespace lpase;
using namespace gearsbox;

std::shared_ptr<LogicGen> LogicGen::instance(){
    static std::shared_ptr<LogicGen> s_ptr = std::make_shared<LogicImp>();
    return s_ptr;
}

LogicImp::LogicImp():m_video_writer(nullptr){
    
}

bool LogicImp::initialize(const std::string &config){
    TaskManagerGen::instance()->addTaskExcuser(shared_from_this());
    m_user_config = InstanceGetterGen::getConfig("user");
    CHECK_RTF(m_user_config, "get user config null");
    std::string pack_path = InstanceGetterGen::getPlatformUtility()->getPackFilePath(config);
    CHECK_RTF(m_user_config->initialize(pack_path), "user config initialize failed %s", config.c_str());
    m_vide_config = m_user_config->getSubConfig("video");
    CHECK_RTF(m_vide_config!=nullptr, "get video node failed %s", config.c_str());
    m_camera_config = m_user_config->getSubConfig("camera");
    CHECK_RTF(m_camera_config!=nullptr, "get camera node failed %s", config.c_str());
    initialize_camera();
    
    std::string lang_path = InstanceGetterGen::getPlatformUtility()->getPackFilePath("language.json");
    CHECK(LanguageStoreGen::instance()->initialize(lang_path),"read language failed:%s", lang_path.c_str());
    
    LangType lang_type = InstanceGetterGen::getPlatformUtility()->getLanguage();
    LanguageStoreGen::instance()->setLanguage(lang_type);
    return true;
}

std::string LogicImp::getProjectsPath(){
    std::string projects_dir = m_user_config->getString("projects_dir");
    std::string rt = InstanceGetterGen::getPlatformUtility()->getSubDirInHome(projects_dir);
    return rt;
}

void LogicImp::excuse(const std::shared_ptr<TaskInfoGen> & info){
    LapseEvent event = (LapseEvent)info->getTaskId();
    G_LOG_C(LOG_INFO, "logic excuse, id:%s", UilogicGen::instance()->getEventStr(event).c_str());
    
    CHECK_RT(event>LapseEvent::CAMERA_BEGIN && event<LapseEvent::UI_END, "not ui event");
    switch (event) {
        case LapseEvent::CAMERA_BTN_CAPTURE:
            this->captureStart();
            break;
        case LapseEvent::CAMERA_BTN_PAUSE:
            this->capturePause();
            break;
        case LapseEvent::CAMERA_BTN_STOP:
            this->captureStop();
            break;
        case LapseEvent::CAMERA_BTN_RESUME:
            this->captureResume();
            break;
        case LapseEvent::CAMERA_BTN_LAPSE:
            break;
        case LapseEvent::CAMERA_BTN_RATIO:
            break;
        case LapseEvent::CAMERA_BTN_MORE:
            break;
        case LapseEvent::CAMERA_BTN_LIBRARY:
            break;
        case LapseEvent::CAMERA_BTN_SWITCH:
            break;
            
        default:
            break;
    }
}


void LogicImp::captureStart(){
    if (m_video_writer!=nullptr) {
        G_LOG_FC(LOG_WARN, "m_video_writer should be null, stop should be called");
        this->captureStop();
    }
    
    initialize_video();
    CHECK_RT(m_video_writer!=nullptr, "video writer initialize failed");
    m_video_writer->start(m_vide_config->getInt(ConstDefine::INTERVAL));
    //m_video_writer->start(33);
}

void LogicImp::capturePause(){
    CHECK_RT(m_video_writer!=nullptr, "video_writer null puse");
    m_video_writer->pause();
}

void LogicImp::captureResume(){
    CHECK_RT(m_video_writer!=nullptr, "video_writer null resume");
    m_video_writer->resume();
}

void LogicImp::captureStop(){
    CHECK_RT(m_video_writer!=nullptr, "video_writer null stop");
    
    // handle in swift
    std::string video = m_video_writer->getFilePath();
    m_video_writer->saveNRlease();
    m_video_writer = nullptr;
    InstanceGetterGen::getPlatformUtility()->playVideo(video);
}

void LogicImp::gotoLibrary(){
    
}

void LogicImp::initialize_camera(){
    std::shared_ptr<CameraControllerGen> camera_controller = InstanceGetterGen::getCameraController();
    CHECK_RT(camera_controller!=nullptr, "camera_controller null");
    CHECK_RT(m_camera_config!=nullptr, "camera config null");
}

#include <ctime>
#include <iostream>
#include <locale>

void LogicImp::initialize_video(){
    //TEST_EQ(m_vide_config->getInt("interval"), 1000, "interval");
    //TEST_EQ(m_vide_config->getInt("resolution"), 480, "resolution");
    
    m_video_writer = VideoWriterGen::create();
    m_video_writer->setFPS(m_vide_config->getInt("fps"));
    m_video_writer->setBitRate(m_vide_config->getInt("bitrate"));
    
    std::string projects_dir = getProjectsPath();
    std::time_t t = std::time(NULL);
    char mbstr[1024];
    if (std::strftime(mbstr, sizeof(mbstr), "/lapse_%y%m%d%H%M%S.mp4", std::localtime(&t))) {
        projects_dir += mbstr;
        m_video_writer->setFilePath(projects_dir);
    }
    else{
        G_LOG_FC(LOG_ERROR, "time format failed");
        projects_dir += '/';
        projects_dir += std::to_string(TimerGen::currentTick());
        projects_dir += ".mp4";
        m_video_writer->setFilePath(projects_dir);
    }
}