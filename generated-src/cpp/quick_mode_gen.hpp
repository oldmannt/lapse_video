// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from lapse.djinni

#pragma once

#include <cstdint>
#include <memory>
#include <string>

namespace lpase {

class QuickModeGen {
public:
    virtual ~QuickModeGen() {}

    static std::shared_ptr<QuickModeGen> create(const std::string & name, int32_t fps, int32_t interval);

    virtual std::string getName() = 0;

    virtual int32_t getFps() = 0;

    virtual int32_t getInterval() = 0;
};

}  // namespace lpase
