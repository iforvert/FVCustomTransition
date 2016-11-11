//
//  FVBaseTransitionAnimator.m
//  FVCustomTransition
//
//  Created by iforvert on 2016/11/11.
//  Copyright © 2016年 iforvert. All rights reserved.
//

#import "FVBaseTransitionAnimator.h"

static NSTimeInterval const kDefaultDuration = 1.0;

@implementation FVBaseTransitionAnimator

- (instancetype)init
{
    if (self = [super init])
    {
        _duration = kDefaultDuration;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

// This is used for percent driven interactive transitions, as well as for
// container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}


// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    // Must be implemented by inheriting class
    [self doesNotRecognizeSelector:_cmd];
}

@end
