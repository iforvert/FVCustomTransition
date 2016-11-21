//
//  FVConfigOption.m
//  FVCustomTransition
//
//  Created by iforvert on 2016/11/11.
//  Copyright © 2016年 iforvert. All rights reserved.
//  代码地址: https://github.com/Upliver/FVCustomTransition

#import "FVConfigOption.h"

static NSString * const kPushTransitionsKey = @"pushTransitions";
static NSString * const kDurationKey        = @"duration";
static NSString * const kEdgeKey            = @"edge";
static NSString * const kDampingRatioKey    = @"dampingRatio";
static NSString * const kVelocityKey        = @"velocity";
static NSString * const kSpringDurationKey  = @"springDuration";
static NSString * const kFoldDurationKey    = @"foldDuration";

@implementation FVConfigOption

+ (instancetype)sharedConfigOptions
{
    static FVConfigOption *_sharedOption = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedOption = [[self alloc] init];
    });
    return _sharedOption;
}

#pragma mark - Setter & Getter

- (BOOL)pushTransition
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kPushTransitionsKey];
}

- (void)setPushTransition:(BOOL)pushTransition
{
    [[NSUserDefaults standardUserDefaults] setBool:pushTransition forKey:kPushTransitionsKey];
}

- (NSTimeInterval)duration
{
    return [[NSUserDefaults standardUserDefaults] doubleForKey:kDurationKey];
}

- (void)setDuration:(NSTimeInterval)duration
{
    [[NSUserDefaults standardUserDefaults] setDouble:duration forKey:kDurationKey];
}

- (FVEdge)edge
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:kEdgeKey];
}

- (void)setEdge:(FVEdge)edge
{
    [[NSUserDefaults standardUserDefaults] setInteger:edge forKey:kEdgeKey];
}

- (CGFloat)dampingRatio
{
    return [[NSUserDefaults standardUserDefaults] doubleForKey:kDampingRatioKey];
}

- (void)setDampingRatio:(CGFloat)dampingRatio
{
    [[NSUserDefaults standardUserDefaults] setDouble:dampingRatio forKey:kDampingRatioKey];
}

- (CGFloat)velocity
{
    return [[NSUserDefaults standardUserDefaults] doubleForKey:kVelocityKey];
}

- (void)setVelocity:(CGFloat)velocity
{
    [[NSUserDefaults standardUserDefaults] setDouble:velocity forKey:kVelocityKey];
}

- (NSTimeInterval)springDuration
{
    return [[NSUserDefaults standardUserDefaults] doubleForKey:kSpringDurationKey];
}

- (void)setSpringDuration:(NSTimeInterval)springDuration
{
    [[NSUserDefaults standardUserDefaults] setDouble:springDuration forKey:kSpringDurationKey];
}

- (NSTimeInterval)foldDuration
{
    return [[NSUserDefaults standardUserDefaults] doubleForKey:kFoldDurationKey];
}

- (void)setFoldDuration:(NSTimeInterval)foldDuration
{
    [[NSUserDefaults standardUserDefaults] setDouble:foldDuration forKey:kFoldDurationKey];
}

@end
