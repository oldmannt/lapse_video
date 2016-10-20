// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from lapse.djinni

#pragma once

#include <functional>

namespace lpase {

enum class IntervalMode : int {
    SLOMO,
    LAPSE,
    NONE,
};

}  // namespace lpase

namespace std {

template <>
struct hash<::lpase::IntervalMode> {
    size_t operator()(::lpase::IntervalMode type) const {
        return std::hash<int>()(static_cast<int>(type));
    }
};

}  // namespace std
