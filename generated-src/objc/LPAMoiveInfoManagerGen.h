// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from lapse.djinni

#import <Foundation/Foundation.h>
@class LPAMoiveInfoGen;
@class LPAMoiveInfoManagerGen;


@interface LPAMoiveInfoManagerGen : NSObject

+ (nullable LPAMoiveInfoManagerGen *)instance;

- (BOOL)initialize:(nonnull NSString *)config;

- (nullable LPAMoiveInfoGen *)createMoiveInfo:(nonnull NSString *)path;

- (nullable LPAMoiveInfoGen *)findMoiveInfo:(nonnull NSString *)name;

- (void)removeMoiveInfo:(nonnull NSString *)name;

- (void)save;

@end
