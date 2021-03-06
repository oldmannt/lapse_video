// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from lapse.djinni

#import "LPALapseSettingUiGen+Private.h"
#import "LPALapseSettingUiGen.h"
#import "DJIMarshal+Private.h"
#import "DJIObjcWrapperCache+Private.h"

static_assert(__has_feature(objc_arc), "Djinni requires ARC to be enabled for this file");

namespace djinni_generated {

class LapseSettingUiGen::ObjcProxy final
: public ::lpase::LapseSettingUiGen
, public ::djinni::ObjcProxyCache::Handle<ObjcType>
{
public:
    using Handle::Handle;
    void initializeSliberFps(int32_t c_min, int32_t c_max) override
    {
        @autoreleasepool {
            [Handle::get() initializeSliberFps:(::djinni::I32::fromCpp(c_min))
                                           max:(::djinni::I32::fromCpp(c_max))];
        }
    }
    void initializeSliberLapse(int32_t c_min, int32_t c_max) override
    {
        @autoreleasepool {
            [Handle::get() initializeSliberLapse:(::djinni::I32::fromCpp(c_min))
                                             max:(::djinni::I32::fromCpp(c_max))];
        }
    }
    void updateFps(int32_t c_fps) override
    {
        @autoreleasepool {
            [Handle::get() updateFps:(::djinni::I32::fromCpp(c_fps))];
        }
    }
    void updateLapse(int32_t c_lapse) override
    {
        @autoreleasepool {
            [Handle::get() updateLapse:(::djinni::I32::fromCpp(c_lapse))];
        }
    }
    void updatePicker(int32_t c_index) override
    {
        @autoreleasepool {
            [Handle::get() updatePicker:(::djinni::I32::fromCpp(c_index))];
        }
    }
};

}  // namespace djinni_generated

namespace djinni_generated {

auto LapseSettingUiGen::toCpp(ObjcType objc) -> CppType
{
    if (!objc) {
        return nullptr;
    }
    return ::djinni::get_objc_proxy<ObjcProxy>(objc);
}

auto LapseSettingUiGen::fromCppOpt(const CppOptType& cpp) -> ObjcType
{
    if (!cpp) {
        return nil;
    }
    return dynamic_cast<ObjcProxy&>(*cpp).Handle::get();
}

}  // namespace djinni_generated
