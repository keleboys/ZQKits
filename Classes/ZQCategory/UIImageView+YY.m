//
//  UIImageView+YY.m
//  YiYunSTP
//
//  Created by 易云物联 on 2019/3/22.
//  Copyright © 2019 yiyuniot. All rights reserved.
//

#import "UIImageView+YY.h"
#import <objc/runtime.h>
@implementation UIImageView (YY)

-(void)setYy_radius:(CGFloat)yy_radius{
    objc_setAssociatedObject(self, "yy_radius", [NSNumber numberWithFloat:yy_radius], yy_radius);
    [self yy_DrawImageViewLayerWithRadius:yy_radius];
}

-(CGFloat)yy_radius{
        return [objc_getAssociatedObject(self, "yy_radius") floatValue];
}

-(void)yy_DrawImageViewLayerWithRadius:(CGFloat)radius{
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    [path addClip];
    [self drawRect:self.bounds];
//    self.image =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

@end
