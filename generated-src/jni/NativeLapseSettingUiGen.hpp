// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from lapse.djinni

#pragma once

#include "djinni_support.hpp"
#include "lapse_setting_ui_gen.hpp"

namespace djinni_generated {

class NativeLapseSettingUiGen final : ::djinni::JniInterface<::lpase::LapseSettingUiGen, NativeLapseSettingUiGen> {
public:
    using CppType = std::shared_ptr<::lpase::LapseSettingUiGen>;
    using CppOptType = std::shared_ptr<::lpase::LapseSettingUiGen>;
    using JniType = jobject;

    using Boxed = NativeLapseSettingUiGen;

    ~NativeLapseSettingUiGen();

    static CppType toCpp(JNIEnv* jniEnv, JniType j) { return ::djinni::JniClass<NativeLapseSettingUiGen>::get()._fromJava(jniEnv, j); }
    static ::djinni::LocalRef<JniType> fromCppOpt(JNIEnv* jniEnv, const CppOptType& c) { return {jniEnv, ::djinni::JniClass<NativeLapseSettingUiGen>::get()._toJava(jniEnv, c)}; }
    static ::djinni::LocalRef<JniType> fromCpp(JNIEnv* jniEnv, const CppType& c) { return fromCppOpt(jniEnv, c); }

private:
    NativeLapseSettingUiGen();
    friend ::djinni::JniClass<NativeLapseSettingUiGen>;
    friend ::djinni::JniInterface<::lpase::LapseSettingUiGen, NativeLapseSettingUiGen>;

    class JavaProxy final : ::djinni::JavaProxyHandle<JavaProxy>, public ::lpase::LapseSettingUiGen
    {
    public:
        JavaProxy(JniType j);
        ~JavaProxy();

        void initializeSliberFps(int32_t min, int32_t max) override;
        void initializeSliberLapse(int32_t min, int32_t max) override;
        void updateFps(int32_t fps) override;
        void updateLapse(int32_t lapse) override;
        void updatePicker(int32_t index) override;

    private:
        friend ::djinni::JniInterface<::lpase::LapseSettingUiGen, ::djinni_generated::NativeLapseSettingUiGen>;
    };

    const ::djinni::GlobalRef<jclass> clazz { ::djinni::jniFindClass("dyno/fun/lapse/LapseSettingUiGen") };
    const jmethodID method_initializeSliberFps { ::djinni::jniGetMethodID(clazz.get(), "initializeSliberFps", "(II)V") };
    const jmethodID method_initializeSliberLapse { ::djinni::jniGetMethodID(clazz.get(), "initializeSliberLapse", "(II)V") };
    const jmethodID method_updateFps { ::djinni::jniGetMethodID(clazz.get(), "updateFps", "(I)V") };
    const jmethodID method_updateLapse { ::djinni::jniGetMethodID(clazz.get(), "updateLapse", "(I)V") };
    const jmethodID method_updatePicker { ::djinni::jniGetMethodID(clazz.get(), "updatePicker", "(I)V") };
};

}  // namespace djinni_generated
