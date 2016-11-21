//
//  FVSlideTransitionAnimator.m
//  FVCustomTransition
//
//  Created by iforvert on 2016/11/11.
//  Copyright © 2016年 iforvert. All rights reserved.
//  代码地址: https://github.com/Upliver/FVCustomTransition

#import "FVSlideTransitionAnimator.h"

@implementation FVSlideTransitionAnimator

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
    CGRect offScreenFrame = [self rectOffsetFromRect:initialFrame atEdge:self.edge];
    
    // Presenting
    if (self.appearing)
    {
        // Position the view offscreen;
        toView.frame = offScreenFrame;
        [containerView addSubview:toView];
        
        // Animate the view onscreen
        [UIView animateWithDuration:duration animations:^{
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
        
        // Animate the view offscreen
        [UIView animateWithDuration:duration animations:^{
            fromView.frame = offScreenFrame;
        } completion:^(BOOL finished) {
            [fromView removeFromSuperview];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
    
}

+ (NSDictionary *)edgeDisplayName
{
    return @{@(FVEdgeTop) : @"Top",
             @(FVEdgeLeft) : @"Left",
             @(FVEdgeBottom) : @"Bottom",
             @(FVEdgeRight) : @"Right",
             @(FVEdgeTopRight) : @"Top-Right",
             @(FVEdgeTopLeft) : @"Top-Left",
             @(FVEdgeBottomRight) : @"Bottom-Right",
             @(FVEdgeBottomLeft) : @"Bottom-Left"};
}

- (CGRect)rectOffsetFromRect:(CGRect)rect atEdge:(FVEdge)edge
{
    CGRect offsetRect = rect;
    
    switch (edge) {
        case FVEdgeTop: {
            offsetRect.origin.y -= CGRectGetHeight(rect);
            break;
        }
        case FVEdgeLeft: {
            offsetRect.origin.x -= CGRectGetWidth(rect);
            break;
        }
        case FVEdgeBottom: {
            offsetRect.origin.y += CGRectGetHeight(rect);
            break;
        }
        case FVEdgeRight: {
            offsetRect.origin.x += CGRectGetWidth(rect);
            break;
        }
        case FVEdgeTopRight: {
            offsetRect.origin.y -= CGRectGetHeight(rect);
            offsetRect.origin.x += CGRectGetWidth(rect);
            break;
        }
        case FVEdgeTopLeft: {
            offsetRect.origin.y -= CGRectGetHeight(rect);
            offsetRect.origin.x -= CGRectGetWidth(rect);
            break;
        }
        case FVEdgeBottomRight: {
            offsetRect.origin.y += CGRectGetHeight(rect);
            offsetRect.origin.x += CGRectGetWidth(rect);
            break;
        }
        case FVEdgeBottomLeft: {
            offsetRect.origin.y += CGRectGetHeight(rect);
            offsetRect.origin.x -= CGRectGetWidth(rect);
            break;
        }
        default:
            break;
    }
    
    return offsetRect;
}


@end
