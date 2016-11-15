//
//  FVFoldViewController.m
//  FVCustomTransition
//
//  Created by iforvert on 2016/11/14.
//  Copyright © 2016年 iforvert. All rights reserved.
//

#import "FVFoldViewController.h"

@interface FVFoldViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *foldBgClick;

@end

@implementation FVFoldViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.foldBgClick.userInteractionEnabled = YES;
}



@end
