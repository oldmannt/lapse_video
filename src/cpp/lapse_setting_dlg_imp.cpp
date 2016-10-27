//
//  lapse_setting_dlg_imp.cpp
//  lapse
//
//  Created by dyno on 10/12/16.
//
//

#include <math.h>

#include "lapse_setting_dlg_imp.hpp"
#include "lapse_setting_dlg_delegate.hpp"
#include "interval_mode.hpp"
#include "data_gen.hpp"
#include "config_key_value.hpp"

#include "instance_getter_gen.hpp"
#include "camera_controller_gen.hpp"
#include "platform_utility_gen.hpp"
#include "language_store_gen.hpp"
#include "fn_task.hpp"

#include "macro.h"

using namespace lpase;
using namespace gearsbox;

std::shared_ptr<LapseSettingDlgGen> LapseSettingDlgGen::instance(){
    static std::shared_ptr<LapseSettingDlgGen> s_ptr = std::make_shared<LapseSettingDlgImp>();
    return s_ptr;
}

void LapseSettingDlgImp::onLoad(const std::shared_ptr<LapseSettingDlgDelegate> &delegate){
    CHECK_RT(delegate!=nullptr, "onLoad delegate null");
    m_delegate = delegate;
}

void LapseSettingDlgImp::onShow(){
    CHECK_RT(m_delegate!=nullptr, "delegate null");
    int32_t fps = DataGen::instance()->getFps();
    int32_t interval = DataGen::instance()->getCaptureInteval();
    int32_t min_interval = DataGen::instance()->getMinInterval();
    bool enable_slomo = DataGen::instance()->isSlowModeEnable();
    
    if (enable_slomo && interval == min_interval){
        interval = DataGen::instance()->getMinLapse();
    }
    
    if (interval == min_interval){
        m_delegate->updateSegMode(IntervalMode::SLOMO);
        m_delegate->updateLapse(min_interval);
    }
    else {
        m_delegate->updateSegMode(IntervalMode::LAPSE);
        m_delegate->updateLapse(interval/1000.0);
    }
    
    if (!enable_slomo){
        m_delegate->updateSegMode(IntervalMode::NONE);
    }
    
    m_delegate->updateFps(fps);
}

bool LapseSettingDlgImp::onFpsChange(int32_t fps) {
    m_fps_change_timer = nullptr;
    
    int32_t min_fps = DataGen::instance()->getMinFps();
    int32_t max_fps = DataGen::instance()->getMaxFps();
    if (fps < min_fps || fps > max_fps){
        const std::weak_ptr<LapseSettingDlgImp> weak_self = shared_from_this();
        const std::weak_ptr<LapseSettingDlgDelegate> week_delegate = this->m_delegate;
        int32_t delay = m_saving ? -1 : -1;
        m_fps_change_timer = TimerGen::create(delay, 0, std::make_shared<FnTask>(
       [weak_self, week_delegate, min_fps, max_fps](){
           
           const std::shared_ptr<LapseSettingDlgDelegate> delegate = week_delegate.lock();
           CHECK_RT(delegate!=nullptr, "delegate null");
           
           int32_t new_fps = delegate->getFps();
           if (new_fps < min_fps){
               InstanceGetterGen::getPlatformUtility()->alertDialog(
                  LanguageStoreGen::instance()->getString(ConfigKeyValue::ALERT_TILLE_INFO),
                  DataGen::instance()->getFpsRangeAlert());
               delegate->updateFps(min_fps);
           }
           
           if (new_fps > max_fps){
               InstanceGetterGen::getPlatformUtility()->alertDialog(
                  LanguageStoreGen::instance()->getString(ConfigKeyValue::ALERT_TILLE_INFO),
                  DataGen::instance()->getFpsRangeAlert());
               delegate->updateFps(max_fps);
           }
           
       }));
        m_fps_change_timer->start();
        return false;
    }
    
    return true;
}

bool LapseSettingDlgImp::onLapseChange(lpase::IntervalMode mode, float lapse){

    if (mode == IntervalMode::SLOMO) {
        return DataGen::instance()->getMinInterval();
    }
    
    float f = floorf(lapse*1000.0f);
    float lapse_fix = floorf(lapse*1000.0f)/1000.0f;
    int32_t min_lapse = DataGen::instance()->getMinLapse();
    int32_t max_lapse = DataGen::instance()->getMaxInterval();
    
    if (lapse_fix*1000.0f < min_lapse || lapse_fix*1000.0f > max_lapse){
        
        float new_lapse = m_delegate->getLapse();
        float new_lapse_fix = floorf(new_lapse*1000.0f)/1000.0f;
        if (new_lapse_fix*1000.0f < min_lapse){
           
           InstanceGetterGen::getPlatformUtility()->alertDialog(
                LanguageStoreGen::instance()->getString(ConfigKeyValue::ALERT_TILLE_INFO),
                DataGen::instance()->getLapseRangeAlert());
           m_delegate->updateLapse(min_lapse/1000.0f);
        }
        else if (new_lapse_fix*1000.0f > max_lapse){
           InstanceGetterGen::getPlatformUtility()->alertDialog(
                LanguageStoreGen::instance()->getString(ConfigKeyValue::ALERT_TILLE_INFO),
                DataGen::instance()->getLapseRangeAlert());
           m_delegate->updateLapse(max_lapse/1000.0f);
        }
        else if (new_lapse_fix < new_lapse){
           m_delegate->updateLapse(new_lapse_fix);
        }

        return false;
    }
    
    return  true;
}

void LapseSettingDlgImp::onSelectInterval(lpase::IntervalMode mode){
    CHECK_RT(m_delegate!=nullptr, "delegate null");
    if (mode == IntervalMode::SLOMO){
        m_delegate->updateSegMode(mode);
        m_delegate->updateLapse(DataGen::instance()->getMinInterval());
    }
    else{
        m_delegate->updateSegMode(IntervalMode::LAPSE);
        m_delegate->updateLapse(DataGen::instance()->getCaptureInteval()/1000.0);
    }
}

bool LapseSettingDlgImp::onSave(int32_t fps, float lapse, IntervalMode mode){
    CHECK_RT(m_delegate!=nullptr, "delegate null");
    m_saving = true;
    if (!this->onFpsChange(fps) ||
        !this->onLapseChange(mode, lapse)){
        m_saving = false;
        return false;
    }
    
    int32_t interval = 0;
    if (mode == IntervalMode::SLOMO)
        interval = (int32_t)floor(lapse);
    else
        interval = (int32_t)floor(lapse*1000.0f);
    
    DataGen::instance()->setFps(fps);
    DataGen::instance()->setCaptureInteval(interval, ConfigKeyValue::MSEC);
    m_saving = false;
    return true;
}
