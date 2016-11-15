//
//  FVConfigOption.h
//  FVCustomTransition
//
//  Created by iforvert on 2016/11/11.
//  Copyright © 2016年 iforvert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FVSlideTransitionAnimator.h"

@interface FVConfigOption : NSObject

// General
@property (nonatomic, assign) BOOL pushTransition;
@property (nonatomic, assign) NSTimeInterval duration;

// Slide
@property (nonatomic, assign) FVEdge edge;

// Bounce
@property (nonatomic, assign) CGFloat dampingRatio;
@property (nonatomic, assign) CGFloat velocity;
@property (nonatomic, assign) NSTimeInterval springDuration;

// Fold
@property (nonatomic, assign) NSTimeInterval foldDuration;

+ (instancetype)sharedConfigOptions;

@end
