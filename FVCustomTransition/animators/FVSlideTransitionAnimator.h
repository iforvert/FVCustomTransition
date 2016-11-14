//
//  FVSlideTransitionAnimator.h
//  FVCustomTransition
//
//  Created by iforvert on 2016/11/11.
//  Copyright © 2016年 iforvert. All rights reserved.
//

#import "FVBaseTransitionAnimator.h"

typedef NS_ENUM(NSInteger, FVEdge) {
    FVEdgeTop,
    FVEdgeLeft,
    FVEdgeBottom,
    FVEdgeRight,
    FVEdgeTopRight,
    FVEdgeTopLeft,
    FVEdgeBottomRight,
    FVEdgeBottomLeft
};

@interface FVSlideTransitionAnimator : FVBaseTransitionAnimator

@property(nonatomic, assign) FVEdge edge;

+ (NSDictionary *)edgeDisplayName;
- (CGRect)rectOffsetFromRect:(CGRect)fromRect atEdge:(FVEdge)edge;

@end
