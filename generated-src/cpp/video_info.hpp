// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from lapse.djinni

#pragma once

#include <cstdint>
#include <utility>

namespace lpase {

struct VideoInfo final {
    float interval;
    int32_t fps;
    int32_t resolution;
    int32_t exposure;
    int32_t iso;

    VideoInfo(float interval_,
              int32_t fps_,
              int32_t resolution_,
              int32_t exposure_,
              int32_t iso_)
    : interval(std::move(interval_))
    , fps(std::move(fps_))
    , resolution(std::move(resolution_))
    , exposure(std::move(exposure_))
    , iso(std::move(iso_))
    {}
};

}  // namespace lpase
