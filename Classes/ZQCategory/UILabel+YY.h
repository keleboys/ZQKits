//
//  UILabel+YY.h
//  YiYunSTP
//
//  Created by 易云物联 on 2019/3/22.
//  Copyright © 2019 yiyuniot. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (YY)
/** 快速创建UILabel
 * @param frame frame
 * @param title 文字
 * @param font 字体大小
 * @param bkgdColor 背景色
 * @param textColor 文字颜色
 * @return UILabel
 */
+(UILabel *)labelWithFrame:(CGRect)frame title:(NSString  *__nullable)title font:(NSUInteger)font bkgdColor:(UIColor* __nullable)bkgdColor textColor:(UIColor *__nullable)textColor;
/** 快速创建UILabel
 * @param title 文字
 * @param font 字体大小
 * @param bkgdColor 背景色
 * @param textColor 文字颜色
 * @return UILabel
 */
+(UILabel *)labelWithTitle:(NSString *__nullable)title font:(NSUInteger)font bkgdColor:(UIColor*__nullable)bkgdColor textColor:(UIColor *__nullable)textColor;
@end

NS_ASSUME_NONNULL_END
