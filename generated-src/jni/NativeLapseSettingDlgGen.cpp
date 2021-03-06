// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from lapse.djinni

#include "NativeLapseSettingDlgGen.hpp"  // my header
#include "Marshal.hpp"
#include "NativeIntervalMode.hpp"
#include "NativeLapseSettingDlgDelegate.hpp"
#include "NativeLapseSettingDlgGen.hpp"

namespace djinni_generated {

NativeLapseSettingDlgGen::NativeLapseSettingDlgGen() : ::djinni::JniInterface<::lpase::LapseSettingDlgGen, NativeLapseSettingDlgGen>("dyno/fun/lapse/LapseSettingDlgGen$CppProxy") {}

NativeLapseSettingDlgGen::~NativeLapseSettingDlgGen() = default;


CJNIEXPORT void JNICALL Java_dyno_fun_lapse_LapseSettingDlgGen_00024CppProxy_nativeDestroy(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        delete reinterpret_cast<::djinni::CppProxyHandle<::lpase::LapseSettingDlgGen>*>(nativeRef);
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, )
}

CJNIEXPORT jobject JNICALL Java_dyno_fun_lapse_LapseSettingDlgGen_instance(JNIEnv* jniEnv, jobject /*this*/)
{
    try {
        DJINNI_FUNCTION_PROLOGUE0(jniEnv);
        auto r = ::lpase::LapseSettingDlgGen::instance();
        return ::djinni::release(::djinni_generated::NativeLapseSettingDlgGen::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT void JNICALL Java_dyno_fun_lapse_LapseSettingDlgGen_00024CppProxy_native_1onLoad(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef, jobject j_delegate)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::LapseSettingDlgGen>(nativeRef);
        ref->onLoad(::djinni_generated::NativeLapseSettingDlgDelegate::toCpp(jniEnv, j_delegate));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, )
}

CJNIEXPORT void JNICALL Java_dyno_fun_lapse_LapseSettingDlgGen_00024CppProxy_native_1onShow(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::LapseSettingDlgGen>(nativeRef);
        ref->onShow();
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, )
}

CJNIEXPORT jboolean JNICALL Java_dyno_fun_lapse_LapseSettingDlgGen_00024CppProxy_native_1onFpsChange(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef, jint j_fps)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::LapseSettingDlgGen>(nativeRef);
        auto r = ref->onFpsChange(::djinni::I32::toCpp(jniEnv, j_fps));
        return ::djinni::release(::djinni::Bool::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jboolean JNICALL Java_dyno_fun_lapse_LapseSettingDlgGen_00024CppProxy_native_1onLapseChange(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef, jobject j_mode, jfloat j_lapse)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::LapseSettingDlgGen>(nativeRef);
        auto r = ref->onLapseChange(::djinni_generated::NativeIntervalMode::toCpp(jniEnv, j_mode),
                                    ::djinni::F32::toCpp(jniEnv, j_lapse));
        return ::djinni::release(::djinni::Bool::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT void JNICALL Java_dyno_fun_lapse_LapseSettingDlgGen_00024CppProxy_native_1onSelectInterval(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef, jobject j_mode)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::LapseSettingDlgGen>(nativeRef);
        ref->onSelectInterval(::djinni_generated::NativeIntervalMode::toCpp(jniEnv, j_mode));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, )
}

CJNIEXPORT jboolean JNICALL Java_dyno_fun_lapse_LapseSettingDlgGen_00024CppProxy_native_1onSave(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef, jint j_fps, jfloat j_lapse, jobject j_mode)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::LapseSettingDlgGen>(nativeRef);
        auto r = ref->onSave(::djinni::I32::toCpp(jniEnv, j_fps),
                             ::djinni::F32::toCpp(jniEnv, j_lapse),
                             ::djinni_generated::NativeIntervalMode::toCpp(jniEnv, j_mode));
        return ::djinni::release(::djinni::Bool::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

}  // namespace djinni_generated
