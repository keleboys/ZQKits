//
//  YYProgressHUD.m
//  YYProgressHUD
//
//  Created by 易云物联 on 2019/4/16.
//  Copyright © 2019 易云物联. All rights reserved.
//

#import "YYProgressHUD.h"
#define RGB(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define maxWidth [UIScreen mainScreen].bounds.size.width*0.6
static const CGFloat edgeMargin = 20;
static const CGFloat itemMargin = 10;
static const CGFloat iconH = 40;
static const CGFloat iconW = 40;
@interface YYProgressHUD ()
@property (strong, nonatomic, readonly) YYContentView *contentView;
@property (strong, nonatomic) YYBackgroundView *backgroundView;
/**  */
//@property (nonatomic, strong)
/**  */
@property (nonatomic, copy) YYProgressHUDDismissCompletion completionBlock;
/**  */
@property (nonatomic, strong) NSTimer *timer;
@end
NSMutableArray<UIImage *> * images_;
@implementation YYProgressHUD

+(YYProgressHUD *)manage{
    static YYProgressHUD *hud = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hud = [[YYProgressHUD alloc]init];
        images_ = [NSMutableArray array];
        for (int i=1; i<12; i++) {
            [images_ addObject:[UIImage imageNamed:[NSString stringWithFormat:@"Load_animation%d",i]]];
        }
    });
    return hud;
}

-(instancetype)init{
    if (self = [super init]) {
        self.mode = YYProgressHUDModeDefault;
        self.bkgStyle = YYProgressHUDBackgroundStyleBlur;
//        self.userInteractionEnabled = NO;
    }
    return self;
}

+ (instancetype)showLoadingHUDAddedTo:(UIView *)view{
    return [self showHUDAddedTo:view style:YYContentViewWithLoading msg:nil img:nil];
}

+ (instancetype)showSuccessHUDAddedTo:(UIView *)view msg:(NSString *)msg{
    return [self showHUDAddedTo:view style:YYContentViewWithSuccess msg:msg img:@"YYProgressHUD.bundle/Common_icon_success"];
}

+ (instancetype)showErrorHUDAddedTo:(UIView *)view msg:(NSString *)msg;{
    return [self showHUDAddedTo:view style:YYContentViewWithError msg:msg img:@"YYProgressHUD.bundle/Common_icon_fail"];
}

+ (instancetype)showAlertHUDAddedTo:(UIView *)view msg:(NSString *)msg{
    return [self showHUDAddedTo:view style:YYContentViewWithAlert msg:msg img:@"YYProgressHUD.bundle/Common_icon_becareful"];
}

+ (instancetype)showMsgHUDAddedTo:(UIView *)view offset:(CGPoint)offset msg:(NSString *)msg;{
    return [self showHUDAddedTo:view style:YYContentViewWithMsg msg:msg img:nil];
}

+ (instancetype)showHUDAddedTo:(UIView *)view style:(YYContentViewStyle)style msg:(nullable NSString *)msg img:(nullable NSString *)img{
    NSAssert(view, @"View must not be nil.");
    YYProgressHUD *hud = [YYProgressHUD manage];
    dispatch_async(dispatch_get_main_queue(), ^{
        hud.removeFromSuperViewOnHide = YES;
        hud.frame = view.frame;
        [view addSubview:hud];
        [hud initViewWithContentViewStyle:style msg:msg img:img];
        if (style != YYContentViewWithLoading) {
            [self dismissWithDelay:2 completion:nil];
        }
    });
    return hud;
}

-(YYBackgroundView *)backgroundView{
    if (_backgroundView == nil) {
        _backgroundView = [[YYBackgroundView alloc]initWithFrame:self.bounds];
        _backgroundView.style = YYProgressHUDBackgroundStyleSolidColor;
        _backgroundView.color = [UIColor colorWithRed:(246)/255 green:(246)/255 blue:(246)/255 alpha:0.5];
    }
    return _backgroundView;
}

-(void)initViewWithContentViewStyle:(YYContentViewStyle)style msg:(nullable NSString *)msg img:(nullable NSString *)img{
    [self addSubview:self.backgroundView];
    
    CGRect rect = CGRectZero;
    if (style==YYContentViewWithLoading) {
        rect = CGRectMake(0, 0, 120, 120);
    }else if(style==YYContentViewWithSuccess||style==YYContentViewWithAlert||style==YYContentViewWithError){
        CGSize textSize =  [msg boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
        CGFloat width = (textSize.width>iconW?textSize.width:iconW)+2*edgeMargin;
        CGFloat height = textSize.height+2*edgeMargin+iconH+itemMargin;
        width = width>height?width:height;
        rect = CGRectMake(0, 0, width, height);
    }
    YYContentView *contentView = [[YYContentView alloc]initWithFrame:rect style:style msg:msg img:img];
    contentView.center = self.center;
    [self addSubview:contentView];
    _contentView = contentView;
    
    if (style!=YYContentViewWithLoading)  {
        contentView.backgroundColor = SVProgressHudBackColor;
    }
}

+(void)dimiss{
    [[self manage] dimiss];
}

+ (void)dismissWithDelay:(NSTimeInterval)delay{
    [self dismissWithDelay:delay completion:nil];
}

+ (void)dismissWithDelay:(NSTimeInterval)delay completion:(nullable YYProgressHUDDismissCompletion)completion{
    [[self manage] dismissWithDelay:delay completion:completion];
}

- (void)dismissWithDelay:(NSTimeInterval)delay completion:(nullable YYProgressHUDDismissCompletion)completion{
    self.completionBlock = completion;
    _timer = [NSTimer timerWithTimeInterval:delay target:self selector:@selector(handleGraceTimer:) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)handleGraceTimer:(NSTimer *)theTimer {
    [theTimer invalidate];
    theTimer = nil;
    [self dimiss];
}

-(void)dimiss{
    [_timer invalidate];
    _timer = nil;
    [_contentView removeFromSuperview];
    [_backgroundView removeFromSuperview];
    [self removeFromSuperview];
    _backgroundView = nil;
    !self.completionBlock ?: self.completionBlock();
}

-(void)setRemoveFromSuperViewOnHide:(BOOL)removeFromSuperViewOnHide{
    if (removeFromSuperViewOnHide) {
        [self removeFromSuperview];
    }
}

/**  */
+(void)setContentColor:(UIColor *)contentColor{
    [self manage].contentView.backgroundColor = contentColor;
}

+(void)setStyle:(YYProgressHUDBackgroundStyle)style{
    [self manage].backgroundView.style = style;
}
+(void)setTextColor:(UIColor *)textColor{
    [self manage].contentView.textColor = textColor;
}
+(void)setBackgroudColoc:(UIColor *)backgroudColoc{
    [self manage].backgroundView.color = backgroudColoc;
}

-(void)setContentColor:(UIColor *)contentColor{
    _contentView.backgroundColor = contentColor;
}

-(void)setTextColor:(UIColor *)textColor{
    _contentView.textColor = textColor;
}

-(void)setBackgroudColoc:(UIColor *)backgroudColoc{
    _backgroundView.color = backgroudColoc;
}

-(void)setBkgStyle:(YYProgressHUDBackgroundStyle)bkgStyle{
    _backgroundView.style = bkgStyle;
}

-(void)dealloc{
    [_timer invalidate];
    _timer = nil;
}

@end


@interface YYContentView ()
/**  */
@property (nonatomic, strong) UIImageView *imageView;
/**  */
@property (nonatomic, strong) UIColor *color;
/**  */
@property (nonatomic, assign) YYContentViewStyle style;
/**  */
@property (nonatomic, strong) UIView *contentView;
/**  */
@property (nonatomic, copy) NSString *msg;
/**  */
@property (nonatomic, copy) NSString *img;
@end

@implementation YYContentView

-(UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]init];
        [self addSubview:_imageView];
    }
    return _imageView;
}

-(instancetype)initWithFrame:(CGRect)frame style:(YYContentViewStyle)style msg:(nullable NSString *)msg img:(nullable NSString *)img{
    if (self = [super initWithFrame:frame]) {
        self.corner = 8;
        self.style = style;
        self.img = img;
        self.msg = msg;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        UIView *contentView = [[UIView alloc]init];
        contentView.center = self.center;
        [self addSubview:contentView];
        _contentView = contentView;
        
        if (style ==YYContentViewWithLoading) {
            self.color = RGB(112, 209, 255, 1);
            contentView.frame = CGRectMake(edgeMargin, edgeMargin, self.frame.size.width-edgeMargin*2, self.frame.size.height-edgeMargin*2);
//            [contentView.layer addSublayer:[self replicatorLayerWithRadius:contentView.frame.size.width/2]];
            self.imageView.frame = CGRectMake(0,  0, contentView.frame.size.width, contentView.frame.size.width);
            self.imageView.animationImages = images_;
            self.imageView.animationRepeatCount = MAXFLOAT;
            self.imageView.animationDuration = 2.5;
            self.imageView.center = contentView.center;
            [self.imageView startAnimating];
        }else if(style==YYContentViewWithSuccess||style==YYContentViewWithAlert||style==YYContentViewWithError){
            self.color =  [UIColor whiteColor];
            contentView.frame = CGRectMake(edgeMargin, edgeMargin, self.frame.size.width-edgeMargin*2, self.frame.size.height-edgeMargin*2);
            self.imageView.frame = CGRectMake(0, 0, contentView.frame.size.width, contentView.frame.size.height);
            [self setTextColor:self.color];
        }
        if (self.msg) {
            [self setTextColor:self.color];
        }
    }
    return self;
}

-(void)setTextColor:(UIColor *)textColor{
    self.color = textColor;
    UIImage *image = nil;
    if (self.style == YYContentViewWithLoading) {
        image = [self drawSize:CGSizeMake(_contentView.frame.size.width, 30) text:nil font:16 icon:nil];
    }else{
        image = [self drawSize:_contentView.frame.size text:_msg font:16 icon:_img];
    }
    self.imageView.image = image;
    self.imageView.center = _contentView.center;
}

-(UIImage *)drawSize:(CGSize)size text:(NSString *)text font:(NSInteger)font icon:(nullable NSString *)icon{
    NSAssert(text, @"text must not be nil.");
    CGSize textSize =  [text boundingRectWithSize:CGSizeMake(size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    if (icon) {
        UIImage *image = [UIImage imageNamed:icon];
        NSAssert(image, @"image must not be nil.");
        [image drawInRect:CGRectMake((size.width-iconW)/2, 0, iconW, iconH)];
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:font],
                           NSForegroundColorAttributeName:self.color,
                           NSParagraphStyleAttributeName: paragraphStyle
                           };
    CGFloat textY =  icon?(itemMargin+iconH):0;
    [text drawInRect:CGRectMake((size.width-textSize.width)/2, textY, textSize.width, textSize.height) withAttributes:dict];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(CAReplicatorLayer *)replicatorLayerWithRadius:(CGFloat)radius{
    CAShapeLayer *sharLayer = [[CAShapeLayer alloc]init];
    CGFloat smallRadius = 12;
    sharLayer.frame = CGRectMake(radius, 0, smallRadius, smallRadius);
    sharLayer.path =[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, smallRadius, smallRadius) cornerRadius:smallRadius/2].CGPath;
    sharLayer.fillColor = self.color.CGColor;
    sharLayer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1);
    CABasicAnimation *animation = [self scaleAnimationWithfromValue:1 toValue:0.1];
    [sharLayer addAnimation:animation forKey:nil];
    
    CAReplicatorLayer *replicatorLayer = [[CAReplicatorLayer alloc]init];
    replicatorLayer.frame = CGRectMake(0, 0,radius*2, radius*2);
    replicatorLayer.instanceCount = 16;
    replicatorLayer.instanceDelay = 0.06;
    replicatorLayer.instanceAlphaOffset = -0.05;
    CGFloat angle = 2*M_PI/ 16;
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    [replicatorLayer addSublayer:sharLayer];
    return replicatorLayer;
}

-(CABasicAnimation *)scaleAnimationWithfromValue:(CGFloat)fromValue toValue:(CGFloat)toValue{
    CABasicAnimation *scale = [[CABasicAnimation alloc]init];
    scale.keyPath = @"transform";
    scale.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(fromValue, fromValue, 1)];
    scale.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(toValue, toValue, 1)];
    scale.duration = 0.96;
    scale.repeatCount = HUGE;
    scale.autoreverses = false;
    return scale;
}

@end

@interface YYBackgroundView ()
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 || TARGET_OS_TV
@property UIVisualEffectView *effectView;
#endif
#if !TARGET_OS_TV
@property UIToolbar *toolbar;
#endif
@end

@implementation YYBackgroundView
#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_7_0) {
            _style = YYProgressHUDBackgroundStyleBlur;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 || TARGET_OS_TV
            _blurEffectStyle = UIBlurEffectStyleLight;
#endif
            if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0) {
                _color = [UIColor colorWithWhite:0.8f alpha:0.6f];
            } else {
                _color = [UIColor colorWithWhite:0.95f alpha:0.6f];
            }
        } else {
            _style = YYProgressHUDBackgroundStyleSolidColor;
            _color = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        }
        self.clipsToBounds = YES;
        
        [self updateForBackgroundStyle];
    }
    return self;
}

#pragma mark - Layout

- (CGSize)intrinsicContentSize {
    // Smallest size possible. Content pushes against this.
    return CGSizeZero;
}

#pragma mark - Appearance

- (void)setStyle:(YYProgressHUDBackgroundStyle)style {
    if (style == YYProgressHUDBackgroundStyleBlur && kCFCoreFoundationVersionNumber < kCFCoreFoundationVersionNumber_iOS_7_0) {
        style = YYProgressHUDBackgroundStyleSolidColor;
    }
    if (_style != style) {
        _style = style;
        [self updateForBackgroundStyle];
    }
}

- (void)setColor:(UIColor *)color {
    NSAssert(color, @"The color should not be nil.");
    if (color != _color && ![color isEqual:_color]) {
        _color = color;
        [self updateViewsForColor:color];
    }
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 || TARGET_OS_TV

- (void)setBlurEffectStyle:(UIBlurEffectStyle)blurEffectStyle {
    if (_blurEffectStyle == blurEffectStyle) {
        return;
    }
    
    _blurEffectStyle = blurEffectStyle;
    
    [self updateForBackgroundStyle];
}

#endif

///////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Views

- (void)updateForBackgroundStyle {
    YYProgressHUDBackgroundStyle style = self.style;
    if (style == YYProgressHUDBackgroundStyleBlur) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 || TARGET_OS_TV
        if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0) {
            UIBlurEffect *effect = [UIBlurEffect effectWithStyle:self.blurEffectStyle];
            UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
            [self addSubview:effectView];
            effectView.frame = self.bounds;
            effectView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            self.backgroundColor = self.color;
            self.layer.allowsGroupOpacity = NO;
            self.effectView = effectView;
        } else {
#endif
#if !TARGET_OS_TV
            UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectInset(self.bounds, -100.f, -100.f)];
            toolbar.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            toolbar.barTintColor = self.color;
            toolbar.translucent = YES;
            [self addSubview:toolbar];
            self.toolbar = toolbar;
#endif
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 || TARGET_OS_TV
        }
#endif
    } else {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 || TARGET_OS_TV
        if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0) {
            [self.effectView removeFromSuperview];
            self.effectView = nil;
        } else {
#endif
#if !TARGET_OS_TV
            [self.toolbar removeFromSuperview];
            self.toolbar = nil;
#endif
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 || TARGET_OS_TV
        }
#endif
        self.backgroundColor = self.color;
    }
}

- (void)updateViewsForColor:(UIColor *)color {
    if (self.style == YYProgressHUDBackgroundStyleBlur) {
        if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_8_0) {
            self.backgroundColor = self.color;
        } else {
#if !TARGET_OS_TV
            self.toolbar.barTintColor = color;
#endif
        }
    } else {
        self.backgroundColor = self.color;
    }
}

@end
