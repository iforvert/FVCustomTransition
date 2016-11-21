//
//  FVFromEdgeViewController.m
//  FVCustomTransition
//
//  Created by iforvert on 2016/11/12.
//  Copyright © 2016年 iforvert. All rights reserved.
//  代码地址: https://github.com/Upliver/FVCustomTransition

#import "FVFromEdgeViewController.h"
#import "FVSlideTransitionAnimator.h"
#import "FVConfigOption.h"

static NSString * const kEdgeCellID = @"edgeCellID";

@interface FVFromEdgeViewController ()

@end

@implementation FVFromEdgeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    FVConfigOption *option = [FVConfigOption sharedConfigOptions];
    self.checkedItem = [NSIndexPath indexPathForRow:option.edge inSection:0];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [FVSlideTransitionAnimator edgeDisplayName].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kEdgeCellID forIndexPath:indexPath];
    cell.textLabel.text = [FVSlideTransitionAnimator edgeDisplayName][@(indexPath.row)];
    
    if ([indexPath isEqual:self.checkedItem]) {
        [self checkCell:cell];
    } else {
        [self uncheckCell:cell];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self uncheckCell:[tableView cellForRowAtIndexPath:self.checkedItem]];
    [self checkCell:[tableView cellForRowAtIndexPath:indexPath]];
    self.checkedItem = indexPath;

    FVConfigOption *option = [FVConfigOption sharedConfigOptions];
    option.edge = indexPath.row;
}

- (void)checkCell:(UITableViewCell *)cell
{
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
}

- (void)uncheckCell:(UITableViewCell *)cell
{
    cell.accessoryType = UITableViewCellAccessoryNone;
}


@end
