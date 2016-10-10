// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from lapse.djinni

#pragma once

#include "config_key_value.hpp"
#include "djinni_support.hpp"

namespace djinni_generated {

class NativeConfigKeyValue final {
public:
    using CppType = ::lpase::ConfigKeyValue;
    using JniType = jobject;

    using Boxed = NativeConfigKeyValue;

    ~NativeConfigKeyValue();

    static CppType toCpp(JNIEnv* jniEnv, JniType j);
    static ::djinni::LocalRef<JniType> fromCpp(JNIEnv* jniEnv, const CppType& c);

private:
    NativeConfigKeyValue();
    friend ::djinni::JniClass<NativeConfigKeyValue>;

    const ::djinni::GlobalRef<jclass> clazz { ::djinni::jniFindClass("dyno/fun/lapse/ConfigKeyValue") };
    const jmethodID jconstructor { ::djinni::jniGetMethodID(clazz.get(), "<init>", "()V") };
};

}  // namespace djinni_generated