//
//  lapse_setting_imp.cpp
//  lapse
//
//  Created by dyno on 10/10/16.
//
//
#include <math.h>

#include "lapse_setting_imp.hpp"
#include "data_gen.hpp"
#include "quick_mode_imp.hpp"
#include "config_key_value.hpp"
#include "camera_controller_gen.hpp"
#include "instance_getter_gen.hpp"

#include "macro.h"

using namespace lpase;
using namespace gearsbox;

std::shared_ptr<LapseSettingGen> LapseSettingGen::instance() {
    static std::shared_ptr<LapseSettingGen> s_ptr = std::make_shared<LapseSettingImp>();
    return s_ptr;
}

int32_t LapseSettingImp::getQuickModeCount(){
    return DataGen::instance()->getQuickModeCount();
}

std::string LapseSettingImp::getQuickModeName(int32_t index){
    std::shared_ptr<QuickModeGen> mode = DataGen::instance()->getQuickMode(index);
    CHECK_RTP(mode!=nullptr, "", "mode null, index:%d",index);
    return mode->getName();
}

void LapseSettingImp::selectQuickMode(int32_t index){
    std::shared_ptr<QuickModeGen> mode = DataGen::instance()->getQuickMode(index);
    CHECK_RT(mode!=nullptr, "mode null, index:%d",index);
    CHECK_RT(m_ui!=nullptr, "m_ui null");
    DataGen::instance()->setFps(mode->getFps());
    DataGen::instance()->setCaptureInteval(mode->getInterval(), ConfigKeyValue::MSEC);
    m_ui->updateFps(mode->getFps());
    m_ui->updateLapse(mode->getInterval());
}

void LapseSettingImp::setFps(int32_t fps){
    CHECK_RT(m_ui!=nullptr,"ui null");
    DataGen::instance()->setFps(fps);
    m_ui->updateFps(fps);
}

void LapseSettingImp::setLapse(int32_t lapse){
    CHECK_RT(m_ui!=nullptr,"ui null");
    DataGen::instance()->setCaptureInteval(lapse, ConfigKeyValue::MSEC);
    m_ui->updateLapse(lapse);
}

void LapseSettingImp::onLoad(const std::shared_ptr<LapseSettingUiGen> & ui){
    m_ui = ui;
    CHECK_RT(m_ui!=nullptr,"ui null");
    int32_t max_fps = 30;
    int32_t min_fps = 1;
    int32_t min_lapse = ceil(1000.0/max_fps);
    int32_t max_lapse = 12000;
    
    m_ui->initializeSliberFps(1, max_fps);
    m_ui->initializeSliberLapse(min_lapse, max_lapse);
}

void LapseSettingImp::onShow(){
    this->updateUI();
    
    if (nullptr == m_timer){
        m_timer = TimerGen::create(DataGen::instance()->getUiInfoUpdateRate()
                                   , -1, shared_from_this());
        m_timer->start();
    } else{
        m_timer->resume();
    }
}

void LapseSettingImp::updateUI(){
    CHECK_RT(m_ui!=nullptr,"ui null");
    int32_t cur_mode = DataGen::instance()->getCurrentQickMode();
    m_ui->updatePicker(cur_mode);
    m_ui->updateFps(DataGen::instance()->getFps());
    m_ui->updateLapse(DataGen::instance()->getCaptureInteval());
}

void LapseSettingImp::onHide(){
    CHECK(m_timer!=nullptr, "timer null");
    m_timer->pause();
}

void LapseSettingImp::excuse(const std::shared_ptr<gearsbox::TaskInfoGen> & info){
    //this->updateUI();
}

void LapseSettingImp::clean(){
    m_ui = nullptr;
    m_timer = nullptr;
}
