// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from lapse.djinni

#import "LPALapseSettingDlgDelegate+Private.h"
#import "LPALapseSettingDlgDelegate.h"
#import "DJIMarshal+Private.h"
#import "DJIObjcWrapperCache+Private.h"

static_assert(__has_feature(objc_arc), "Djinni requires ARC to be enabled for this file");

namespace djinni_generated {

class LapseSettingDlgDelegate::ObjcProxy final
: public ::lpase::LapseSettingDlgDelegate
, public ::djinni::ObjcProxyCache::Handle<ObjcType>
{
public:
    using Handle::Handle;
    void updateSegMode(::lpase::IntervalMode c_mode) override
    {
        @autoreleasepool {
            [Handle::get() updateSegMode:(::djinni::Enum<::lpase::IntervalMode, LPAIntervalMode>::fromCpp(c_mode))];
        }
    }
    void updateFps(int32_t c_fps) override
    {
        @autoreleasepool {
            [Handle::get() updateFps:(::djinni::I32::fromCpp(c_fps))];
        }
    }
    void updateLapse(float c_lapse) override
    {
        @autoreleasepool {
            [Handle::get() updateLapse:(::djinni::F32::fromCpp(c_lapse))];
        }
    }
    int32_t getFps() override
    {
        @autoreleasepool {
            auto r = [Handle::get() getFps];
            return ::djinni::I32::toCpp(r);
        }
    }
    float getLapse() override
    {
        @autoreleasepool {
            auto r = [Handle::get() getLapse];
            return ::djinni::F32::toCpp(r);
        }
    }
};

}  // namespace djinni_generated

namespace djinni_generated {

auto LapseSettingDlgDelegate::toCpp(ObjcType objc) -> CppType
{
    if (!objc) {
        return nullptr;
    }
    return ::djinni::get_objc_proxy<ObjcProxy>(objc);
}

auto LapseSettingDlgDelegate::fromCppOpt(const CppOptType& cpp) -> ObjcType
{
    if (!cpp) {
        return nil;
    }
    return dynamic_cast<ObjcProxy&>(*cpp).Handle::get();
}

}  // namespace djinni_generated
