//
//  data_imp.cpp
//  lapse
//
//  Created by dyno on 8/28/16.
//
//

#include "data_imp.hpp"
#include "capture_quick_mode.hpp"
#include "camera_config_gen.hpp"
#include "config_key_value.hpp"

#include "instance_getter_gen.hpp"
#include "platform_utility_gen.hpp"
#include "camera_controller_gen.hpp"
#include "language_store_gen.hpp"
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
    
    m_quick_mode_list = m_user_config->getSubConfig(ConfigKeyValue::QUICK_MODE_LIST);
    CHECK(this->initializeQuickMode(m_quick_mode_list),"initializeQuickMode failed");
    return true;
}

bool DataImp::initializeQuickMode(std::shared_ptr<gearsbox::ConfigGen> quick_mode){
    CHECK_RTF(quick_mode!=nullptr, "m_quick_mode_list null");
    CHECK_RTF(quick_mode->getArrayCount()>0,"no item");
    for (int32_t i=0; i<quick_mode->getArrayCount(); ++i) {
        std::shared_ptr<ConfigGen> item = m_quick_mode_list->getArrayItem(i);
        CONTINUE(item!=nullptr,"item null");
        std::string name = item->getString(ConfigKeyValue::NAME);
        CONTINUE(!name.empty()&&name!="", "name empty");
        item->getInt(ConfigKeyValue::VIDEO_INTERVAL);
        item->getInt(ConfigKeyValue::VIDEO_FPS);
        
        std::shared_ptr<QuickModeGen> quick_mode = QuickModeGen::create(name,
                            item->getInt(ConfigKeyValue::VIDEO_INTERVAL),
                            item->getInt(ConfigKeyValue::VIDEO_FPS));
        m_vec_quick_mode.push_back(quick_mode);
    }
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
    if (unit == ConfigKeyValue::MSEC){
        return value;
    }
    else if (unit == ConfigKeyValue::SECOND){
        return value*1000;
    }
    else if (unit == ConfigKeyValue::MINUTE){
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
    this->setCaptureInteval(interval, ConfigKeyValue::SECOND);
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

bool DataImp::isCaptureImmediate(int32_t interal){
    CHECK_RT(m_vide_config!=nullptr, "m_video_config null");
    int32_t line = m_user_config->getInt(ConfigKeyValue::CAPTURE_IMMEDIATE_LINE);
    if (interal<=0) {
        return this->getCaptureIntevalMillsec() < line;
    }
    else {
        return interal < line;
    }
}

int32_t DataImp::getMaxFps(){
    return m_user_config->getInt(ConfigKeyValue::FPS_MAX);
}

int32_t DataImp::getMinFps(){
    return m_user_config->getInt(ConfigKeyValue::FPS_MIN);
}

int32_t DataImp::getMinInterval(){
    int32_t max_frame = InstanceGetterGen::getCameraController()->getMaxFrameRate();
    return ceil(1000.0f/max_frame);
}

int32_t DataImp::getMaxInterval(){
    return m_user_config->getInt(ConfigKeyValue::INTERVAL_MAX);
}

int32_t DataImp::getMinLapse(){
    int32_t default_frame = InstanceGetterGen::getCameraController()->getDefaultFrameRate();
    return ceil(1000.0f/default_frame);
}

int32_t DataImp::getDefaultLapse(){
    return m_user_config->getInt(ConfigKeyValue::INTERVAL_DEFAULT);
}

bool DataImp::isSlowModeEnable(){
    return m_user_config->getBool(ConfigKeyValue::SLOMO_ENABLE);
}

int32_t DataImp::getQuickModeCount(){
    return (int32_t)m_vec_quick_mode.size();
}

std::shared_ptr<QuickModeGen> DataImp::getQuickMode(int32_t index){
    CHECK_RTNULL(index<m_vec_quick_mode.size(),"getQuickMode index out of range");
    return m_vec_quick_mode[index];
}

void DataImp::selectQuickMode(int32_t index){
    CHECK_RT(m_user_config!=nullptr, "m_video_config null");
    CHECK_RT(index>=m_vec_quick_mode.size(),"out of range, index:%d", index);
    m_user_config->setInt(ConfigKeyValue::QUICK_MODE, index);
}

int32_t DataImp::getCurrentQickMode(){
    int32_t defaut = getQuickModeDefaultIndex();
    int32_t fps = this->getFps();
    int32_t interval = this->getCaptureInteval();
    
    for (int32_t i=0; i<m_vec_quick_mode.size(); ++i) {
        std::shared_ptr<QuickModeGen> mode = m_vec_quick_mode[i];
        if (fps == mode->getFps() && interval == mode->getInterval()){
            return i;
        }
    }
    
    return defaut;
}

int32_t DataImp::getUiInfoUpdateRate(){
    CHECK_RT(m_user_config!=nullptr, "m_video_config null");
    return m_user_config->getInt(ConfigKeyValue::UI_INFO_UPDATE);
}

int32_t DataImp::getQuickModeDefaultIndex(){
    static int32_t s_default = -1;
    if (s_default > -1){
        return s_default;
    }
    for (int32_t i=0; i<m_vec_quick_mode.size(); ++i) {
        std::shared_ptr<QuickModeGen> mode = m_vec_quick_mode[i];
        if (nullptr == mode) continue;
        G_LOG_C(LOG_INFO,"name %s", mode->getName().c_str());
        if (mode->getName() == ConfigKeyValue::CUSTOM){
            s_default = i;
            return s_default;
        }
    }
    
    std::shared_ptr<QuickModeGen> quick_mode = QuickModeGen::create(ConfigKeyValue::CUSTOM,0,0);
    m_vec_quick_mode.push_back(quick_mode);
    s_default = m_vec_quick_mode.size()-1;
}

std::string DataImp::getFpsRangeAlert(){
    char buf[128] = {0};
    sprintf(buf, LanguageStoreGen::instance()->getString(ConfigKeyValue::FPS_RANGE_ALERT).c_str(),
            this->getMinFps(), this->getMaxFps());
    return buf;
}

std::string DataImp::getLapseRangeAlert(){
    char buf[128] = {0};
    sprintf(buf, LanguageStoreGen::instance()->getString(ConfigKeyValue::LAPSE_RANGE_ALERT).c_str(),
            this->getMinLapse()/1000.0f, this->getMaxInterval());
    return buf;
}

std::string DataImp::getSlomoRangeAlert(){
    
}
