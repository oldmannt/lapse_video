//
//  logic_imp.cpp
//  lapse
//
//  Created by dyno on 7/27/16.
//
//

#include "logic_imp.hpp"
#include "uilogic_gen.hpp"
#include "data_imp.hpp"

#include "macro.h"
#include "task_manager_gen.hpp"
#include "ui_manager_gen.hpp"
#include "instance_getter_gen.hpp"
#include "const_define.hpp"
#include "camera_controller_gen.hpp"
#include "lapse_event.hpp"
#include "platform_utility_gen.hpp"
#include "project_list_gen.hpp"
#include "timer_gen.hpp"
#include "language_store_gen.hpp"
#include "camera_config_gen.hpp"
#include "config_key_value.hpp"

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
    CHECK_RTF(DataGen::instance()->initialize(config),"initialize failed:%s", config.c_str());
    initialize_camera();
    
    std::string lang_path = InstanceGetterGen::getPlatformUtility()->getPackFilePath("language.json");
    CHECK(LanguageStoreGen::instance()->initialize(lang_path),"read language failed:%s", lang_path.c_str());
    
    LangType lang_type = InstanceGetterGen::getPlatformUtility()->getLanguage();
    LanguageStoreGen::instance()->setLanguage(lang_type);
    return true;
}

std::string LogicImp::getProjectsPath(){
    std::string projects_dir = DataGen::instance()->getProjectsDir();
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
            UiManagerGen::instance()->showViewController("gallery", false);
            break;
        case LapseEvent::CAMERA_BTN_SWITCH:
            break;
        case LapseEvent::CAMERA_BTN_LAPSE_STOP:
            this->lapseStop();
            break;
        case LapseEvent::CAMERA_BTN_LAPSE_RESUME:
            this->lapseResume();
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
    m_video_writer->start(DataGen::instance()->getCaptureIntevalMillsec());
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

void LogicImp::lapseStop(){
    CHECK_RT(m_video_writer!=nullptr, "video_writer null");
    int64_t interval = int64_t(1000/m_video_writer->getFPS());
    m_video_writer->setInterval(interval);
}

void LogicImp::lapseResume(){
    CHECK_RT(m_video_writer!=nullptr, "video_writer null");
    m_video_writer->setInterval(DataGen::instance()->getCaptureIntevalMillsec());
}

void LogicImp::initialize_camera(){
    std::shared_ptr<CameraControllerGen> camera_controller = InstanceGetterGen::getCameraController();
    CHECK_RT(camera_controller!=nullptr, "camera_controller null");
    
    camera_controller->setFlashMode(CameraConfigGen::instance()->getFlashMode());
    camera_controller->setQuality(CameraConfigGen::instance()->getQuatityLevel());
    std::string capture_mode = DataGen::instance()->getCaptureMode();
    if (ConfigKeyValue::CAPTURE_MODE_PHOTO == capture_mode){
        camera_controller->setFramePhoto(true);
    }
    
}

#include <ctime>
#include <iostream>
#include <locale>

void LogicImp::initialize_video(){
    //TEST_EQ(m_vide_config->getInt("interval"), 1000, "interval");
    //TEST_EQ(m_vide_config->getInt("resolution"), 480, "resolution");
    
    m_video_writer = VideoWriterGen::create();
    m_video_writer->setFPS(DataGen::instance()->getFps());
    m_video_writer->setBitRate(DataGen::instance()->getBitrate());
    
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