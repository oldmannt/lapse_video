// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from lapse.djinni

#import <Foundation/Foundation.h>
@class LPAProjectCellGen;


@interface LPAProjectCellGen : NSObject

+ (nullable LPAProjectCellGen *)create:(nonnull NSString *)path
                                  outW:(int32_t)outW
                                  outH:(int32_t)outH;

- (nonnull NSString *)getPath;

- (nonnull NSString *)getName;

- (nonnull NSString *)getCreateTime;

- (nonnull NSString *)getLength;

- (nonnull NSString *)getFps;

- (nonnull NSString *)getRecordDuration;

@end
