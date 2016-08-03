// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from lapse.djinni

#pragma once

#include <functional>

namespace lpase {

enum class LapseEvent : int {
    NONE,
    CAMERA_BTN_CAPTURE,
    CAMERA_BTN_PAUSE,
    CAMERA_BTN_STOP,
    CAMERA_BTN_RESUME,
    CAMERA_BTN_LAPSE,
    CAMERA_BTN_RATIO,
    CAMERA_BTN_MORE,
    CAMERA_BTN_LIBRARY,
    CAMERA_BTN_SWITCH,
    MAX,
};

}  // namespace lpase

namespace std {

template <>
struct hash<::lpase::LapseEvent> {
    size_t operator()(::lpase::LapseEvent type) const {
        return std::hash<int>()(static_cast<int>(type));
    }
};

}  // namespace std
