//
//  project_list_imp.cpp
//  lapse
//
//  Created by dyno on 8/14/16.
//
//

#include "project_list_imp.hpp"
#include "config_gen.hpp"
#include "platform_utility_gen.hpp"
#include "instance_getter_gen.hpp"
#include "project_cell_imp.hpp"
#include "logic_gen.hpp"
#include "macro.h"

using namespace lpase;
using namespace gearsbox;

std::shared_ptr<ProjectListGen> ProjectListGen::instance(){
    static std::shared_ptr<ProjectListImp> s_ptr = std::make_shared<ProjectListImp>();
    return s_ptr;
}

bool ProjectListImp::load(int32_t review_w, int32_t review_h){
    std::string projects_dir = LogicGen::instance()->getProjectsPath();
    std::unordered_set<std::string> video_files = InstanceGetterGen::getPlatformUtility()->getFilesFromPathBySuffix(projects_dir, "mp4");
    
    m_project_cells.reserve(video_files.size());
    std::unordered_set<std::string>::iterator it_video(video_files.begin());
    for (; it_video!=video_files.end(); ++it_video) {
        if (m_project_paths.find(*it_video)!=m_project_paths.end())
            continue;
        std::shared_ptr<ProjectCellGen> cell = ProjectCellGen::create(*it_video, review_w, review_h);
        CONTINUE(cell!=nullptr, "create cell failed file:%s", (*it_video).c_str());
        m_project_cells.push_back(cell);
        m_project_paths.insert(*it_video);
    }
    
}

std::shared_ptr<ProjectCellGen> ProjectListImp::getProjectData(int32_t index){
    CHECK_RTP(index<m_project_cells.size(), nullptr, "index bigger than size:%d", m_project_cells.size());
    return m_project_cells[index];
}

void ProjectListImp::selectProject(int32_t index){
    CHECK_RT(index>=0&&index<m_project_cells.size(),"select project cell failed index:%d", index);
    
    m_select = index;
}

void ProjectListImp::deleteProject(int32_t index){
    int32_t target = index<0 ? m_select : index;
    CHECK_RT(target>=0&&target<m_project_cells.size(),"select project cell failed index:%d", target);
    
    std::shared_ptr<ProjectCellGen> cell = m_project_cells[target];
    CHECK_RT(cell!=nullptr,"cell null index:%d", target);
    InstanceGetterGen::getPlatformUtility()->deleteFile(cell->getPath());
}

void ProjectListImp::publishProject(int32_t index, PublishChannel channel){
    int32_t target = index<0 ? m_select : index;
    CHECK_RT(target>=0&&target<m_project_cells.size(),"select project cell failed index:%d", target);
    
    std::shared_ptr<ProjectCellGen> cell = m_project_cells[target];
    CHECK_RT(cell!=nullptr,"cell null index:%d", target);
}

void ProjectListImp::saveProject(int32_t index){
    int32_t target = index<0 ? m_select : index;
    CHECK_RT(target>=0&&target<m_project_cells.size(),"select project cell failed index:%d", target);
    
    std::shared_ptr<ProjectCellGen> cell = m_project_cells[target];
    CHECK_RT(cell!=nullptr,"cell null index:%d", target);
    CHECK_RT(InstanceGetterGen::getPlatformUtility()->isVideoFileCompatibleToSavedPhotosAlbum(cell->getPath()), "video is not compatible to photos album:%s", cell->getPath().c_str());
    InstanceGetterGen::getPlatformUtility()->saveVideoFileToSavedPhotosAlbum(cell->getPath());
}

void ProjectListImp::watchProject(int32_t index){
    int32_t target = index<0 ? m_select : index;
    CHECK_RT(target>=0&&target<m_project_cells.size(),"select project cell failed index:%d", target);

    std::shared_ptr<ProjectCellGen> cell = m_project_cells[target];
    InstanceGetterGen::getPlatformUtility()->playVideo(cell->getPath());
}
