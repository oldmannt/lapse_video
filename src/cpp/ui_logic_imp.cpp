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

bool UilogicImp::handle(const gearsbox::ViewEventParam & param, const std::shared_ptr<gearsbox::ViewGen> & view){
    
    if (param.type == ViewEvent::TAP){
        LapseEvent event_id = this->getUIEvent(view);
        G_LOG_C(LOG_INFO,"uievent %d", event_id);
        if (event_id>LapseEvent::NONE && event_id<LapseEvent::MAX){
            btnShow(event_id);
            TaskManagerGen::instance()->addTask((int)event_id, -1, 0, nullptr);
        }
    }
    
}

LapseEvent UilogicImp::getUIEvent(const std::shared_ptr<gearsbox::ViewGen>& view){
    MAP_EVENT::iterator find = m_uievent_map.find(view);
    if (find==m_uievent_map.end())
        return LapseEvent::NONE;
    return m_uievent_map[view];
}

void UilogicImp::btnShow(LapseEvent event){
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
            break;
        case LapseEvent::CAMERA_BTN_SWITCH:
            break;
            
        default:
            break;
    }
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
    
    m_btn_capture->setEventHandler(ViewEvent::TAP, shared_from_this());
    m_btn_pasue->setEventHandler(ViewEvent::TAP, shared_from_this());
    m_btn_resume->setEventHandler(ViewEvent::TAP, shared_from_this());
    m_btn_stop->setEventHandler(ViewEvent::TAP, shared_from_this());
    m_btn_lapse->setEventHandler(ViewEvent::TAP, shared_from_this());
    m_btn_ratio->setEventHandler(ViewEvent::TAP, shared_from_this());
    m_btn_more->setEventHandler(ViewEvent::TAP, shared_from_this());
    m_btn_library->setEventHandler(ViewEvent::TAP, shared_from_this());
    m_btn_switch->setEventHandler(ViewEvent::TAP, shared_from_this());
    
    m_uievent_map[m_btn_capture] = LapseEvent::CAMERA_BTN_CAPTURE;
    m_uievent_map[m_btn_pasue] = LapseEvent::CAMERA_BTN_PAUSE;
    m_uievent_map[m_btn_stop] = LapseEvent::CAMERA_BTN_STOP;
    m_uievent_map[m_btn_resume] = LapseEvent::CAMERA_BTN_RESUME;
    m_uievent_map[m_btn_lapse] = LapseEvent::CAMERA_BTN_LAPSE;
    m_uievent_map[m_btn_ratio] = LapseEvent::CAMERA_BTN_RATIO;
    m_uievent_map[m_btn_more] = LapseEvent::CAMERA_BTN_MORE;
    m_uievent_map[m_btn_library] = LapseEvent::CAMERA_BTN_LIBRARY;
    m_uievent_map[m_btn_switch] = LapseEvent::CAMERA_BTN_SWITCH;
    
    btnShow(LapseEvent::NONE);
    return true;
}


