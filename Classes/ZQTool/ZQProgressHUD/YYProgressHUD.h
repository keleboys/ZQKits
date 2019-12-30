//
//  YYProgressHUD.h
//  YYProgressHUD
//
//  Created by 易云物联 on 2019/4/16.
//  Copyright © 2019 易云物联. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYBackgroundView;
@class YYContentView;
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, YYProgressHUDMode) {
    /** 默认样式 */
    YYProgressHUDModeDefault,
    /** 自定义 */
    YYProgressHUDModeCustom
};

typedef NS_ENUM(NSInteger, YYProgressHUDBackgroundStyle) {
    /** 自定义背景色 */
    YYProgressHUDBackgroundStyleSolidColor,
    /** 模糊效果 */
    YYProgressHUDBackgroundStyleBlur
};
typedef void (^YYProgressHUDDismissCompletion)(void);
@interface YYProgressHUD : UIView
@property (nonatomic, assign) YYProgressHUDMode mode;
@property (nonatomic, assign) YYProgressHUDBackgroundStyle bkgStyle;
//@property (nonatomic, assign) CGPoint offset UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *contentColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *backgroudColoc UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) BOOL removeFromSuperViewOnHide;

/** 展示成功信息
 * @param view 父视图
 * @param msg 提示信息
 */
+ (instancetype)showSuccessHUDAddedTo:(UIView *)view msg:(NSString *)msg;
/** 展示失败信息
 * @param view 父视图
 * @param msg 提示信息
 */
+ (instancetype)showErrorHUDAddedTo:(UIView *)view msg:(NSString *)msg;
/** 正在加载中
 * @param view 父视图
 */
+ (instancetype)showLoadingHUDAddedTo:(UIView *)view;
/** 带图片的信息提示
 * @param view 父视图
 * @param image 提示信息图片
 * @param msg 提示信息
 */
+ (instancetype)showAlertHUDAddedTo:(UIView *)view msg:(NSString *)msg;
/**
 * 从父视图移除
 */
+ (void)dimiss;
- (void)dimiss;
/** 从父视图延时移除
 * @param delay 延时时间
 */
+ (void)dismissWithDelay:(NSTimeInterval)delay;
/** 从父视图延时移除
 * @param delay 延时时间
 @ @param completion 移除完成回调
 */
+ (void)dismissWithDelay:(NSTimeInterval)delay completion:(nullable YYProgressHUDDismissCompletion)completion;

#pragma mark - Customization
/**  */
+(void)setContentColor:(UIColor *)contentColor;
+(void)setStyle:(YYProgressHUDBackgroundStyle)style;
+(void)setTextColor:(UIColor *)textColor;
+(void)setBackgroudColoc:(UIColor *)backgroudColoc;
@end

typedef NS_ENUM(NSInteger, YYContentViewStyle) {
    YYContentViewWithLoading,
    YYContentViewWithSuccess,
    YYContentViewWithError,
    YYContentViewWithAlert,
    YYContentViewWithMsg
};
@interface YYContentView : UIView
/**  */
@property (nonatomic, strong) UIColor *textColor;
/**  */
@property (nonatomic, strong) NSString *text;
/**  */
//@property (nonatomic, strong) UIColor *backgroundColor;
/**  */
@property (nonatomic, assign) CGFloat corner;
-(instancetype)initWithFrame:(CGRect)frame style:(YYContentViewStyle)style msg:(nullable NSString *)msg img:(nullable NSString *)img;
@end

@interface YYBackgroundView : UIView
@property (nonatomic) YYProgressHUDBackgroundStyle style;
@property (nonatomic) UIBlurEffectStyle blurEffectStyle;
@property (nonatomic, strong) UIColor *color;
@end
NS_ASSUME_NONNULL_END
