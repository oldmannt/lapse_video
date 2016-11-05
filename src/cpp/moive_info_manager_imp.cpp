//
//  moive_info_manager_imp.cpp
//  lapse
//
//  Created by dyno on 11/1/16.
//
//

#include "moive_info_manager_imp.hpp"
#include "moive_info_imp.hpp"
#include "instance_getter_gen.hpp"
#include "platform_utility_gen.hpp"
#include "config_key_value.hpp"
#include "utils.hpp"
#include "macro.h"
#include "json/json.h"

using namespace lpase;
using namespace gearsbox;

std::shared_ptr<MoiveInfoManagerGen> MoiveInfoManagerGen::instance(){
    static auto s_ptr = std::make_shared<MoiveInfoManagerImp>();
    return s_ptr;
}

bool MoiveInfoManagerImp::initialize(const std::string & config){
    auto default_config = "/moives_info.json";
    m_path = InstanceGetterGen::getPlatformUtility()->getHomeDirectory();
    m_path += default_config;
    
    try {
        Json::Value json_cfg;
        if (!gearsbox::readJson(m_path, json_cfg)){
            G_LOG_C(LOG_INFO, "read json failed");
            return false;
        }
        
        Json::Value& array = json_cfg["moives"];
        CHECK_RTF(array.type()==Json::arrayValue,"moives not array");
        for (Json::ArrayIndex i=0; i<array.size(); ++i) {
            Json::Value& info_cfg = array[i];
            
            auto name = info_cfg["name"].asString();
            auto info = insertMoiveInfo(name);
            CONTINUE(nullptr!=info, "moive info don't exist:%s", name.c_str());
            info->setFrameAmount(info_cfg[ConfigKeyValue::FRAME].asInt());
            info->setFPS(info_cfg[ConfigKeyValue::FPS].asInt());
            info->setRecordDuration(info_cfg[ConfigKeyValue::RECORD_DURATION].asFloat());
            info->setRecordLapse(info_cfg[ConfigKeyValue::RECORD_LAPSE].asFloat());
        }
    } catch (std::exception &ex) {
        G_LOG_C(LOG_ERROR, "moive info mrg initialize failed:%s err:%d",config.c_str(),ex.what());
    }
    
    return true;
}

std::shared_ptr<MoiveInfoGen> MoiveInfoManagerImp::insertMoiveInfo(const std::string & name){
    if (this->findMoiveInfo(name)!=nullptr){
        return nullptr;
    }
    
    auto info = std::make_shared<MoiveInfoImp>(name);
    m_moive_infos.insert(std::make_pair(name, info));
    return info;

}

std::shared_ptr<MoiveInfoGen> MoiveInfoManagerImp::createMoiveInfo(const std::string & path){
    if (!InstanceGetterGen::getPlatformUtility()->fileExists(path)){
        return nullptr;
    }
    
    auto name = InstanceGetterGen::getPlatformUtility()->getFileNameFromPath(path);
    if (name.find(".mp4")!=std::string::npos) {
        name.resize(name.size()-4);
    }
    
    auto info = insertMoiveInfo(name);
    if (!info)  return nullptr;

    return info;
}

std::shared_ptr<MoiveInfoGen> MoiveInfoManagerImp::findMoiveInfo(const std::string & name){
    auto find = m_moive_infos.find(name);
    if (find != m_moive_infos.end()){
        return find->second;
    }
    
    return nullptr;
}

void MoiveInfoManagerImp::removeMoiveInfo(const std::string & name){
    auto find = m_moive_infos.find(name);
    if (find == m_moive_infos.end()){
        return;
    }
    
    m_moive_infos.erase(find);
    this->save();
}

void MoiveInfoManagerImp::save(){
    Json::Value config;
    Json::Value array;
    
    SET_MOIVE::iterator it(m_moive_infos.begin());
    for (; it != m_moive_infos.end(); ++it) {
        auto info = it->second;
        CONTINUE(info!=nullptr, "info null");
        Json::Value item;
        item[ConfigKeyValue::NAME] = info->getName();
        item[ConfigKeyValue::FRAME] = info->getFrameAmount();
        item[ConfigKeyValue::FPS] = info->getFPS();
        item[ConfigKeyValue::RECORD_DURATION] = info->getRecordDuration();
        item[ConfigKeyValue::RECORD_LAPSE] = info->getRecordLapse();
        array.append(item);
    }
    config[ConfigKeyValue::MOIVES] = array;
    gearsbox::writerJson(m_path, config, true);
}
