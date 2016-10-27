//
//  project_list_imp.cpp
//  lapse
//
//  Created by dyno on 8/14/16.
//
//

#include "project_list_imp.hpp"
#include "project_cell_imp.hpp"
#include "logic_gen.hpp"
#include "lapse_event.hpp"

#include "config_gen.hpp"
#include "platform_utility_gen.hpp"
#include "task_manager_gen.hpp"
#include "task_excuser_gen.hpp"
#include "task_info_gen.hpp"
#include "instance_getter_gen.hpp"
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

    m_project_paths.insert(video_files.begin(), video_files.end());
    m_project_cells.reserve(video_files.size());
    std::set<std::string>::iterator it_video(m_project_paths.begin());
    for (; it_video!=m_project_paths.end(); ++it_video) {
        if (m_project_paths.find(*it_video)!=m_project_paths.end())
            continue;
        std::shared_ptr<ProjectCellGen> cell = ProjectCellGen::create(*it_video, review_w, review_h);
        CONTINUE(cell!=nullptr, "create cell failed file:%s", (*it_video).c_str());
        m_project_cells.push_back(cell);
        m_project_paths.insert(*it_video);

        std::shared_ptr<TaskInfoGen> info = TaskManagerGen::instance()->create_info((int64_t)LapseEvent::PROJECTS_LIST_UPDATE_ADD, -1, 0);
        info->setIValue("index", m_project_cells.size()-1);
        TaskManagerGen::instance()->addTaskInfo(info, nullptr);
    }
    
}

std::shared_ptr<ProjectCellGen> ProjectListImp::getProjectData(int32_t index){
    int32_t target = index<0 ? m_select : index;
    CHECK_RTP(target<m_project_cells.size(), nullptr, "index bigger than size:%d index:%d", m_project_cells.size(), target);

    return m_project_cells[target];
}

void ProjectListImp::selectProject(int32_t index){
    CHECK_RT(index>=0&&index<m_project_cells.size(),"select project cell failed index:%d", index);
    
    m_select = index;
}

void ProjectListImp::deleteProject(int32_t index){
    int32_t target = index<0 ? m_select : index;
    CHECK_RT(target>=0&&target<m_project_cells.size(),"select project cell failed index:%d", target);
    
    VEC_CELLS::iterator it(m_project_cells.begin());
    for (int i=index; i>=0; --i) {
        it++;
    }
    
    std::shared_ptr<ProjectCellGen> cell = *it;
    CHECK_RT(cell!=nullptr,"cell null index:%d", target);
    InstanceGetterGen::getPlatformUtility()->deleteFile(cell->getPath());
    m_project_cells.erase(it);
    
    std::shared_ptr<TaskInfoGen> info = TaskManagerGen::instance()->create_info((int64_t)LapseEvent::PROJECTS_LIST_UPDATE_DELETE, -1, 0);
    info->setIValue("index", target);
    TaskManagerGen::instance()->addTaskInfo(info, nullptr);
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
