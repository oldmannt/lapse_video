// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from lapse.djinni

#import "LPAProjectCellGen+Private.h"
#import "LPAProjectCellGen.h"
#import "DJICppWrapperCache+Private.h"
#import "DJIError.h"
#import "DJIMarshal+Private.h"
#import "LPAProjectCellGen+Private.h"
#include <exception>
#include <utility>

static_assert(__has_feature(objc_arc), "Djinni requires ARC to be enabled for this file");

@interface LPAProjectCellGen ()

- (id)initWithCpp:(const std::shared_ptr<::lpase::ProjectCellGen>&)cppRef;

@end

@implementation LPAProjectCellGen {
    ::djinni::CppProxyCache::Handle<std::shared_ptr<::lpase::ProjectCellGen>> _cppRefHandle;
}

- (id)initWithCpp:(const std::shared_ptr<::lpase::ProjectCellGen>&)cppRef
{
    if (self = [super init]) {
        _cppRefHandle.assign(cppRef);
    }
    return self;
}

+ (nullable LPAProjectCellGen *)create:(nonnull NSString *)path
                                  outW:(int32_t)outW
                                  outH:(int32_t)outH {
    try {
        auto r = ::lpase::ProjectCellGen::create(::djinni::String::toCpp(path),
                                                 ::djinni::I32::toCpp(outW),
                                                 ::djinni::I32::toCpp(outH));
        return ::djinni_generated::ProjectCellGen::fromCpp(r);
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

- (nonnull NSString *)getPath {
    try {
        auto r = _cppRefHandle.get()->getPath();
        return ::djinni::String::fromCpp(r);
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

- (nonnull NSString *)getName {
    try {
        auto r = _cppRefHandle.get()->getName();
        return ::djinni::String::fromCpp(r);
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

- (nonnull NSString *)getCreateTime {
    try {
        auto r = _cppRefHandle.get()->getCreateTime();
        return ::djinni::String::fromCpp(r);
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

- (nonnull NSString *)getLength {
    try {
        auto r = _cppRefHandle.get()->getLength();
        return ::djinni::String::fromCpp(r);
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

- (nonnull NSString *)getFps {
    try {
        auto r = _cppRefHandle.get()->getFps();
        return ::djinni::String::fromCpp(r);
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

namespace djinni_generated {

auto ProjectCellGen::toCpp(ObjcType objc) -> CppType
{
    if (!objc) {
        return nullptr;
    }
    return objc->_cppRefHandle.get();
}

auto ProjectCellGen::fromCppOpt(const CppOptType& cpp) -> ObjcType
{
    if (!cpp) {
        return nil;
    }
    return ::djinni::get_cpp_proxy<LPAProjectCellGen>(cpp);
}

}  // namespace djinni_generated

@end