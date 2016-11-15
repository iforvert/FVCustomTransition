//
//  FVDropTransitionAnimator.h
//  FVCustomTransition
//
//  Created by iforvert on 2016/11/15.
//  Copyright © 2016年 iforvert. All rights reserved.
//

#import "FVBaseTransitionAnimator.h"

@interface FVDropTransitionAnimator : UIDynamicBehavior <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign, getter = isAppearing) BOOL appearing;
@property (nonatomic, assign) NSTimeInterval duration;

@end
