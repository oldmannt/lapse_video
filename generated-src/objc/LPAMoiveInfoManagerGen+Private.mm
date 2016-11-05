// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from lapse.djinni

#import "LPAMoiveInfoManagerGen+Private.h"
#import "LPAMoiveInfoManagerGen.h"
#import "DJICppWrapperCache+Private.h"
#import "DJIError.h"
#import "DJIMarshal+Private.h"
#import "LPAMoiveInfoGen+Private.h"
#import "LPAMoiveInfoManagerGen+Private.h"
#include <exception>
#include <utility>

static_assert(__has_feature(objc_arc), "Djinni requires ARC to be enabled for this file");

@interface LPAMoiveInfoManagerGen ()

- (id)initWithCpp:(const std::shared_ptr<::lpase::MoiveInfoManagerGen>&)cppRef;

@end

@implementation LPAMoiveInfoManagerGen {
    ::djinni::CppProxyCache::Handle<std::shared_ptr<::lpase::MoiveInfoManagerGen>> _cppRefHandle;
}

- (id)initWithCpp:(const std::shared_ptr<::lpase::MoiveInfoManagerGen>&)cppRef
{
    if (self = [super init]) {
        _cppRefHandle.assign(cppRef);
    }
    return self;
}

+ (nullable LPAMoiveInfoManagerGen *)instance {
    try {
        auto r = ::lpase::MoiveInfoManagerGen::instance();
        return ::djinni_generated::MoiveInfoManagerGen::fromCpp(r);
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

- (BOOL)initialize:(nonnull NSString *)config {
    try {
        auto r = _cppRefHandle.get()->initialize(::djinni::String::toCpp(config));
        return ::djinni::Bool::fromCpp(r);
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

- (nullable LPAMoiveInfoGen *)createMoiveInfo:(nonnull NSString *)path {
    try {
        auto r = _cppRefHandle.get()->createMoiveInfo(::djinni::String::toCpp(path));
        return ::djinni_generated::MoiveInfoGen::fromCpp(r);
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

- (nullable LPAMoiveInfoGen *)findMoiveInfo:(nonnull NSString *)name {
    try {
        auto r = _cppRefHandle.get()->findMoiveInfo(::djinni::String::toCpp(name));
        return ::djinni_generated::MoiveInfoGen::fromCpp(r);
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

- (void)removeMoiveInfo:(nonnull NSString *)name {
    try {
        _cppRefHandle.get()->removeMoiveInfo(::djinni::String::toCpp(name));
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

- (void)save {
    try {
        _cppRefHandle.get()->save();
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

namespace djinni_generated {

auto MoiveInfoManagerGen::toCpp(ObjcType objc) -> CppType
{
    if (!objc) {
        return nullptr;
    }
    return objc->_cppRefHandle.get();
}

auto MoiveInfoManagerGen::fromCppOpt(const CppOptType& cpp) -> ObjcType
{
    if (!cpp) {
        return nil;
    }
    return ::djinni::get_cpp_proxy<LPAMoiveInfoManagerGen>(cpp);
}

}  // namespace djinni_generated

@end
