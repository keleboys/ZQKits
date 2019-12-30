//
//  UILabel+YY.m
//  YiYunSTP
//
//  Created by 易云物联 on 2019/3/22.
//  Copyright © 2019 yiyuniot. All rights reserved.
//

#import "UILabel+YY.h"

@implementation UILabel (YY)

+(UILabel *)labelWithFrame:(NSString *__nullable)title font:(NSUInteger)font bkgdColor:(UIColor*__nullable)bkgdColor textColor:(UIColor *__nullable)textColor{
    return [self labelWithFrame:CGRectZero title:title font:font bkgdColor:bkgdColor textColor:textColor];
}

+(UILabel *)labelWithTitle:(CGRect)frame title:(NSString  *__nullable)title font:(NSUInteger)font bkgdColor:(UIColor* __nullable)bkgdColor textColor:(UIColor *__nullable)textColor{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = title?title:@"";
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = textColor?textColor:[UIColor blackColor];
    label.backgroundColor = bkgdColor? bkgdColor: [UIColor clearColor];
    return label;
}

@end
