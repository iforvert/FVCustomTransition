//
//  FVViewController.m
//  FVCustomTransition
//
//  Created by iforvert on 2016/11/11.
//  Copyright © 2016年 iforvert. All rights reserved.
//

#import "FVViewController.h"
#import "FVConfigOption.h"

#import "FVCofigOptionViewController.h"
#import "FVSlideViewController.h"
#import "FVBounceViewController.h"
#import "FVBounceViewController.h"
#import "FVFoldViewController.h"
#import "FVCollectionViewController.h"
#import "FVDropViewController.h"

#import "FVSlideTransitionAnimator.h"
#import "FVOptionsTransitionAnimator.h"
#import "FVBounceTransitionAnimtor.h"
#import "FVFoldTransitionAnimator.h"
#import "FVDropTransitionAnimator.h"

typedef NS_ENUM(NSInteger, TableViewSection){
    TableViewSectionBasic,
    TableViewSectionSpring,
    TableViewSectionKeyFrame,
    TableViewSectionCollection,
    TableViewSectionDrop,
};

// Segue ids

static NSString * const kSegueSlidPush      = @"slidePush";
static NSString * const kSegueSlidModal     = @"slideModal";
static NSString * const kSegueBouncePush    = @"bouncePush";
static NSString * const kSegueBounceModal   = @"bounceModal";
static NSString * const kSegueFoldPush      = @"foldPush";
static NSString * const kSegueFoldModal     = @"foldModal";
static NSString * const kSegueDropModal     = @"dropModal";

@interface FVViewController ()<UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>

@end

@implementation FVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Slide
    if ([segue.identifier isEqualToString:kSegueSlidModal])
    {
        UIViewController *vc = segue.destinationViewController;
        vc.transitioningDelegate = self;
        
    }
    else if ([segue.identifier isEqualToString:kSegueSlidPush])
    {
        self.navigationController.delegate = self;
    }
    // Bounce
    else if ([segue.identifier isEqualToString:kSegueBounceModal])
    {
        UIViewController *vc = segue.destinationViewController;
        vc.transitioningDelegate = self;
    }
    else if ([segue.identifier isEqualToString:kSegueBouncePush])
    {
        self.navigationController.delegate = self;
    }
    // Fold
    else if ([segue.identifier isEqualToString:kSegueFoldPush])
    {
        self.navigationController.delegate = self;
    }
    else if ([segue.identifier isEqualToString:kSegueFoldModal])
    {
        UIViewController *vc = segue.destinationViewController;
        vc.transitioningDelegate = self;
    }
    else if ([segue.identifier isEqualToString:kSegueDropModal])
    {
        UIViewController *vc = segue.destinationViewController;
        vc.transitioningDelegate = self;
    }
    
}

#pragma mark - UIViewControllerTransitioningDelegate

// Called when presenting a view controller that has a transitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    id<UIViewControllerAnimatedTransitioning> animationController;
    FVConfigOption *option = [FVConfigOption sharedConfigOptions];
    // Slide
    if ([presented isKindOfClass:[FVSlideViewController class]])
    {
        FVSlideTransitionAnimator *animator = [[FVSlideTransitionAnimator alloc] init];
        animator.appearing = YES;
        animator.duration = option.duration;
        animator.edge = option.edge;
        animationController = animator;
    }
    // Options
    else if ([presented isKindOfClass:[UINavigationController class]])
    {
        FVOptionsTransitionAnimator *animator = [[FVOptionsTransitionAnimator alloc] init];
        animator.appearing = YES;
        animator.duration = option.duration;
        animationController = animator;
    }
    // Bounces
    else if ([presented isKindOfClass:[FVBounceViewController class]])
    {
        FVBounceTransitionAnimtor *animator = [[FVBounceTransitionAnimtor alloc] init];
        animator.appearing = YES;
        animator.duration = option.springDuration;
        animator.edge = option.edge;
        animator.velocity = option.velocity;
        animator.dampingRatio = option.dampingRatio;
        animationController = animator;
    }
    // Fold
    else if ([presented isKindOfClass:[FVFoldViewController class]])
    {
        FVFoldTransitionAnimator *animator = [[FVFoldTransitionAnimator alloc] init];
        animator.appearing = YES;
        animator.duration = option.foldDuration;
        animationController = animator;
    }
    // Drop
    else if ([presented isKindOfClass:[FVDropViewController class]])
    {
        FVDropTransitionAnimator *animator = [[FVDropTransitionAnimator alloc] init];
        animator.appearing = YES;
        animator.duration = 1.5;
        animationController = animator;
    }
    return animationController;
}

// Called when presenting a view controller that has a transitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    id<UIViewControllerAnimatedTransitioning> animationController;
    FVConfigOption *option = [FVConfigOption sharedConfigOptions];
    
    // Slides
    if ([dismissed isKindOfClass:[FVSlideViewController class]])
    {
        FVSlideTransitionAnimator *animator = [[FVSlideTransitionAnimator alloc] init];
        animator.appearing = NO;
        animator.duration = option.duration;
        animator.edge = option.edge;
        animationController = animator;
    }
    else if ([dismissed isKindOfClass:[UINavigationController class]])
    {
        if ([((UINavigationController *)dismissed).topViewController isKindOfClass:[FVCofigOptionViewController class]])
        {
            FVOptionsTransitionAnimator *animator = [[FVOptionsTransitionAnimator alloc] init];
            animator.appearing = NO;
            animator.duration = option.duration;
            animationController = animator;
        }
    
    }
    else if ([dismissed isKindOfClass:[FVBounceViewController class]])
    {
        FVBounceTransitionAnimtor *animator = [[FVBounceTransitionAnimtor alloc] init];
        animator.appearing = NO;
        animator.duration = option.springDuration;
        animator.edge = option.edge;
        animator.dampingRatio = 1;
        animator.velocity = option.velocity;
        animationController = animator;
    }
    else if ([dismissed isKindOfClass:[FVFoldViewController class]])
    {
        FVFoldTransitionAnimator *animator = [[FVFoldTransitionAnimator alloc] init];
        animator.appearing = NO;
        animator.duration = option.foldDuration;
        animationController = animator;
    }
    else if ([dismissed isKindOfClass:[FVDropViewController class]])
    {
        FVDropTransitionAnimator *animator = [[FVDropTransitionAnimator alloc] init];
        animator.duration = 2;
        animator.appearing = NO;
        animationController = animator;
    }
    
    return animationController;
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    id<UIViewControllerAnimatedTransitioning> animationController;
    FVConfigOption *option = [FVConfigOption sharedConfigOptions];
    
    // Slide push
    if ([toVC isKindOfClass:[FVSlideViewController class]] && operation == UINavigationControllerOperationPush)
    {
        FVSlideTransitionAnimator *animator = [[FVSlideTransitionAnimator alloc] init];
        animator.appearing = YES;
        animator.duration = option.duration;
        animator.edge = option.edge;
        animationController = animator;
    }
    // Slides Pop
    else if ([fromVC isKindOfClass:[FVSlideViewController class]] && operation == UINavigationControllerOperationPop)
    {
        FVSlideTransitionAnimator *animator = [[FVSlideTransitionAnimator alloc] init];
        animator.appearing = NO;
        animator.duration = option.duration;
        animator.edge = option.edge;
        animationController = animator;
    }
    // Bounce Push
    else if ([toVC isKindOfClass:[FVBounceViewController class]] && operation == UINavigationControllerOperationPush)
    {
        FVBounceTransitionAnimtor *animator = [[FVBounceTransitionAnimtor alloc] init];
        animator.appearing = YES;
        animator.duration = option.springDuration;
        animator.edge = option.edge;
        animator.dampingRatio = option.dampingRatio;
        animator.velocity = option.velocity;
        
        animationController = animator;
    }
    // Bounce Pop
    else if ([fromVC isKindOfClass:[FVBounceViewController class]] && operation == UINavigationControllerOperationPop)
    {
        FVBounceTransitionAnimtor *animator = [[FVBounceTransitionAnimtor alloc] init];
        animator.appearing = NO;
        animator.duration = option.springDuration;
        animator.edge = option.edge;
        animator.dampingRatio = 1.0;
        animator.velocity = option.velocity;
        animationController = animator;
    }
    // Fold push
    else if ([toVC isKindOfClass:[FVFoldViewController class]] && operation == UINavigationControllerOperationPush)
    {
        FVFoldTransitionAnimator *animator = [[FVFoldTransitionAnimator alloc] init];
        animator.appearing = YES;
        animator.duration = option.foldDuration;
        animationController = animator;
    }
    else if ([fromVC isKindOfClass:[FVFoldViewController class]] && operation == UINavigationControllerOperationPop)
    {
        FVFoldTransitionAnimator *animator = [[FVFoldTransitionAnimator alloc] init];
        animator.appearing = NO;
        animator.duration = option.foldDuration;
        animationController = animator;
    }
    
    return animationController;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FVConfigOption *option = [FVConfigOption sharedConfigOptions];
    
    switch (indexPath.section) {
            
        case TableViewSectionBasic:
        {
            NSString *identifier = option.pushTransition ? kSegueSlidPush : kSegueSlidModal;
            [self performSegueWithIdentifier:identifier sender:self];
            break;
        }
        case TableViewSectionSpring:
        {
            NSString *identifier = option.pushTransition ? kSegueBouncePush : kSegueBounceModal;
            [self performSegueWithIdentifier:identifier sender:self];
        }
        case TableViewSectionKeyFrame:
        {
            NSString *identifier = option.pushTransition ? kSegueFoldPush : kSegueFoldModal;
            [self performSegueWithIdentifier:identifier sender:self];
        }
        case TableViewSectionCollection:
        {
            self.navigationController.delegate = nil;
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            layout.itemSize = CGSizeMake(150.f, 150.f);
            
            FVCollectionViewController *vc = [[FVCollectionViewController alloc] initWithCollectionViewLayout:layout];
            vc.useLayoutToLayoutNavigationTransitions = NO;
            vc.numberOfItems = 100;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case TableViewSectionDrop:
        {
            [self performSegueWithIdentifier:kSegueDropModal sender:self];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - Storyboard unwinding

- (IBAction)unwindToViewController:(UIStoryboardSegue *)sender
{}

- (IBAction)animationOptionsConfig:(UIBarButtonItem *)sender
{
    UIStoryboard *optionSB = [UIStoryboard storyboardWithName:@"OptionsSB" bundle:nil];
    UIViewController *optionVC = optionSB.instantiateInitialViewController;
    optionVC.modalPresentationStyle = UIModalPresentationCustom;
    optionVC.transitioningDelegate = self;
    [self presentViewController:optionVC animated:YES completion:nil];
}

@end
