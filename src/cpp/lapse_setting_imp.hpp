//
//  lapse_setting_imp.hpp
//  lapse
//
//  Created by dyno on 10/10/16.
//
//

#ifndef lapse_setting_imp_hpp
#define lapse_setting_imp_hpp

#include "lapse_setting_gen.hpp"
#include "lapse_setting_ui_gen.hpp"
#include "timer_gen.hpp"
#include "task_excuser_gen.hpp"

namespace lpase {
    
    class LapseSettingImp: public LapseSettingGen, public gearsbox::TaskExcuserGen, public std::enable_shared_from_this<LapseSettingImp> {
public:
    virtual ~LapseSettingImp() {}
    
    static std::shared_ptr<LapseSettingGen> instance();
    
    virtual int32_t getQuickModeCount();
    
    virtual std::string getQuickModeName(int32_t index);
    
    virtual void selectQuickMode(int32_t index);
    
    virtual void setFps(int32_t fps);
    
    virtual void setLapse(int32_t lapse);
    
    virtual void onLoad(const std::shared_ptr<LapseSettingUiGen> & ui);
    
    virtual void onShow();
    
    virtual void onHide();
    
    virtual void clean();
    
    virtual void excuse(const std::shared_ptr<gearsbox::TaskInfoGen> & info);
    
private:
    std::shared_ptr<LapseSettingUiGen> m_ui;
    std::shared_ptr<gearsbox::TimerGen> m_timer;
        
    void updateUI();
};
    
}  // namespace lpase

#endif /* lapse_setting_imp_hpp */
