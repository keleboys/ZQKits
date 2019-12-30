//
//  UIButton+YY.h
//  YiYunSTP
//
//  Created by 易云物联 on 2019/3/22.
//  Copyright © 2019 yiyuniot. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ButtonEdgeInsetsStyle) {
    ButtonEdgeInsetsStyleImageLeft,
    ButtonEdgeInsetsStyleImageRight,
    ButtonEdgeInsetsStyleImageTop,
    ButtonEdgeInsetsStyleImageBottom
};

@interface UIButton (YY)
/** 快速创建UIButton
 * @param frame frame
 * @param title 文字
 * @param font 字体大小
 * @param bkgdColor 背景色
 * @param image 图片
 * @return UIButton
 */
+ (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString * __nullable)title image:(NSString *__nullable)image font:(NSUInteger)font bkgdColor:(UIColor*__nullable)bkgdColor;
/** 快速创建UIButton
 * @param title 文字
 * @param font 字体大小
 * @param bkgdColor 背景色
 * @param image 图片
 * @return UIButton
 */
+ (UIButton *)buttonWithTitle:(NSString * __nullable)title image:(NSString *__nullable)image font:(NSUInteger)font bkgdColor:(UIColor*__nullable)bkgdColor;

+ (UIButton *)buttonWithTitle:(NSString *)title titleSize:(CGFloat)fontSize titleColor:(UIColor *)titleColor;

+ (UIButton *)buttonWithTitle:(NSString *)title titleFont:(UIFont *)font titleColor:(UIColor *)titleColor;

+ (UIButton *)buttonWithImage:(UIImage *)image;

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

- (void)layoutButtonWithEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style imageTitlespace:(CGFloat)space;

- (void)verticalImageAndTitle:(CGFloat)spacing;

@end

NS_ASSUME_NONNULL_END
