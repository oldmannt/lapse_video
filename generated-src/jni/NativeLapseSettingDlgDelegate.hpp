// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from lapse.djinni

#pragma once

#include "djinni_support.hpp"
#include "lapse_setting_dlg_delegate.hpp"

namespace djinni_generated {

class NativeLapseSettingDlgDelegate final : ::djinni::JniInterface<::lpase::LapseSettingDlgDelegate, NativeLapseSettingDlgDelegate> {
public:
    using CppType = std::shared_ptr<::lpase::LapseSettingDlgDelegate>;
    using CppOptType = std::shared_ptr<::lpase::LapseSettingDlgDelegate>;
    using JniType = jobject;

    using Boxed = NativeLapseSettingDlgDelegate;

    ~NativeLapseSettingDlgDelegate();

    static CppType toCpp(JNIEnv* jniEnv, JniType j) { return ::djinni::JniClass<NativeLapseSettingDlgDelegate>::get()._fromJava(jniEnv, j); }
    static ::djinni::LocalRef<JniType> fromCppOpt(JNIEnv* jniEnv, const CppOptType& c) { return {jniEnv, ::djinni::JniClass<NativeLapseSettingDlgDelegate>::get()._toJava(jniEnv, c)}; }
    static ::djinni::LocalRef<JniType> fromCpp(JNIEnv* jniEnv, const CppType& c) { return fromCppOpt(jniEnv, c); }

private:
    NativeLapseSettingDlgDelegate();
    friend ::djinni::JniClass<NativeLapseSettingDlgDelegate>;
    friend ::djinni::JniInterface<::lpase::LapseSettingDlgDelegate, NativeLapseSettingDlgDelegate>;

    class JavaProxy final : ::djinni::JavaProxyHandle<JavaProxy>, public ::lpase::LapseSettingDlgDelegate
    {
    public:
        JavaProxy(JniType j);
        ~JavaProxy();

        void updateSegMode(::lpase::IntervalMode mode) override;
        void updateFps(int32_t fps) override;
        void updateLapse(float lapse) override;
        int32_t getFps() override;
        float getLapse() override;

    private:
        friend ::djinni::JniInterface<::lpase::LapseSettingDlgDelegate, ::djinni_generated::NativeLapseSettingDlgDelegate>;
    };

    const ::djinni::GlobalRef<jclass> clazz { ::djinni::jniFindClass("dyno/fun/lapse/LapseSettingDlgDelegate") };
    const jmethodID method_updateSegMode { ::djinni::jniGetMethodID(clazz.get(), "updateSegMode", "(Ldyno/fun/lapse/IntervalMode;)V") };
    const jmethodID method_updateFps { ::djinni::jniGetMethodID(clazz.get(), "updateFps", "(I)V") };
    const jmethodID method_updateLapse { ::djinni::jniGetMethodID(clazz.get(), "updateLapse", "(F)V") };
    const jmethodID method_getFps { ::djinni::jniGetMethodID(clazz.get(), "getFps", "()I") };
    const jmethodID method_getLapse { ::djinni::jniGetMethodID(clazz.get(), "getLapse", "()F") };
};

}  // namespace djinni_generated
