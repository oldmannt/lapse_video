#include <jni.h>
#include <string>

extern "C"
jstring
Java_fun_dyno_lapse_CaptureActivity_stringFromJNI(
        JNIEnv *env,
        jobject /* this */) {
    std::string hello = "Hello from C++";
    return env->NewStringUTF(hello.c_str());
}
