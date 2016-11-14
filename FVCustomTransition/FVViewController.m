//
//  FVViewController.m
//  FVCustomTransition
//
//  Created by iforvert on 2016/11/11.
//  Copyright © 2016年 iforvert. All rights reserved.
//

#import "FVViewController.h"
#import "FVConfigOption.h"
#import "FVSlideViewController.h"
#import "FVSlideTransitionAnimator.h"
#import "FVOptionsTransitionAnimator.h"
#import "FVCofigOptionViewController.h"

typedef NS_ENUM(NSInteger, TableViewSection){
    TableViewSectionBasic,
    TableViewSectionSpring,
};

// Segue ids

static NSString * const kSegueSlidPush = @"slidePush";
static NSString * const kSegueSlidModal = @"slideModal";
static NSString * const kSegueOptionsDismiss = @"optionsDismiss";
static NSString * const kSegueDropDismiss    = @"dropDismiss";
static NSString * const kSegueBouncePush = @"bouncePush";
static NSString * const kSegueBounceModal = @"bounceModal";


@interface FVViewController ()<UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>

@end

@implementation FVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kSegueSlidModal])
    {
        UIViewController *vc = segue.destinationViewController;
        vc.modalTransitionStyle = UIModalPresentationCustom;
        vc.transitioningDelegate = self;
        
    }
    else if ([segue.identifier isEqualToString:kSegueSlidPush])
    {
        self.navigationController.delegate = self;
    }
    else if ([segue.identifier isEqualToString:kSegueBouncePush])
    {
        self.navigationController.delegate = self;
    }
    else if ([segue.identifier isEqualToString:kSegueBounceModal])
    {
    
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
    else if ([presented isKindOfClass:[UINavigationController class]])
    {
        FVOptionsTransitionAnimator *animator = [[FVOptionsTransitionAnimator alloc] init];
        animator.appearing = YES;
        animator.duration = option.duration;
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
        animator.edge = FVEdgeBottom;
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
    return animationController;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FVConfigOption *option = [FVConfigOption sharedConfigOptions];
    
    switch (indexPath.section) {
            
        case TableViewSectionBasic: {
            
            NSString *identifier = option.pushTransition ? kSegueSlidPush : kSegueSlidModal;
            [self performSegueWithIdentifier:identifier sender:self];
            break;
        }
        case TableViewSectionSpring:
        {
            NSString *identifier = option.pushTransition ? kSegueBouncePush : kSegueBounceModal;
            [self performSegueWithIdentifier:identifier sender:self];
        }
        
            
        default:
            break;
    }
}

#pragma mark - Storyboard unwinding

/*
 Unwind segue action called to dismiss the Options and Drop view controllers and
 when the Slide, Bounce and Fold view controllers are dismissed with a single tap.
 
 Normally an unwind segue will pop/dismiss the view controller but this doesn't happen
 for custom modal transitions so we have to manually call dismiss.
 */
- (IBAction)unwindToViewController:(UIStoryboardSegue *)sender
{
    if ([sender.identifier isEqualToString:kSegueOptionsDismiss] || [sender.identifier isEqualToString:kSegueDropDismiss]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (IBAction)animationOptionsConfig:(UIBarButtonItem *)sender
{
    UIStoryboard *optionSB = [UIStoryboard storyboardWithName:@"OptionsSB" bundle:nil];
    UIViewController *optionVC = optionSB.instantiateInitialViewController;
    optionVC.modalPresentationStyle = UIModalPresentationCustom;
    optionVC.transitioningDelegate = self;
    [self presentViewController:optionVC animated:YES completion:nil];
}

@end
