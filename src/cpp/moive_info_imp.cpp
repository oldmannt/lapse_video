//
//  moive_info_imp.cpp
//  lapse
//
//  Created by dyno on 11/1/16.
//
//

#include "moive_info_imp.hpp"
#include "moive_info_manager_gen.hpp"
#include "macro.h"

using namespace lpase;

bool MoiveInfoImp::setName(const std::string & name){
    auto find = MoiveInfoManagerGen::instance()->findMoiveInfo(name);
    CHECK_RTF(find==nullptr, "other has the name:%s", name.c_str());
    m_name = name;
    return true;
}

std::string MoiveInfoImp::getName(){
    return m_name;
}

std::string MoiveInfoImp::getFileName(){
    return m_file_name;
}

int32_t MoiveInfoImp::getFrameAmount(){
    return m_frame_amount;
}

float MoiveInfoImp::getDurationSecond(){
    return m_duration_second;
}

float MoiveInfoImp::getFPS(){
    return m_fps;
}

float MoiveInfoImp::getRecordDuration(){
    return m_record_duration;
}

float MoiveInfoImp::getRecordLapse(){
    return m_record_lapse;
}

void MoiveInfoImp::setFrameAmount(int32_t amount){
    m_frame_amount=amount;
}

void MoiveInfoImp::setDurationSecond(float seconds){
    m_duration_second=seconds;
}

void MoiveInfoImp::setFPS(float fps){
    m_fps=fps;
}

void MoiveInfoImp::setRecordDuration(float duration){
    m_record_duration=duration;
}

void MoiveInfoImp::setRecordLapse(float lapse){
    m_record_lapse=lapse;
}
