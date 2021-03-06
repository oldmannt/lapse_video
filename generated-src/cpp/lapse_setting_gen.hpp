// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from lapse.djinni

#pragma once

#include <cstdint>
#include <memory>
#include <string>

namespace lpase {

class LapseSettingUiGen;

class LapseSettingGen {
public:
    virtual ~LapseSettingGen() {}

    static std::shared_ptr<LapseSettingGen> instance();

    virtual int32_t getQuickModeCount() = 0;

    virtual std::string getQuickModeName(int32_t index) = 0;

    virtual void selectQuickMode(int32_t index) = 0;

    virtual void setFps(int32_t fps) = 0;

    virtual void setLapse(int32_t lapse) = 0;

    virtual void onLoad(const std::shared_ptr<LapseSettingUiGen> & ui) = 0;

    virtual void onShow() = 0;

    virtual void onHide() = 0;

    virtual void clean() = 0;
};

}  // namespace lpase
