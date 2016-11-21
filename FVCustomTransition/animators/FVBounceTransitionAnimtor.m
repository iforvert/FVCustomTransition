//
//  FVBounceTransitionAnimtor.m
//  FVCustomTransition
//
//  Created by iforvert on 2016/11/14.
//  Copyright © 2016年 iforvert. All rights reserved.
//  代码地址: https://github.com/Upliver/FVCustomTransition

#import "FVBounceTransitionAnimtor.h"

static CGFloat const kDefaultDampingRatio = 0.5;
static CGFloat const kDefaultVelocity = 4.0;

@implementation FVBounceTransitionAnimtor

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.dampingRatio = kDefaultDampingRatio;
        self.velocity = kDefaultVelocity;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    CGRect initialFrame = [transitionContext initialFrameForViewController:fromVC];
    CGRect offScreenRect = [self rectOffsetFromRect:initialFrame atEdge:self.edge];
    
    // Presenting
    if (self.appearing)
    {
        toView.frame = offScreenRect;
        [containerView addSubview:toView];
        
        [UIView animateWithDuration:duration
                              delay:0
             usingSpringWithDamping:self.dampingRatio
              initialSpringVelocity:self.velocity
                            options:0
                         animations:^{
            toView.frame = initialFrame;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
    // Dissmissing
    else
    {
        [containerView addSubview:toView];
        [containerView sendSubviewToBack:toView];
        
        [UIView animateWithDuration:duration
                              delay:0
             usingSpringWithDamping:self.dampingRatio
              initialSpringVelocity:self.velocity
                            options:0
                         animations: ^{
                             fromView.frame = offScreenRect;
                         } completion: ^(BOOL finished) {
                             [fromView removeFromSuperview];
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         }];
    }
    
}

@end
