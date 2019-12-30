//
//  ZQStatusBarHud.h
//  WillBeClassified
//
//  Created by 张泉 on 2017/12/4.
//  Copyright © 2017年 张泉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZQStatusBarHud : NSObject
/**
 * 显示普通信息
 * @param msg       文字
 * @param image     图片
 */
+ (void)showMessage:(NSString *)msg image:(UIImage *)image;
/**
 * 显示普通信息
 */
+ (void)showMessage:(NSString *)msg;
/**
 * 显示网络异常信息
 */
+ (void)showHttpError:(NSString *)msg;
/**
 * 显示成功信息
 */
+ (void)showSuccess:(NSString *)msg;
/**
 * 显示失败信息
 */
+ (void)showError:(NSString *)msg;
/**
 * 显示正在处理的信息
 */
+ (void)showLoading:(NSString *)msg;
/**
 * 隐藏
 */
+ (void)hide;
/**
 * 消失时间
 */
+(void)dimissTime:(CGFloat)time;

@end
