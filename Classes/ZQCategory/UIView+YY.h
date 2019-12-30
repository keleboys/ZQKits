//
//  UIView+YY.h
//  YiYunSTP
//
//  Created by apple on 2019/3/21.
//  Copyright © 2019年 yiyuniot. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#pragma mark --<Base>
@interface UIView (YY)
/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat x;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat y;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat maxX;

/**
 * CGRectGetMaxY(self.frame);
 */
@property (nonatomic) CGFloat maxY;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerY;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize size;

@end
#pragma mark --<Shadow>
@interface UIView (Shadow)
/** 绘制阴影的角度 */
@property (nonatomic, assign) CGFloat yy_ShadowRadius;
/** 绘制阴影的颜色,但是必须添加在shadowRadius前面，否则不起作用 */
@property (nonatomic, strong) UIColor *yy_ShadowColor;
/** 绘制阴影的角度 */
-(void)yy_DrawShadowWithRadius:(CGFloat)radius;
@end

@interface UIView (Present)
/** 找到自己的vc */
- (UIViewController *)viewController;
@end
NS_ASSUME_NONNULL_END
