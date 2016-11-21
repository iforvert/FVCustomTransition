//
//  FVBounceTransitionAnimtor.h
//  FVCustomTransition
//
//  Created by iforvert on 2016/11/14.
//  Copyright © 2016年 iforvert. All rights reserved.
//  代码地址: https://github.com/Upliver/FVCustomTransition

#import "FVSlideTransitionAnimator.h"

@interface FVBounceTransitionAnimtor : FVSlideTransitionAnimator

@property (nonatomic, assign) CGFloat dampingRatio;
@property (nonatomic, assign) CGFloat velocity;

@end
