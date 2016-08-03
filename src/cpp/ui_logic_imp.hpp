//
//  ui_logic_imp.hpp
//  lapse
//
//  Created by dyno on 7/25/16.
//
//

#ifndef ui_logic_imp_hpp
#define ui_logic_imp_hpp

#include <memory>
#include <map>

#include "view_event_handler.hpp"

#include "uilogic_gen.hpp"
#include "lapse_event.hpp"


namespace lpase {

class UilogicImp : public UilogicGen , public gearsbox::ViewEventHandler, public std::enable_shared_from_this<UilogicImp> {
public:
    virtual ~UilogicImp() {}
    
    virtual bool initialize(LapseUiScene scene);
    
    // gearsbox::ViewEventHandler
    virtual bool handle(const gearsbox::ViewEventParam & param, const std::shared_ptr<gearsbox::ViewGen> & view);
    
private:
    typedef std::map<std::shared_ptr<gearsbox::ViewGen>,LapseEvent> MAP_EVENT;
    
    MAP_EVENT m_uievent_map;
    std::shared_ptr<gearsbox::ViewGen> m_btn_capture;
    std::shared_ptr<gearsbox::ViewGen> m_btn_pasue;
    std::shared_ptr<gearsbox::ViewGen> m_btn_resume;
    std::shared_ptr<gearsbox::ViewGen> m_btn_stop;
    std::shared_ptr<gearsbox::ViewGen> m_btn_lapse;
    std::shared_ptr<gearsbox::ViewGen> m_btn_ratio;
    std::shared_ptr<gearsbox::ViewGen> m_btn_more;
    std::shared_ptr<gearsbox::ViewGen> m_btn_library;
    std::shared_ptr<gearsbox::ViewGen> m_btn_switch;
    
    LapseEvent getUIEvent(const std::shared_ptr<gearsbox::ViewGen>& view);
    bool initializeCameraScene();
    void btnShow(LapseEvent event);
};
}

#endif /* ui_logic_imp_hpp */
