// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from lapse.djinni

#import "LPAIntervalMode.h"
#import <Foundation/Foundation.h>


@protocol LPALapseSettingDlgDelegate

- (void)updateSegMode:(LPAIntervalMode)mode;

- (void)updateFps:(int32_t)fps;

- (void)updateLapse:(float)lapse;

- (int32_t)getFps;

- (float)getLapse;

@end