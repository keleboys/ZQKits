//
//  YYSystemMether.h
//  YiYunSTP
//
//  Created by 易云物联 on 2019/3/22.
//  Copyright © 2019 yiyuniot. All rights reserved.
//

/**
 * @return device full model name in human readable strings
 */
NSString* YYDeviceModelName(void);
/** 是否支持手机 */
BOOL YYIsPhoneSupported(void);
/**
 * @return TRUE if the device is iPad.
 */
BOOL YYIsPad(void);
/*
 *当前版本号
 */
NSString *YYReadAppVersion(void);
/*
 *检查app是否有更新
 */
void YYhsUpdateApp(UIViewController *superVC);
/*
 *检查是否是iPhone X
 */
BOOL YYIS_IPHONE_X(void);
/*
 *获取NavContentBar高度
 */
CGFloat YYHeight_NavContentBar(void);
/*
 *获取StatusBar高度
 */
CGFloat YYHeight_StatusBar(void);
/*
 *获取TabBar高度
 */
CGFloat YYHeight_TabBar(void);
/*
 *获取NavBar高度
 */
CGFloat YYHeight_NavBar(void);
/*
 *获取屏幕高度
 */
CGFloat YYHeight_Screen(void);
/*
 *获取系统版本号
 */
NSString *YYSystemVersion(void);

NSMutableAttributedString* YYTextNutableAttrubute(NSString *string,NSRange rangle,NSInteger font,UIColor *color);


NSMutableAttributedString* YYTextNutableAttrubuteHorXian(NSString *string,NSRange rangle,NSInteger font,UIColor *color);

/**
 获取指定类的变量
 @param cls 被获取变量的类
 @return 变量名称集合 [NSString *]
 */
NSArray * getAllProperties(Class cls);

/** 保存微信OpenID */
void SaveWXOpenId(NSString *openId);
/** 读取微信OpenID */
NSString *ReadWXOpenId(void);
