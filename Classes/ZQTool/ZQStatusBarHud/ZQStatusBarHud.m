//
//  ZQStatusBarHud.m
//  WillBeClassified
//
//  Created by 张泉 on 2017/12/4.
//  Copyright © 2017年 张泉. All rights reserved.
//

#import "ZQStatusBarHud.h"

#define ZQMessageFont [UIFont systemFontOfSize:16]
/** 消息的停留时间 */
static CGFloat ZQMessageDuration = 3.0;
/** 消息显示\隐藏的动画时间 */
static CGFloat const ZQAnimationDuration = 0.25;

@implementation ZQStatusBarHud
/** 全局的窗口 */
static UIWindow *window_;
/** 定时器 */
static NSTimer *timer_;

/**
 * 显示窗口
 */
+ (void)showWindow:(NSString *)color
{
    // frame数据
        CGFloat windowH = YYHeight_NavBar();
    CGRect frame = CGRectMake(0, - windowH, [UIScreen mainScreen].bounds.size.width, windowH);
    // 显示窗口
    window_.hidden = YES;
    window_ = [[UIWindow alloc] init];
    window_.windowLevel = UIWindowLevelAlert;
    window_.backgroundColor = [UIColor colorWithHexString:color];
    window_.frame = frame;
    window_.hidden = NO;
    //添加轻扫手势
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    //设置轻扫的方向
    swipeGesture.direction = UISwipeGestureRecognizerDirectionUp; //默认向右
    [window_ addGestureRecognizer:swipeGesture];
    if ([color isEqualToString:@"#f7e7c9"]) {
        frame.origin.y = 0;
        window_.userInteractionEnabled = NO;
    }else frame.origin.y = 0;
    [UIView animateWithDuration:ZQAnimationDuration animations:^{
        window_.frame = frame;
    }];
}

/**
 * 显示普通信息
 * @param msg       文字
 * @param image     图片
 */
+ (void)showMessage:(NSString *)msg image:(UIImage *)image backGroundColor:(NSString *)color
{
    // 停止定时器
    [timer_ invalidate];
    // 显示窗口
    [self showWindow:color];
    float heightNav = YYHeight_NavBar();
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, heightNav-40, 25, 25)];
    imageView.image = image;
    [window_ addSubview:imageView];
    
    UILabel *alertLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+10, heightNav-38, window_.width-YYFlt(70), 20)];
    alertLab.text = msg;
    alertLab.font = ZQMessageFont;
    alertLab.textColor = ColorWithHex(@"#373737");
    [window_ addSubview:alertLab];
    // 定时器
    timer_ = [NSTimer scheduledTimerWithTimeInterval:ZQMessageDuration target:self selector:@selector(hide) userInfo:nil repeats:NO];
}

/**
 * 显示普通信息
 */
+ (void)showMessage:(NSString *)msg
{
    [self showMessage:msg image:[UIImage imageNamed:@"ZQStatusBarHub.bundle/icon_exception"] backGroundColor:@"#f5f5f5"];
}
/**
 * 显示网络异常信息
 */
+ (void)showHttpError:(NSString *)msg{
     [self showMessage:msg image:[UIImage imageNamed:@"ZQStatusBarHub.bundle/WiFi_bad"] backGroundColor:@"#f7e7c9"];
}
/**
 * 显示成功信息
 */
+ (void)showSuccess:(NSString *)msg
{
    [self showMessage:msg image:[UIImage imageNamed:@"ZQStatusBarHub.bundle/icon_succeed"] backGroundColor:@"#ccfdd3"];
}

/**
 * 显示失败信息
 */
+ (void)showError:(NSString *)msg
{
     [self showMessage:msg image:[UIImage imageNamed:@"ZQStatusBarHub.bundle/icon_error"] backGroundColor:@"#fedcda"];
}
/**
 * 显示普通信息
 * @param msg       文字
 * @param image     图片
 */
+ (void)showMessage:(NSString *)msg image:(UIImage *)image{
     [self showMessage:msg image:[UIImage imageNamed:@""] backGroundColor:@"#f5f5f5"];
}

/**
 * 显示正在处理的信息
 */
+ (void)showLoading:(NSString *)msg
{
    // 停止定时器
    [timer_ invalidate];
    timer_ = nil;
    // 显示窗口
    [self showWindow:@"#f5f5f5"];
    
    // 添加文字
    UILabel *label = [[UILabel alloc] init];
    label.font = ZQMessageFont;
    label.frame = window_.bounds;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = msg;
    label.textColor = [UIColor whiteColor];
    [window_ addSubview:label];
    
    // 添加圈圈
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [loadingView startAnimating];
    // 文字宽度
    CGFloat msgW = [msg sizeWithAttributes:@{NSFontAttributeName : ZQMessageFont}].width;
    CGFloat centerX = (window_.frame.size.width - msgW) * 0.5 - 20;
    CGFloat centerY = window_.frame.size.height * 0.5;
    loadingView.center = CGPointMake(centerX, centerY);
    [window_ addSubview:loadingView];
}

/**
 * 隐藏
 */
+ (void)hide
{
    [timer_ invalidate];
    [UIView animateWithDuration:ZQAnimationDuration animations:^{
        CGRect frame = window_.frame;
        frame.origin.y =  - frame.size.height;
        window_.frame = frame;
    } completion:^(BOOL finished) {
        [window_ removeFromSuperview];
        window_ = nil;
        timer_ = nil;
    }];
}
/**
 * 消失时间
 */
+(void)dimissTime:(CGFloat)time{
    ZQMessageDuration = time;
    if (timer_) {
        [timer_ invalidate];
        timer_ = nil;
    }
    /** 从新开启定时器 */
    timer_ = [NSTimer scheduledTimerWithTimeInterval:ZQMessageDuration target:self selector:@selector(hide) userInfo:nil repeats:NO];
}

+(void)swipeGesture:(id)sender
{
    UISwipeGestureRecognizer *swipe = sender;
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionUp)
    {
        [ZQStatusBarHud hide];
    }
}

-(void)dealloc{
    [ZQStatusBarHud hide];
}

@end
