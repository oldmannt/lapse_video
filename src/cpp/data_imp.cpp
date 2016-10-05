//
//  data_imp.cpp
//  lapse
//
//  Created by dyno on 8/28/16.
//
//

#include "data_imp.hpp"
#include "instance_getter_gen.hpp"
#include "platform_utility_gen.hpp"
#include "capture_quick_mode.hpp"
#include "camera_config_gen.hpp"
#include "config_key_value.hpp"

#include "macro.h"

using namespace gearsbox;
using namespace lpase;

std::shared_ptr<DataGen> DataGen::instance(){
    static std::shared_ptr<DataGen> s_ptr = std::make_shared<DataImp>();
    return s_ptr;
}

bool DataImp::initialize(const std::string & config){
    CHECK_RTF(m_user_config==nullptr, "already initialize");
    m_user_config = InstanceGetterGen::getConfig("user");
    CHECK_RTF(m_user_config, "get user config null");
    std::string pack_path = InstanceGetterGen::getPlatformUtility()->getPackFilePath(config);
    CHECK_RTF(m_user_config->initialize(pack_path), "user config initialize failed %s", config.c_str());
    m_vide_config = m_user_config->getSubConfig("video");
    CHECK_RTF(m_vide_config!=nullptr, "get video node failed %s", config.c_str());
    m_camera_config = m_user_config->getSubConfig("camera");
    CHECK_RTF(m_camera_config!=nullptr, "get camera node failed %s", config.c_str());
    CHECK_RTF(CameraConfigGen::instance()->initialize(m_camera_config), "camera config initialize failed");
    return true;
}

std::string DataImp::getProjectsDir(){
    CHECK_RTP(m_user_config, "", "m_user_config null");
    return m_user_config->getString("project_dir");
}

std::string DataImp::getCaptureMode(){
    CHECK_RTP(m_user_config, "", "m_user_config null");
    return m_user_config->getString(ConfigKeyValue::CAPTURE_MODE);
}

void DataImp::setCaptureMode(const std::string & mode){
    CHECK_RT(m_user_config, "m_user_config null");
    m_user_config->setString(ConfigKeyValue::CAPTURE_MODE, mode);
}

int32_t DataImp::getCaptureIntevalMillsec(){
    CHECK_RTP(m_vide_config!=nullptr, 0, "m_video_config null");
    int32_t value = this->getCaptureInteval();
    std::string unit = this->getCaptureIntevalUnit();
    if (unit == "mill_sec"){
        return value;
    }
    else if (unit == "second"){
        return value*1000;
    }
    else if (unit == "minute"){
        return value*1000*60;
    }
}

int32_t DataImp::getCaptureInteval(){
    CHECK_RTP(m_vide_config!=nullptr, 0, "m_video_config null");
    return m_vide_config->getInt(ConfigKeyValue::VIDEO_INTERVAL);
}

std::string DataImp::getCaptureIntevalUnit(){
    CHECK_RTP(m_vide_config!=nullptr, "", "m_video_config null");
    return m_vide_config->getString(ConfigKeyValue::VIDEO_INTERVAL_UNIT);
}

void DataImp::setCaptureInteval(int32_t value, const std::string & unit){
    CHECK_RT(m_vide_config!=nullptr, "m_video_config null");
    m_vide_config->setInt(ConfigKeyValue::VIDEO_INTERVAL, value);
    m_vide_config->setString(ConfigKeyValue::VIDEO_INTERVAL_UNIT, unit);
}

void DataImp::setCaptureIntervalQuickMode(const std::string & mode){
    CHECK_RT(m_vide_config!=nullptr, "m_video_config null");
    int interval = m_vide_config->getInt(mode);
    CHECK_RT(interval!=0, "err mode:%s", mode.c_str());
    
    m_vide_config->setString("quick_mode", mode);
    this->setCaptureInteval(interval, "second");
}

std::string DataImp::getCaptureIntervalQuickMode(){
    CHECK_RT(m_vide_config!=nullptr, "m_video_config null");
    return m_vide_config->getString("quick_mode");
}

int32_t DataImp::getFps(){
    CHECK_RTP(m_vide_config!=nullptr, 0, "m_video_config null");
    return m_vide_config->getInt(ConfigKeyValue::VIDEO_FPS);
}

int32_t DataImp::getBitrate(){
    CHECK_RTP(m_vide_config!=nullptr, 0, "m_video_config null");
    return m_vide_config->getInt("bitrate");
}

int32_t DataImp::getResolution(){
    CHECK_RTP(m_vide_config!=nullptr, 0, "m_video_config null");
    return m_vide_config->getInt("resolution");
}

void DataImp::setFps(int32_t fps){
    CHECK_RT(m_vide_config!=nullptr, "m_video_config null");
    m_vide_config->setInt(ConfigKeyValue::VIDEO_FPS, fps);
}

void DataImp::setBitrate(int32_t bitrate){
    CHECK_RT(m_vide_config!=nullptr, "m_video_config null");
    m_vide_config->setInt("birate", bitrate);
}

void DataImp::setResolution(int32_t reso){
    CHECK_RT(m_vide_config!=nullptr, "m_video_config null");
    m_vide_config->setInt("resolution", reso);
}

bool DataImp::isCaptureModePhoto(int32_t interal){
    CHECK_RT(m_vide_config!=nullptr, "m_video_config null");
    
    int32_t line = m_user_config->getInt(ConfigKeyValue::CAPTURE_MODE_LINE);
    if (interal<=0) {
        return this->getCaptureIntevalMillsec() > line;
    }
    else {
        return interal > line;
    }
}
