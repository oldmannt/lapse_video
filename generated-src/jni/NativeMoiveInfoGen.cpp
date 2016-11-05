// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from lapse.djinni

#include "NativeMoiveInfoGen.hpp"  // my header
#include "Marshal.hpp"

namespace djinni_generated {

NativeMoiveInfoGen::NativeMoiveInfoGen() : ::djinni::JniInterface<::lpase::MoiveInfoGen, NativeMoiveInfoGen>("dyno/fun/lapse/MoiveInfoGen$CppProxy") {}

NativeMoiveInfoGen::~NativeMoiveInfoGen() = default;


CJNIEXPORT void JNICALL Java_dyno_fun_lapse_MoiveInfoGen_00024CppProxy_nativeDestroy(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        delete reinterpret_cast<::djinni::CppProxyHandle<::lpase::MoiveInfoGen>*>(nativeRef);
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, )
}

CJNIEXPORT jstring JNICALL Java_dyno_fun_lapse_MoiveInfoGen_00024CppProxy_native_1getName(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::MoiveInfoGen>(nativeRef);
        auto r = ref->getName();
        return ::djinni::release(::djinni::String::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jint JNICALL Java_dyno_fun_lapse_MoiveInfoGen_00024CppProxy_native_1getFrameAmount(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::MoiveInfoGen>(nativeRef);
        auto r = ref->getFrameAmount();
        return ::djinni::release(::djinni::I32::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jfloat JNICALL Java_dyno_fun_lapse_MoiveInfoGen_00024CppProxy_native_1getDurationSecond(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::MoiveInfoGen>(nativeRef);
        auto r = ref->getDurationSecond();
        return ::djinni::release(::djinni::F32::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jfloat JNICALL Java_dyno_fun_lapse_MoiveInfoGen_00024CppProxy_native_1getFPS(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::MoiveInfoGen>(nativeRef);
        auto r = ref->getFPS();
        return ::djinni::release(::djinni::F32::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jfloat JNICALL Java_dyno_fun_lapse_MoiveInfoGen_00024CppProxy_native_1getRecordLapse(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::MoiveInfoGen>(nativeRef);
        auto r = ref->getRecordLapse();
        return ::djinni::release(::djinni::F32::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jfloat JNICALL Java_dyno_fun_lapse_MoiveInfoGen_00024CppProxy_native_1getRecordDuration(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::MoiveInfoGen>(nativeRef);
        auto r = ref->getRecordDuration();
        return ::djinni::release(::djinni::F32::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT jboolean JNICALL Java_dyno_fun_lapse_MoiveInfoGen_00024CppProxy_native_1setName(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef, jstring j_name)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::MoiveInfoGen>(nativeRef);
        auto r = ref->setName(::djinni::String::toCpp(jniEnv, j_name));
        return ::djinni::release(::djinni::Bool::fromCpp(jniEnv, r));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, 0 /* value doesn't matter */)
}

CJNIEXPORT void JNICALL Java_dyno_fun_lapse_MoiveInfoGen_00024CppProxy_native_1setFrameAmount(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef, jint j_amount)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::MoiveInfoGen>(nativeRef);
        ref->setFrameAmount(::djinni::I32::toCpp(jniEnv, j_amount));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, )
}

CJNIEXPORT void JNICALL Java_dyno_fun_lapse_MoiveInfoGen_00024CppProxy_native_1setDurationSecond(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef, jfloat j_seconds)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::MoiveInfoGen>(nativeRef);
        ref->setDurationSecond(::djinni::F32::toCpp(jniEnv, j_seconds));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, )
}

CJNIEXPORT void JNICALL Java_dyno_fun_lapse_MoiveInfoGen_00024CppProxy_native_1setFPS(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef, jfloat j_fps)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::MoiveInfoGen>(nativeRef);
        ref->setFPS(::djinni::F32::toCpp(jniEnv, j_fps));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, )
}

CJNIEXPORT void JNICALL Java_dyno_fun_lapse_MoiveInfoGen_00024CppProxy_native_1setRecordDuration(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef, jfloat j_duration)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::MoiveInfoGen>(nativeRef);
        ref->setRecordDuration(::djinni::F32::toCpp(jniEnv, j_duration));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, )
}

CJNIEXPORT void JNICALL Java_dyno_fun_lapse_MoiveInfoGen_00024CppProxy_native_1setRecordLapse(JNIEnv* jniEnv, jobject /*this*/, jlong nativeRef, jfloat j_lapse)
{
    try {
        DJINNI_FUNCTION_PROLOGUE1(jniEnv, nativeRef);
        const auto& ref = ::djinni::objectFromHandleAddress<::lpase::MoiveInfoGen>(nativeRef);
        ref->setRecordLapse(::djinni::F32::toCpp(jniEnv, j_lapse));
    } JNI_TRANSLATE_EXCEPTIONS_RETURN(jniEnv, )
}

}  // namespace djinni_generated