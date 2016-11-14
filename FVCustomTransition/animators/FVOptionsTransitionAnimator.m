//
//  FVOptionsTransitionAnimator.m
//  FVCustomTransition
//
//  Created by iforvert on 2016/11/11.
//  Copyright © 2016年 iforvert. All rights reserved.
//

#import "FVOptionsTransitionAnimator.h"

static CGFloat const kInitialScale = 0.01;
static CGFloat const kFinalScale = 0.9;

@implementation FVOptionsTransitionAnimator

#pragma mark - UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromVc.view;
    UIView *toView = toVc.view;
    
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    // Presenting
    if (self.isAppearing)
    {
        fromView.userInteractionEnabled = NO;
        
        toView.layer.cornerRadius = 5;
        toView.layer.masksToBounds = YES;
        
        toView.transform = CGAffineTransformMakeScale(kInitialScale, kInitialScale);
        [containerView addSubview:toView];
        
        [UIView animateWithDuration:duration animations:^{
            toView.transform = CGAffineTransformMakeScale(kFinalScale, kFinalScale);
            fromView.alpha = 0.5;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
    // Dismissing
    else
    {
        [UIView animateWithDuration:duration animations:^{
            fromView.transform = CGAffineTransformMakeScale(kInitialScale, kInitialScale);
            toView.alpha = 1.0;
        } completion:^(BOOL finished) {
            [fromView removeFromSuperview];
            toView.userInteractionEnabled = YES;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}



@end
