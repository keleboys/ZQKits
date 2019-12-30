
//
//  YYCover.m
//  YiYunSTP
//
//  Created by 易云物联 on 2019/4/10.
//  Copyright © 2019 yiyuniot. All rights reserved.
//

#import "YYCover.h"

@implementation YYCover

+ (instancetype)showView:(UIView *)superV
{
    YYCover *cover = [[YYCover alloc] initWithFrame:superV.bounds];
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.2;
    [superV addSubview:cover];
    return cover;
}

+ (void)dismissView:(UIView *)superV
{
    for (UIView *cover in superV.subviews) {
        if ([cover isKindOfClass:self]) {
            [cover removeFromSuperview];
        }
    }
}
@end
