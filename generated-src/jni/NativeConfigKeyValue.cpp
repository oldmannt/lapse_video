// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from lapse.djinni

#include "NativeConfigKeyValue.hpp"  // my header

namespace djinni_generated {

NativeConfigKeyValue::NativeConfigKeyValue() = default;

NativeConfigKeyValue::~NativeConfigKeyValue() = default;

auto NativeConfigKeyValue::fromCpp(JNIEnv* jniEnv, const CppType& c) -> ::djinni::LocalRef<JniType> {
    (void)c; // Suppress warnings in release builds for empty records
    const auto& data = ::djinni::JniClass<NativeConfigKeyValue>::get();
    auto r = ::djinni::LocalRef<JniType>{jniEnv->NewObject(data.clazz.get(), data.jconstructor)};
    ::djinni::jniExceptionCheck(jniEnv);
    return r;
}

auto NativeConfigKeyValue::toCpp(JNIEnv* jniEnv, JniType j) -> CppType {
    ::djinni::JniLocalScope jscope(jniEnv, 1);
    assert(j != nullptr);
    (void)j; // Suppress warnings in release builds for empty records
    return {};
}

}  // namespace djinni_generated