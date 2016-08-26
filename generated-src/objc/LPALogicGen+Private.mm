// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from lapse.djinni

#import "LPALogicGen+Private.h"
#import "LPALogicGen.h"
#import "DJICppWrapperCache+Private.h"
#import "DJIError.h"
#import "DJIMarshal+Private.h"
#import "LPALogicGen+Private.h"
#include <exception>
#include <utility>

static_assert(__has_feature(objc_arc), "Djinni requires ARC to be enabled for this file");

@interface LPALogicGen ()

- (id)initWithCpp:(const std::shared_ptr<::lpase::LogicGen>&)cppRef;

@end

@implementation LPALogicGen {
    ::djinni::CppProxyCache::Handle<std::shared_ptr<::lpase::LogicGen>> _cppRefHandle;
}

- (id)initWithCpp:(const std::shared_ptr<::lpase::LogicGen>&)cppRef
{
    if (self = [super init]) {
        _cppRefHandle.assign(cppRef);
    }
    return self;
}

+ (nullable LPALogicGen *)instance {
    try {
        auto r = ::lpase::LogicGen::instance();
        return ::djinni_generated::LogicGen::fromCpp(r);
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

- (BOOL)initialize:(nonnull NSString *)config {
    try {
        auto r = _cppRefHandle.get()->initialize(::djinni::String::toCpp(config));
        return ::djinni::Bool::fromCpp(r);
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

- (nonnull NSString *)getProjectsPath {
    try {
        auto r = _cppRefHandle.get()->getProjectsPath();
        return ::djinni::String::fromCpp(r);
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

namespace djinni_generated {

auto LogicGen::toCpp(ObjcType objc) -> CppType
{
    if (!objc) {
        return nullptr;
    }
    return objc->_cppRefHandle.get();
}

auto LogicGen::fromCppOpt(const CppOptType& cpp) -> ObjcType
{
    if (!cpp) {
        return nil;
    }
    return ::djinni::get_cpp_proxy<LPALogicGen>(cpp);
}

}  // namespace djinni_generated

@end
