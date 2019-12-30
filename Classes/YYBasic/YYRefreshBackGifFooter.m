//
//  YYRefreshBackGifFooter.m
//  YiYunSTP
//
//  Created by 易云物联 on 2019/4/15.
//  Copyright © 2019 yiyuniot. All rights reserved.
//

#import "YYRefreshBackGifFooter.h"

@implementation YYRefreshBackGifFooter

+(NSArray *)getRefreshImages{
    NSMutableArray *imgs = [NSMutableArray array];
    for (int i=1; i<11; i++) {
        NSString *string = [NSString stringWithFormat:@"Load_animation%d",i];
        UIImage *image = [UIImage imageNamed:string];
        [imgs addObject:image];
    }
    return imgs;
}

+(MJRefreshBackGifFooter *)yy_footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock{
    NSArray *imgs = [self getRefreshImages];
    MJRefreshBackGifFooter *gifFooter = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        !refreshingBlock ?: refreshingBlock();
    }];
    [gifFooter setImages:imgs duration:1.5 forState:MJRefreshStateIdle];
    //设置正在刷新是的动画图片
    [gifFooter setImages:imgs duration:1.5 forState:MJRefreshStatePulling];
    //马上进入刷新状态
    [gifFooter setImages:imgs duration:1.5 forState:MJRefreshStateRefreshing];
    return gifFooter;
}

@end
