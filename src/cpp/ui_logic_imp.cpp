//
//  ui_logic_imp.cpp
//  lapse
//
//  Created by dyno on 7/25/16.
//
//

#include "ui_logic_imp.hpp"
#include "lapse_ui_scene.hpp"

#include "ui_manager_gen.hpp"
#include "view_gen.hpp"
#include "view_event_param.hpp"
#include "view_event.hpp"
#include "task_manager_gen.hpp"

#include "ilog.h"
#include "macro.h"

using namespace lpase;
using namespace gearsbox;

std::shared_ptr<UilogicGen> UilogicGen::instance(){
    static std::shared_ptr<UilogicGen> s_ptr = std::make_shared<UilogicImp>();
    return s_ptr;
}

bool UilogicImp::initialize(LapseUiScene scene){
    switch (scene) {
        case LapseUiScene::CAMERA:
            this->initializeCameraScene();
            break;
            
        default:
            break;
    }
 
    return true;
}

std::string UilogicImp::getEventStr(LapseEvent event){
    switch (event) {
        case LapseEvent::NONE: return "NONE";
        case LapseEvent::CAMERA_BEGIN: return "CAMERA_BEGIN";
        case LapseEvent::CAMERA_BTN_CAPTURE: return "CAMERA_BTN_CAPTURE";
        case LapseEvent::CAMERA_BTN_PAUSE: return "CAMERA_BTN_PAUSE";
        case LapseEvent::CAMERA_BTN_STOP: return "CAMERA_BTN_STOP";
        case LapseEvent::CAMERA_BTN_RESUME: return "CAMERA_BTN_RESUME";
        case LapseEvent::CAMERA_BTN_LAPSE: return "CAMERA_BTN_LAPSE";
        case LapseEvent::CAMERA_BTN_RATIO: return "CAMERA_BTN_RATIO";
        case LapseEvent::CAMERA_BTN_MORE: return "CAMERA_BTN_MORE";
        case LapseEvent::CAMERA_BTN_LIBRARY: return "CAMERA_BTN_LIBRARY";
        case LapseEvent::CAMERA_BTN_SWITCH: return "CAMERA_BTN_SWITCH";
        case LapseEvent::CAMERA_END: return "CAMERA_END";
        case LapseEvent::REVIEW_OPEN: return "REVIEW_OPEN";
        case LapseEvent::PROJECTS_BEGIN: return "PROJECTS_BEGIN";
        case LapseEvent::PROJECTS_BTN_BACK: return "PROJECTS_BTN_BACK";
        case LapseEvent::PROJECTS_SHOW: return "PROJECTS_SHOW";
        case LapseEvent::PROJECTS_LIST_SELECT: return "PROJECTS_LIST_SELECT";
        case LapseEvent::PROJECTS_END: return "PROJECTS_END";
        case LapseEvent::UI_END: return "UI_END";
           
        default:
            break;
    }
    
    return std::to_string(int(event));
}

bool UilogicImp::handle(const gearsbox::ViewEventParam & param, const std::shared_ptr<gearsbox::ViewGen> & view){
    
    if (param.type == ViewEvent::TAP){
        LapseEvent event_id = this->getUIEvent(view);
        G_LOG_C(LOG_INFO,"uievent %s", this->getEventStr(event_id).c_str());
        
        captureBtnShow(event_id);
        TaskManagerGen::instance()->addTask((int)event_id, -1, 0, nullptr);
    }
    
}

LapseEvent UilogicImp::getUIEvent(const std::shared_ptr<gearsbox::ViewGen>& view){
    MAP_EVENT::iterator find = m_uievent_map.find(view);
    if (find==m_uievent_map.end())
        return LapseEvent::NONE;
    return m_uievent_map[view];
}

void UilogicImp::captureBtnShow(LapseEvent event){
    /*
    switch (event) {
        case LapseEvent::NONE:
            m_btn_pasue->setVisiable(false);
            m_btn_stop->setVisiable(false);
            m_btn_resume->setVisiable(false);
            break;
        case LapseEvent::CAMERA_BTN_CAPTURE:
            m_btn_capture->setVisiable(false);
            m_btn_library->setVisiable(false);
            m_btn_pasue->setVisiable(true);
            m_btn_stop->setVisiable(true);
            break;
        case LapseEvent::CAMERA_BTN_PAUSE:
            m_btn_pasue->setVisiable(false);
            m_btn_resume->setVisiable(true);
            break;
        case LapseEvent::CAMERA_BTN_STOP:
            m_btn_capture->setVisiable(true);
            m_btn_library->setVisiable(true);
            m_btn_pasue->setVisiable(false);
            m_btn_stop->setVisiable(false);
            m_btn_resume->setVisiable(false);
            break;
        case LapseEvent::CAMERA_BTN_RESUME:
            m_btn_resume->setVisiable(true);
            m_btn_pasue->setVisiable(false);
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
            
        default:
            break;
    }
     */
}

bool UilogicImp::initializeCameraScene(){
    m_btn_capture = UiManagerGen::instance()->getView("camera_btn_capture");
    m_btn_pasue = UiManagerGen::instance()->getView("camera_btn_pause");
    m_btn_resume = UiManagerGen::instance()->getView("camera_btn_resume");
    m_btn_stop = UiManagerGen::instance()->getView("camera_btn_stop");
    m_btn_lapse = UiManagerGen::instance()->getView("camera_btn_lapse");
    m_btn_ratio = UiManagerGen::instance()->getView("camera_btn_ratio");
    m_btn_more = UiManagerGen::instance()->getView("camera_btn_more");
    m_btn_library = UiManagerGen::instance()->getView("camera_btn_library");
    m_btn_switch = UiManagerGen::instance()->getView("camera_btn_more");
    
    CHECK_RTF(m_btn_capture!=nullptr, "btn_capture null");
    CHECK_RTF(m_btn_pasue!=nullptr, "btn_pasue null");
    CHECK_RTF(m_btn_resume!=nullptr, "btn_resume null");
    CHECK_RTF(m_btn_stop!=nullptr, "btn_stop null");
    CHECK_RTF(m_btn_lapse!=nullptr, "btn_lapse null");
    CHECK_RTF(m_btn_ratio!=nullptr, "btn_ratio null");
    CHECK_RTF(m_btn_more!=nullptr, "btn_more null");
    CHECK_RTF(m_btn_library!=nullptr, "btn_library null");
    CHECK_RTF(m_btn_switch!=nullptr, "btn_switch null");
    
    /*
    m_btn_capture->setEventHandler(ViewEvent::TAP, shared_from_this());
    m_btn_pasue->setEventHandler(ViewEvent::TAP, shared_from_this());
    m_btn_resume->setEventHandler(ViewEvent::TAP, shared_from_this());
    m_btn_stop->setEventHandler(ViewEvent::TAP, shared_from_this());
    m_btn_lapse->setEventHandler(ViewEvent::TAP, shared_from_this());
    m_btn_ratio->setEventHandler(ViewEvent::TAP, shared_from_this());
    m_btn_more->setEventHandler(ViewEvent::TAP, shared_from_this());
    m_btn_library->setEventHandler(ViewEvent::TAP, shared_from_this());
    m_btn_switch->setEventHandler(ViewEvent::TAP, shared_from_this());
    */
    
    m_uievent_map[m_btn_capture] = LapseEvent::CAMERA_BTN_CAPTURE;
    m_uievent_map[m_btn_pasue] = LapseEvent::CAMERA_BTN_PAUSE;
    m_uievent_map[m_btn_stop] = LapseEvent::CAMERA_BTN_STOP;
    m_uievent_map[m_btn_resume] = LapseEvent::CAMERA_BTN_RESUME;
    m_uievent_map[m_btn_lapse] = LapseEvent::CAMERA_BTN_LAPSE;
    m_uievent_map[m_btn_ratio] = LapseEvent::CAMERA_BTN_RATIO;
    m_uievent_map[m_btn_more] = LapseEvent::CAMERA_BTN_MORE;
    m_uievent_map[m_btn_library] = LapseEvent::CAMERA_BTN_LIBRARY;
    m_uievent_map[m_btn_switch] = LapseEvent::CAMERA_BTN_SWITCH;
    
    //captureBtnShow(LapseEvent::NONE);
    return true;
}


