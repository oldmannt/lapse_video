// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from lapse.djinni

#include "NativeDataGen.hpp"  // my header
#include "Marshal.hpp"
#include "NativeDataGen.hpp"
#include "NativeQuickModeGen.hpp"

namespace djinni_generated {

NativeDataGen::NativeDataGen() : ::djinni::JniInterface<::lpase::DataGen, NativeDataGen>("dyno/fun/lapse/DataGen$CppProxy") {}

NativeDataGen::~NativeDataGen() = default;


CJNIEXPORT void JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_nativeDestroy(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        delete reinterpret_cast<::djinni::CppProxyHandle<::lpase::DataGen>*>(nativeRef);
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, )
}

CJNIEXPORT jobject JNICALL Java_dyno_fun_lapse_DataGen_instance(JNIEnv* jniEnv, jobject /*this*/)
{
    try {
        DJINNI_FUNCTION_PROLOGUE0(jniEnv);
        auto r = ::lpase::DataGen::instance();
        return ::djinni::release(::djinni_generated::NativeDataGen::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jboolean JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1initialize(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef, jstring j_config)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        auto r = ref->initialize(::djinni::String::toCpp(jniEnv, j_config));
        return ::djinni::release(::djinni::Bool::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jstring JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1getProjectsDir(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        auto r = ref->getProjectsDir();
        return ::djinni::release(::djinni::String::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jstring JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1getCaptureMode(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        auto r = ref->getCaptureMode();
        return ::djinni::release(::djinni::String::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT void JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1setCaptureMode(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef, jstring j_mode)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        ref->setCaptureMode(::djinni::String::toCpp(jniEnv, j_mode));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, )
}

CJNIEXPORT jint JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1getCaptureIntevalMillsec(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        auto r = ref->getCaptureIntevalMillsec();
        return ::djinni::release(::djinni::I32::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jint JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1getCaptureInteval(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        auto r = ref->getCaptureInteval();
        return ::djinni::release(::djinni::I32::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jstring JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1getCaptureIntevalUnit(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        auto r = ref->getCaptureIntevalUnit();
        return ::djinni::release(::djinni::String::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT void JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1setCaptureInteval(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef, jint j_value, jstring j_unit)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        ref->setCaptureInteval(::djinni::I32::toCpp(jniEnv, j_value),
                               ::djinni::String::toCpp(jniEnv, j_unit));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, )
}

CJNIEXPORT void JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1setCaptureIntervalQuickMode(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef, jstring j_mode)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        ref->setCaptureIntervalQuickMode(::djinni::String::toCpp(jniEnv, j_mode));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, )
}

CJNIEXPORT jstring JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1getCaptureIntervalQuickMode(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        auto r = ref->getCaptureIntervalQuickMode();
        return ::djinni::release(::djinni::String::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jint JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1getFps(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        auto r = ref->getFps();
        return ::djinni::release(::djinni::I32::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jint JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1getBitrate(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        auto r = ref->getBitrate();
        return ::djinni::release(::djinni::I32::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jint JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1getResolution(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        auto r = ref->getResolution();
        return ::djinni::release(::djinni::I32::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT void JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1setFps(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef, jint j_fps)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        ref->setFps(::djinni::I32::toCpp(jniEnv, j_fps));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, )
}

CJNIEXPORT void JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1setBitrate(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef, jint j_bitrate)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        ref->setBitrate(::djinni::I32::toCpp(jniEnv, j_bitrate));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, )
}

CJNIEXPORT void JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1setResolution(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef, jint j_reso)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        ref->setResolution(::djinni::I32::toCpp(jniEnv, j_reso));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, )
}

CJNIEXPORT jboolean JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1isCaptureModePhoto(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef, jint j_interal)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        auto r = ref->isCaptureModePhoto(::djinni::I32::toCpp(jniEnv, j_interal));
        return ::djinni::release(::djinni::Bool::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jboolean JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1isCaptureImmediate(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef, jint j_interal)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        auto r = ref->isCaptureImmediate(::djinni::I32::toCpp(jniEnv, j_interal));
        return ::djinni::release(::djinni::Bool::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jint JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1getMaxFps(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        auto r = ref->getMaxFps();
        return ::djinni::release(::djinni::I32::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jint JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1getMinFps(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        auto r = ref->getMinFps();
        return ::djinni::release(::djinni::I32::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jint JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1getMinInterval(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        auto r = ref->getMinInterval();
        return ::djinni::release(::djinni::I32::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jint JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1getMaxInterval(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        auto r = ref->getMaxInterval();
        return ::djinni::release(::djinni::I32::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jint JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1getMinLapse(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        auto r = ref->getMinLapse();
        return ::djinni::release(::djinni::I32::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jint JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1getDefaultLapse(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        auto r = ref->getDefaultLapse();
        return ::djinni::release(::djinni::I32::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jint JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1getLapsePauseFps(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        auto r = ref->getLapsePauseFps();
        return ::djinni::release(::djinni::I32::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jboolean JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1isSlowModeEnable(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        auto r = ref->isSlowModeEnable();
        return ::djinni::release(::djinni::Bool::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jint JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1getQuickModeCount(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        auto r = ref->getQuickModeCount();
        return ::djinni::release(::djinni::I32::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jobject JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1getQuickMode(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef, jint j_index)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        auto r = ref->getQuickMode(::djinni::I32::toCpp(jniEnv, j_index));
        return ::djinni::release(::djinni_generated::NativeQuickModeGen::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT void JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1selectQuickMode(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef, jint j_index)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        ref->selectQuickMode(::djinni::I32::toCpp(jniEnv, j_index));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, )
}

CJNIEXPORT jint JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1getCurrentQickMode(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        auto r = ref->getCurrentQickMode();
        return ::djinni::release(::djinni::I32::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jint JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1getUiInfoUpdateRate(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        auto r = ref->getUiInfoUpdateRate();
        return ::djinni::release(::djinni::I32::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jstring JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1getFpsRangeAlert(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        auto r = ref->getFpsRangeAlert();
        return ::djinni::release(::djinni::String::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jstring JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1getLapseRangeAlert(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        auto r = ref->getLapseRangeAlert();
        return ::djinni::release(::djinni::String::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jstring JNICALL Java_dyno_fun_lapse_DataGen_00024CppProxy_native_1getSlomoRangeAlert(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::DataGen>(nativeRef);
        auto r = ref->getSlomoRangeAlert();
        return ::djinni::release(::djinni::String::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

}  // namespace djinni_generated
