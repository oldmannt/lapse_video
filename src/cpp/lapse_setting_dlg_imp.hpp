//
//  lapse_setting_dlg_imp.hpp
//  lapse
//
//  Created by dyno on 10/12/16.
//
//

#ifndef lapse_setting_dlg_imp_hpp
#define lapse_setting_dlg_imp_hpp

#include "lapse_setting_dlg_gen.hpp"
#include "timer_gen.hpp"

namespace lpase {
    
enum class IntervalMode;

class LapseSettingDlgImp: public LapseSettingDlgGen,
                public std::enable_shared_from_this<LapseSettingDlgImp> {
public:
                    LapseSettingDlgImp():m_saving(false){
                        
                    }
    virtual ~LapseSettingDlgImp() {}
    
    virtual void onLoad(const std::shared_ptr<LapseSettingDlgDelegate> & delegate);
    
    virtual void onShow();
    
    virtual bool onFpsChange(int32_t fps);
    
    virtual bool onLapseChange(lpase::IntervalMode mode, float lapse);
    
    virtual void onSelectInterval(IntervalMode mode);
    
    virtual bool onSave(int32_t fps, float lapse, IntervalMode mode);
private:
    std::shared_ptr<LapseSettingDlgDelegate> m_delegate;
    std::shared_ptr<gearsbox::TimerGen> m_fps_change_timer;
    std::shared_ptr<gearsbox::TimerGen> m_lapse_change_timer;
                    bool m_saving;
};
    
}  // namespace lpase

#endif /* lapse_setting_dlg_imp_hpp */
