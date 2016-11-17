# lapse_video
Capture a photo in specified duration, then make these photo as video. This app makes long duration changing view to tiny duration video, for example, record 1 hours sundowning view as 1-minute video

1. encode lapse video using ffmpeg
2. c++ 11 code crosplatform for iOS and Android.
3. Use djinni generates JNI and ObjectC++ bridge code.
4. Multi-thread programming base on libuv.

iOS alread released on Appstore
android not yet

### How to build ffmpet 3.1.1 and x264 for iOS and Android
I shared the process in below page 
https://github.com/oldmannt/build_x264_ffmpeg_ios_android

### How to use
  ```shell
  make djinni
  ```
  generate C++, objective-C, and Jave interface from djinni files
  ```shell
  make mac_proj
  ```
  generate gtest mac xcode project, unit test for C++ code
  
  ```shell
  make ios_proj
  ```
  generate ios xcode project
  
  ```shell
  make android_proj
  ```
  generate android.mk, but I didn't use it, I prefer cmake in Android Studio

![image](https://github.com/oldmannt/lapse_video/blob/master/data/screen/ios1.PNG) 
![image](https://github.com/oldmannt/lapse_video/blob/master/data/screen/ios2.PNG) 
![image](https://github.com/oldmannt/lapse_video/blob/master/data/screen/ios3.PNG) 

