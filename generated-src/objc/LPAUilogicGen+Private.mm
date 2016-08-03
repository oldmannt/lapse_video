// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from lapse.djinni

#import "LPAUilogicGen+Private.h"
#import "LPAUilogicGen.h"
#import "DJICppWrapperCache+Private.h"
#import "DJIError.h"
#import "DJIMarshal+Private.h"
#import "LPAUilogicGen+Private.h"
#include <exception>
#include <utility>

static_assert(__has_feature(objc_arc), "Djinni requires ARC to be enabled for this file");

@interface LPAUilogicGen ()

- (id)initWithCpp:(const std::shared_ptr<::lpase::UilogicGen>&)cppRef;

@end

@implementation LPAUilogicGen {
    ::djinni::CppProxyCache::Handle<std::shared_ptr<::lpase::UilogicGen>> _cppRefHandle;
}

- (id)initWithCpp:(const std::shared_ptr<::lpase::UilogicGen>&)cppRef
{
    if (self = [super init]) {
        _cppRefHandle.assign(cppRef);
    }
    return self;
}

+ (nullable LPAUilogicGen *)instance {
    try {
        auto r = ::lpase::UilogicGen::instance();
        return ::djinni_generated::UilogicGen::fromCpp(r);
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

- (BOOL)initialize:(LPALapseUiScene)scene {
    try {
        auto r = _cppRefHandle.get()->initialize(::djinni::Enum<::lpase::LapseUiScene, LPALapseUiScene>::toCpp(scene));
        return ::djinni::Bool::fromCpp(r);
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

namespace djinni_generated {

auto UilogicGen::toCpp(ObjcType objc) -> CppType
{
    if (!objc) {
        return nullptr;
    }
    return objc->_cppRefHandle.get();
}

auto UilogicGen::fromCppOpt(const CppOptType& cpp) -> ObjcType
{
    if (!cpp) {
        return nil;
    }
    return ::djinni::get_cpp_proxy<LPAUilogicGen>(cpp);
}

}  // namespace djinni_generated

@end
