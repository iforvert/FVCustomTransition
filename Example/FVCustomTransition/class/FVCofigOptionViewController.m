//
//  FVCofigOptionViewController.m
//  FVCustomTransition
//
//  Created by iforvert on 2016/11/11.
//  Copyright © 2016年 iforvert. All rights reserved.
//

#import "FVCofigOptionViewController.h"
#import "FVConfigOption.h"

typedef NS_ENUM(NSInteger, Tag) {
    // 转场时间
    TagDurationField        = 10,
    // 阻尼系数
    TagDampingRatioField    = 20,
    // 弹动速度
    TagSpringVelocityField  = 30,
    // 弹动时长
    TagSpringDurationField  = 40
};

@interface FVCofigOptionViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *pushTransitionSwitch;
@property (weak, nonatomic) IBOutlet UITextField *durationField;
@property (weak, nonatomic) IBOutlet UILabel *fromEdgeLabel;
@property (weak, nonatomic) IBOutlet UITextField *dampingRatioField;
@property (weak, nonatomic) IBOutlet UITextField *springVelocityField;
@property (weak, nonatomic) IBOutlet UITextField *springDurationField;
@property (nonatomic, strong) NSNumberFormatter *numberFormatter;

@end

@implementation FVCofigOptionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.numberFormatter = ({
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [formatter setMinimumFractionDigits:2];
        [formatter setMaximumFractionDigits:2];
        [formatter setAlwaysShowsDecimalSeparator:YES];
        formatter;
    });
    
    FVConfigOption *options = [FVConfigOption sharedConfigOptions];
    self.pushTransitionSwitch.on = options.pushTransition;
    self.durationField.text = [self.numberFormatter stringFromNumber:@(options.duration)];
    self.dampingRatioField.text = [self.numberFormatter stringFromNumber:@(options.dampingRatio)];
    self.springVelocityField.text = [self.numberFormatter stringFromNumber:@(options.velocity)];
    self.springDurationField.text = [self.numberFormatter stringFromNumber:@(options.springDuration)];
    
}


@end
