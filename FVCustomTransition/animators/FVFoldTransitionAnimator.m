//
//  FVFoldTransitionAnimator.m
//  FVCustomTransition
//
//  Created by iforvert on 2016/11/14.
//  Copyright © 2016年 iforvert. All rights reserved.
//

#import "FVFoldTransitionAnimator.h"

static CGFloat const kInitialScale = 0.001;

@implementation FVFoldTransitionAnimator

#pragma mark - UIViewControllerAnimatedTransitioning

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromVc.view;
    UIView *toView = toVc.view;
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    UIView *fullScreenShotView;
    if (self.isAppearing)
    {
        fullScreenShotView = [toView snapshotViewAfterScreenUpdates:YES];
    }
    else
    {
        fullScreenShotView = [fromView snapshotViewAfterScreenUpdates:NO];
    }
    CGRect initialFrame = [transitionContext initialFrameForViewController:fromVc];
    
    // Bottom Left Quadrant
    CGRect bottomLeftRect = CGRectMake(CGRectGetMinX(initialFrame),
                                       CGRectGetMidY(initialFrame),
                                       CGRectGetWidth(initialFrame) / 2.0,
                                       CGRectGetHeight(initialFrame) / 2.0);
    
    UIView *bottomLeftSnapshot = [fullScreenShotView resizableSnapshotViewFromRect:bottomLeftRect
                                                          afterScreenUpdates:NO
                                                               withCapInsets:UIEdgeInsetsZero];
    
    // Bottom Right Quadrant
    CGRect bottomRightRect = CGRectMake(CGRectGetMidX(initialFrame),
                                        CGRectGetMidY(initialFrame),
                                        CGRectGetWidth(initialFrame) / 2.0,
                                        CGRectGetHeight(initialFrame) / 2.0);
    
    UIView *bottomRightSnapshot = [fullScreenShotView resizableSnapshotViewFromRect:bottomRightRect
                                                           afterScreenUpdates:NO
                                                                withCapInsets:UIEdgeInsetsZero];
    
    // Top Half
    CGRect topHalfRect = CGRectMake(CGRectGetMinX(initialFrame),
                                    CGRectGetMinY(initialFrame),
                                    CGRectGetWidth(initialFrame),
                                    CGRectGetHeight(initialFrame) / 2.0);
    
    UIView *topHalfSnapshot = [fullScreenShotView resizableSnapshotViewFromRect:topHalfRect
                                                       afterScreenUpdates:NO
                                                            withCapInsets:UIEdgeInsetsZero];
    
    // Bottom Half
    CGRect bottomHalfRect = CGRectMake(CGRectGetMinX(initialFrame),
                                       CGRectGetMidY(initialFrame),
                                       CGRectGetWidth(initialFrame),
                                       CGRectGetHeight(initialFrame) / 2.0);
    
    UIView *bottomHalfSnapshot = [fullScreenShotView resizableSnapshotViewFromRect:bottomHalfRect
                                                          afterScreenUpdates:NO
                                                               withCapInsets:UIEdgeInsetsZero];
    
    // Presenting
    if (self.appearing) {
        
        bottomRightSnapshot.transform = CGAffineTransformMakeScale(-kInitialScale, -kInitialScale);
        [containerView addSubview:bottomRightSnapshot];
        
        bottomLeftSnapshot.alpha = 0.0;
        bottomLeftSnapshot.transform = CGAffineTransformMakeScale(1, -1);
        [containerView insertSubview:bottomLeftSnapshot belowSubview:bottomRightSnapshot];
        
        bottomHalfSnapshot.alpha = 0.0;
        bottomHalfSnapshot.transform = CGAffineTransformMakeScale(1, -1);
        bottomHalfSnapshot.layer.anchorPoint = CGPointMake(0.5, 0.0);
        bottomHalfSnapshot.layer.position = CGPointMake(bottomHalfSnapshot.layer.position.x, CGRectGetMidY(initialFrame));
        [containerView addSubview:bottomHalfSnapshot];
        
        topHalfSnapshot.alpha = 0.0;
        [containerView insertSubview:topHalfSnapshot belowSubview:bottomHalfSnapshot];

        
        [UIView animateKeyframesWithDuration:duration delay:0.0 options:0 animations:^{
            
            [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.33 animations:^{
                bottomRightSnapshot.transform = CGAffineTransformMakeScale(-1, -1);
                bottomRightSnapshot.layer.anchorPoint = CGPointMake(0.0, 0.5);
                bottomRightSnapshot.layer.position = CGPointMake(CGRectGetMidX(initialFrame), bottomRightSnapshot.layer.position.y);
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.33 relativeDuration:0 animations:^{
                bottomLeftSnapshot.alpha = 1.0;
            }];

            [UIView addKeyframeWithRelativeStartTime:0.33 relativeDuration:0.33 animations:^{
                CATransform3D rotationTransform = CATransform3DMakeAffineTransform(bottomRightSnapshot.transform);
                rotationTransform = CATransform3DRotate(rotationTransform, M_PI, 0.0, 1.0, 0.0);
                bottomRightSnapshot.layer.transform = rotationTransform;
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.66 relativeDuration:0 animations:^{
                bottomHalfSnapshot.alpha = 1.0;
                topHalfSnapshot.alpha = 1.0;
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.66 relativeDuration:0.34 animations:^{
                CATransform3D rotationTransform = CATransform3DMakeAffineTransform(bottomHalfSnapshot.transform);
                rotationTransform = CATransform3DRotate(rotationTransform, M_PI - 0.01, 1.0, 0.0, 0.0);
                bottomHalfSnapshot.layer.transform = rotationTransform;
            }];
            
        } completion:^(BOOL finished) {
            [bottomRightSnapshot removeFromSuperview];
            [bottomLeftSnapshot removeFromSuperview];
            [bottomHalfSnapshot removeFromSuperview];
            [topHalfSnapshot removeFromSuperview];
            
            [containerView addSubview:toView];
            
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
    // Dismissing
    else {
        
        [fromView removeFromSuperview];
        
        [containerView addSubview:toView];
        
        bottomRightSnapshot.alpha = 0.0;
        bottomRightSnapshot.transform = CGAffineTransformMakeScale(1, -1);
        bottomRightSnapshot.layer.anchorPoint = CGPointMake(0.0, 0.5);
        bottomRightSnapshot.layer.position = CGPointMake(CGRectGetMidX(initialFrame), bottomRightSnapshot.layer.position.y);
        [containerView addSubview:bottomRightSnapshot];
        
        bottomLeftSnapshot.alpha = 0.0;
        bottomLeftSnapshot.transform = CGAffineTransformMakeScale(1, -1);
        [containerView insertSubview:bottomLeftSnapshot belowSubview:bottomRightSnapshot];
        
        bottomHalfSnapshot.layer.anchorPoint = CGPointMake(0.5, 0.0);
        bottomHalfSnapshot.layer.position = CGPointMake(bottomHalfSnapshot.layer.position.x, CGRectGetMidY(initialFrame));
        [containerView addSubview:bottomHalfSnapshot];
        
        [containerView insertSubview:topHalfSnapshot belowSubview:bottomHalfSnapshot];
        
        [UIView animateKeyframesWithDuration:duration delay:0.0 options:0 animations:^{
            
            [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.33 animations:^{
                CATransform3D rotationTransform = CATransform3DMakeAffineTransform(bottomHalfSnapshot.transform);
                rotationTransform = CATransform3DRotate(rotationTransform, M_PI - 0.01, 1.0f, 0.0f, 0.0f);
                bottomHalfSnapshot.layer.transform = rotationTransform;
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.33 relativeDuration:0 animations:^{
                bottomRightSnapshot.alpha = 1.0;
                bottomLeftSnapshot.alpha = 1.0;
                bottomHalfSnapshot.alpha = 0.0;
                topHalfSnapshot.alpha = 0.0;
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.33 relativeDuration:0.33 animations:^{
                CATransform3D rotationTransform = CATransform3DMakeAffineTransform(bottomRightSnapshot.transform);
                rotationTransform = CATransform3DRotate(rotationTransform, -(M_PI - 0.01), 0.0f, 1.0f, 0.0f);
                bottomRightSnapshot.layer.transform = rotationTransform;
            }];
            
            [UIView addKeyframeWithRelativeStartTime:0.66 relativeDuration:0.34 animations:^{
                CGAffineTransform transform = CGAffineTransformMakeTranslation(-CGRectGetMidX(bottomRightSnapshot.bounds), 0);
                bottomRightSnapshot.transform = CGAffineTransformScale(transform, kInitialScale, kInitialScale);
                bottomLeftSnapshot.transform = CGAffineTransformMakeScale(kInitialScale, kInitialScale);
            }];
            
        } completion:^(BOOL finished) {
            [bottomRightSnapshot removeFromSuperview];
            [bottomLeftSnapshot removeFromSuperview];
            [bottomHalfSnapshot removeFromSuperview];
            [topHalfSnapshot removeFromSuperview];
            
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
    
}

@end
