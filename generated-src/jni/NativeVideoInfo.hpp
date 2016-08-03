// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from lapse.djinni

#pragma once

#include "djinni_support.hpp"
#include "video_info.hpp"

namespace djinni_generated {

class NativeVideoInfo final {
public:
    using CppType = ::lpase::VideoInfo;
    using JniType = jobject;

    using Boxed = NativeVideoInfo;

    ~NativeVideoInfo();

    static CppType toCpp(JNIEnv* jniEnv, JniType j);
    static ::djinni::LocalRef<JniType> fromCpp(JNIEnv* jniEnv, const CppType& c);

private:
    NativeVideoInfo();
    friend ::djinni::JniClass<NativeVideoInfo>;

    const ::djinni::GlobalRef<jclass> clazz { ::djinni::jniFindClass("dyno/fun/lapse/VideoInfo") };
    const jmethodID jconstructor { ::djinni::jniGetMethodID(clazz.get(), "<init>", "(FIIII)V") };
    const jfieldID field_mInterval { ::djinni::jniGetFieldID(clazz.get(), "mInterval", "F") };
    const jfieldID field_mFps { ::djinni::jniGetFieldID(clazz.get(), "mFps", "I") };
    const jfieldID field_mResolution { ::djinni::jniGetFieldID(clazz.get(), "mResolution", "I") };
    const jfieldID field_mExposure { ::djinni::jniGetFieldID(clazz.get(), "mExposure", "I") };
    const jfieldID field_mIso { ::djinni::jniGetFieldID(clazz.get(), "mIso", "I") };
};

}  // namespace djinni_generated
