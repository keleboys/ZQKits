//
//  UIView+YY.m
//  YiYunSTP
//
//  Created by apple on 2019/3/21.
//  Copyright © 2019年 yiyuniot. All rights reserved.
//
#pragma mark --<Base>
#import "UIView+YY.h"

@implementation UIView (YY)

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)maxX
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setMaxX:(CGFloat)maxX
{
    CGRect frame = self.frame;
    frame.origin.x = maxX - frame.size.width;
    self.frame = frame;
}


- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}

- (void)setMaxY:(CGFloat)maxY
{
    CGRect frame = self.frame;
    frame.origin.y = maxY - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}


- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end
#pragma mark --<Shadow>
#import <objc/runtime.h>
@implementation UIView (Shadow)

-(void)setYy_ShadowRadius:(CGFloat)yy_ShadowRadius{
    objc_setAssociatedObject(self, "yy_ShadowRadius", [NSNumber numberWithFloat:yy_ShadowRadius], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self yy_DrawShadowWithRadius:yy_ShadowRadius];
}

-(CGFloat)yy_ShadowRadius{
    return [objc_getAssociatedObject(self, "shadowRadius") floatValue];
}

-(void)setYy_ShadowColor:(UIColor *)yy_ShadowColor{
    objc_setAssociatedObject(self, "yy_ShadowColor", yy_ShadowColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIColor *)yy_ShadowColor{
    return objc_getAssociatedObject(self, "yy_ShadowColor");
}



-(void)yy_DrawShadowWithRadius:(CGFloat)radius{
    if (self.yy_ShadowColor == nil) {
        self.yy_ShadowColor = [UIColor grayColor];
    }
    self.layer.cornerRadius = radius;
    self.layer.shadowColor = self.yy_ShadowColor.CGColor;
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 3.0f;
    self.backgroundColor = [UIColor whiteColor];
    UIBezierPath *btnShadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius];
    self.layer.shadowPath = btnShadowPath.CGPath;
}
@end

@implementation UIView (Present)
/** 找到自己的vc */
- (UIViewController *)viewController{
    for (UIView* next = self; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
@end

