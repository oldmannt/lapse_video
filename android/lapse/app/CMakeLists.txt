# Sets the minimum version of CMake required to build the native
# library. You should either keep the default value or only pass a
# value of 3.4.0 or lower.

cmake_minimum_required(VERSION 3.4.1)
set(CMAKE_VERBOSE_MAKEFILE on)

# Creates and names a library, sets it as either STATIC
# or SHARED, and provides the relative paths to its source code.
# You can define multiple libraries, and CMake builds it for you.
# Gradle automatically packages shared libraries with your APK.

include_directories(../../../gearsbox/src/cpp/ui)
include_directories(../../../gearsbox/deps/djinni/support-lib)
include_directories(../../../gearsbox/deps/djinni/support-lib/jni)
include_directories(../../../gearsbox/generated-src/cpp)
include_directories(../../../gearsbox/generated-src/jni)
include_directories(../../../gearsbox/deps/curl)
include_directories(../../../gearsbox/deps/libuv/include)
include_directories(../../../gearsbox/deps/libuv/src)
include_directories(../../../gearsbox/deps/sqlite3)
include_directories(../../../gearsbox/src)
include_directories(../../../gearsbox/interface)

file(GLOB_RECURSE DJINNI    ../../../gearsbox/deps/djinni/support-lib/jni/*.c* *.h*)
file(GLOB_RECURSE GEARS_GEN ../../../gearsbox/generated-src/*.c* *.h*)
file(GLOB_RECURSE CURL      ../../../gearsbox/deps/curl/*.c* *.h*)
file(GLOB_RECURSE GEARS_SRC ../../../gearsbox/src/*.c* *.h*)

file(GLOB_RECURSE LIBUV ../../../gearsbox/deps/libuv/src/fs-poll.c
../../../gearsbox/deps/libuv/src/inet.c
../../../gearsbox/deps/libuv/src/threadpool.c
../../../gearsbox/deps/libuv/src/uv-common.c
../../../gearsbox/deps/libuv/src/version.c
../../../gearsbox/deps/libuv/src/unix/async.c
../../../gearsbox/deps/libuv/src/unix/core.c
../../../gearsbox/deps/libuv/src/unix/dl.c
../../../gearsbox/deps/libuv/src/unix/fs.c
../../../gearsbox/deps/libuv/src/unix/getaddrinfo.c
../../../gearsbox/deps/libuv/src/unix/getnameinfo.c
../../../gearsbox/deps/libuv/src/unix/loop.c
../../../gearsbox/deps/libuv/src/unix/loop-watcher.c
../../../gearsbox/deps/libuv/src/unix/pipe.c
../../../gearsbox/deps/libuv/src/unix/poll.c
../../../gearsbox/deps/libuv/src/unix/process.c
../../../gearsbox/deps/libuv/src/unix/signal.c
../../../gearsbox/deps/libuv/src/unix/stream.c
../../../gearsbox/deps/libuv/src/unix/tcp.c
../../../gearsbox/deps/libuv/src/unix/thread.c
../../../gearsbox/deps/libuv/src/unix/timer.c
../../../gearsbox/deps/libuv/src/unix/tty.c
../../../gearsbox/deps/libuv/src/unix/udp.c
../../../gearsbox/deps/libuv/src/unix/proctitle.c
../../../gearsbox/deps/libuv/src/unix/linux-core.c
../../../gearsbox/deps/libuv/src/unix/linux-inotify.c
../../../gearsbox/deps/libuv/src/unix/linux-syscalls.c
../../../gearsbox/deps/libuv/src/unix/pthread-fixes.c
../../../gearsbox/deps/libuv/src/unix/android-ifaddrs.c
../../../gearsbox/deps/libuv/src/unix/pthread-barrier.c)


include_directories(../../../cpp)
include_directories(../../../generated-src/cpp)
include_directories(../../../generated-src/jni)
file(GLOB_RECURSE LAPSE_SRC ../../../cpp/*.c* *.h*)
file(GLOB_RECURSE LAPSE_GEN ../../../generated-src/*.c* *.h*)

add_library(lapse_jni SHARED ${DJINNI} ${GEARS_GEN} ${CURL} ${LIBUV} ${GEARS_SRC} ${LAPSE_SRC} ${LAPSE_GEN})
target_link_libraries(lapse_jni android log dl)

# Searches for a specified prebuilt library and stores the path as a
# variable. Because system libraries are included in the search path by
# default, you only need to specify the name of the public NDK library
# you want to add. CMake verifies that the library exists before
# completing its build.

#find_library( # Sets the name of the path variable.
#              log-lib
#
              # Specifies the name of the NDK library that
              # you want CMake to locate.
#              log )

# Specifies libraries CMake should link to your target library. You
# can link multiple libraries, such as libraries you define in the
# build script, prebuilt third-party libraries, or system libraries.

#target_link_libraries( # Specifies the target library.
#                       native-lib

                       # Links the target library to the log library
                       # included in the NDK.
#                       ${log-lib} )
