//
//  UIImageView+YY.h
//  YiYunSTP
//
//  Created by 易云物联 on 2019/3/22.
//  Copyright © 2019 yiyuniot. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (YY)
/**  绘制圆角 */
@property (nonatomic, assign) CGFloat yy_radius;
/** 绘UIImageView绘制角度 */
-(void)yy_DrawImageViewLayerWithRadius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
