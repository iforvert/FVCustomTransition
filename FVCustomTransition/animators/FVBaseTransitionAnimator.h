//
//  FVBaseTransitionAnimator.h
//  FVCustomTransition
//
//  Created by iforvert on 2016/11/11.
//  Copyright © 2016年 iforvert. All rights reserved.
//  代码地址: https://github.com/Upliver/FVCustomTransition

@import UIKit;

@interface FVBaseTransitionAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign, getter = isAppearing) BOOL appearing;
@property (nonatomic, assign) NSTimeInterval duration;

@end
