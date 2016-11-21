//
//  FVCollectionViewController.m
//  FVCustomTransition
//
//  Created by iforvert on 2016/11/15.
//  Copyright © 2016年 iforvert. All rights reserved.
//  代码地址: https://github.com/Upliver/FVCustomTransition

#import "FVCollectionViewController.h"

@interface FVCollectionViewController ()

@end

@implementation FVCollectionViewController

static NSString * const reuseIdentifier = @"kCell";
static NSUInteger const kDefaultNumberOfItems = 50;
static NSUInteger const kItemSizeReduction = 50;
static NSUInteger const kMinimumItemSize = 50;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _numberOfItems = kDefaultNumberOfItems;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    CGSize itemSize = ((UICollectionViewFlowLayout *)self.collectionViewLayout).itemSize;
    self.title = [NSString stringWithFormat:@"{%.f, %.f}", itemSize.width, itemSize.height];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.numberOfItems;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    CGFloat hue = (indexPath.item % 91) / 90.0;
    cell.backgroundColor = [UIColor colorWithHue:hue saturation:1.0 brightness:1.0 alpha:1.0];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize itemSize = ((UICollectionViewFlowLayout *)self.collectionViewLayout).itemSize;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(itemSize.width - kItemSizeReduction,
                                 itemSize.height - kItemSizeReduction);
    FVCollectionViewController *toVC = [[FVCollectionViewController alloc] initWithCollectionViewLayout:layout];
    toVC.useLayoutToLayoutNavigationTransitions = YES;
    [self.navigationController pushViewController:toVC animated:YES];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize itemSize = ((UICollectionViewFlowLayout *)self.collectionViewLayout).itemSize;
    if (itemSize.width - kItemSizeReduction < kMinimumItemSize ||
        itemSize.height - kItemSizeReduction < kMinimumItemSize) {
        return NO;
    }
    return YES;
}

@end
