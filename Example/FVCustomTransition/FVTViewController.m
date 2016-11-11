//
//  FVTViewController.m
//  FVCustomTransition
//
//  Created by iforvert on 2016/11/11.
//  Copyright © 2016年 iforvert. All rights reserved.
//

#import "FVTViewController.h"
#import "FVSlideViewController.h"
#import "FVSlideTransitionAnimator.h"

typedef NS_ENUM(NSInteger, TableViewSection){
    TableViewSectionBasic,
};

// Segue ids

static NSString * const kSegueSlidPush = @"slidePush";
static NSString * const kSegueSlidModal = @"slideModal";


@interface FVTViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation FVTViewController

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
    else if ([segue.identifier isEqualToString:kSegueSlidModal])
    {
    
    }
    
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    id<UIViewControllerAnimatedTransitioning> animationController;
    
    // Slide
    if ([presented isKindOfClass:[FVSlideViewController class]])
    {
        FVSlideTransitionAnimator *animator = [[FVSlideTransitionAnimator alloc] init];
        animator.appearing = YES;
        animator.duration = 0.5;
        animator.edge = FVEdgeLeft;
        animationController = animator;
    }

    return animationController;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section)
    {
        case TableViewSectionBasic:
            
            break;
            
        default:
            break;
    }
}

@end
