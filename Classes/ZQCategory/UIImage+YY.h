//
//  UIImage+YY.h
//  YiYunSTP
//
//  Created by apple on 2019/3/21.
//  Copyright © 2019年 yiyuniot. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static inline CGFloat degreesToRadians(CGFloat degrees)
{
    return M_PI * (degrees / 180.0);
}

static inline CGSize swapWidthAndHeight(CGSize size)
{
    CGFloat  swap = size.width;
    
    size.width  = size.height;
    size.height = swap;
    
    return size;
}

typedef NS_ENUM(NSUInteger, GradientType) {
    GradientTypeTopToBottom = 0,//从上到下
    GradientTypeLeftToRight = 1,//从左到右
    GradientTypeUpleftToLowright = 2,//左上到右下
    GradientTypeUprightToLowleft = 3,//右上到左下
};

@interface UIImage (YY)

/**
 * view->image
 * @param view view
 * @return image
 */
+ (UIImage *)convertViewToImage:(UIView *)view;
/**
 *  根据图片创建需要大修的图像的图片
 *
 *  @param size 需要大小
 *
 *  @return image
 */
- (UIImage *)scaleToSize:(CGSize)size;
/**
 *  根据图片创建需要大修的图像的图片
 *
 *  @param targetSize 需要大小
 *
 *  @return image
 */
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;
/**
 *  根据图片名称创建一张拉伸不变形的图片
 *
 *  @param imageName 图片名称
 *
 *  @return 拉伸不变形的图片
 */
+ (instancetype)resizableImageWithName:(NSString *)imageName;

/**
 *  根据图片名称创建一张拉伸不变形的图片
 *
 *  @param imageName  图片名称
 *  @param leftRatio  左边不拉伸比例
 *  @param topRatio 顶部不拉伸比例
 *
 *  @return 拉伸不变形的图片
 */
+ (instancetype)resizableImageWithName:(NSString *)imageName leftRatio:(CGFloat)leftRatio topRatio:(CGFloat)topRatio;
/**
 *  根据颜色返回一张特定大小的图片
 *
 *  @param color 图片的颜色
 *  @param size  图片的大小
 *
 *  @return 返回的图片
 */
+ (instancetype)imageFromColor:(UIColor *)color size:(CGSize)size;
/**
 *  根据颜色返回一张特定大小的图片
 *
 *  @param color 图片的颜色
 *
 *  @return 返回的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
//修改图片颜色
- (UIImage *) yy_imageWithTintColor:(UIColor *)tintColor;
- (UIImage *) yy_imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;
/**  设置图片的渐变色(颜色->图片)
 *
 *   @param colors 渐变颜色数组
 *   @param gradientType 渐变样式
 *   @param imgSize 图片大小
 *   @return 颜色->图片
 *
 */
+ (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize;
/**  给图片加圆角
 *
 *   @param radius 圆角半径
 *   @param size 图片大小
 *   @return 颜色->图片
 *
 */
- (UIImage *)imageWithRoundedCorner:(CGFloat)radius
                               size:(CGSize)size;

/**  给图片加圆角同时添加边框颜色
 *
 *   @param radius 圆角半径
 *   @param size 图片大小
 *   @param borderWidth 边框宽度
 *   @param borderColor 边框颜色
 *   @return 颜色->图片
 *
 */
- (UIImage *)imageWithRoundedCorner:(CGFloat)radius
                               size:(CGSize)size
                        borderWidth:(CGFloat)borderWidth
                        borderColor:(UIColor *)borderColor;

/**
 *  根据图片名返回圆形图像
 *
 *  @param name 图片名称
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *
 *  @return 返回的图片
 */
+(UIImage *)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**
 *  根据图片名返回圆形图像
 *
 *  @param image 图片
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *
 *  @return 返回的图片
 */
+(UIImage *)circleImageWithImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**
 *  根据图片缩放
 *
 *  @param img 图片
 *  @param size 尺寸
 *
 *  @return 返回的图片
 */
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;


@end

@interface UIImage (Utility)
+ (UIImage *)fastImageWithData:(NSData *)data;
+ (UIImage *)fastImageWithContentsOfFile:(NSString *)path;
+ (UIImage*)getSubImage:(UIImage *)img rect:(CGRect)rect;
+ (UIImage *)mergeImage:(UIImage *)image withImage:(UIImage *)otherImage rect:(CGRect)rect;
+ (UIImage *)mergeImage:(UIImage *)image withImage:(UIImage *)otherImage rect:(CGRect)rect transform:(CGAffineTransform)transform;

+ (NSData *)compressImageData:(UIImage *)image;
@end

@interface UIImage (camera)

- (UIImage*)rotate:(UIImageOrientation)orient;
- (UIImage*)scaleWithMaxSize:(CGSize)maxSize
                     quality:(CGInterpolationQuality)quality;
@end

NS_ASSUME_NONNULL_END
