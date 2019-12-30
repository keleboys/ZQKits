//
//  YYCover.h
//  YiYunSTP
//
//  Created by 易云物联 on 2019/4/10.
//  Copyright © 2019 yiyuniot. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYCover : UIView

+ (instancetype)showView:(UIView *)superV;
+ (void)dismissView:(UIView *)superV;

@end

NS_ASSUME_NONNULL_END
