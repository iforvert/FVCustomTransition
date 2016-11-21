//
//  FVDropViewController.m
//  FVCustomTransition
//
//  Created by iforvert on 2016/11/15.
//  Copyright © 2016年 iforvert. All rights reserved.
//  代码地址: https://github.com/Upliver/FVCustomTransition

#import "FVDropViewController.h"

@interface FVDropViewController ()

@end

@implementation FVDropViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    gradientLayer.colors = @[(id)[UIColor purpleColor].CGColor,
                             (id)[UIColor redColor].CGColor];
    gradientLayer.cornerRadius = 4;
    gradientLayer.masksToBounds = YES;
    [self.view.layer insertSublayer:gradientLayer atIndex:0];
}


@end
