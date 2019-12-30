//
//  YYSystemMether.m
//  YiYunSTP
//
//  Created by 易云物联 on 2019/3/22.
//  Copyright © 2019 yiyuniot. All rights reserved.
//

#import "YYSystemMether.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import <objc/runtime.h>
static NSString * const STOREAPPID     =  @"https://itunes.apple.com/cn/app/YiYunSTP/id1460625090?mt=8";
///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL YYIsPad(void) {
#ifdef __IPHONE_3_2
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
#else
    return NO;
#endif
}
///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL YYIsPhoneSupported(void) {
    NSString* deviceType = [UIDevice currentDevice].model;
    return [deviceType isEqualToString:@"iPhone"];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
NSString* YYDeviceModelName(void) {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    if ([platform isEqualToString:@"iPhone3,1"] ||
        [platform isEqualToString:@"iPhone3,2"])   return @"iPhone4";
    
    if ([platform isEqualToString:@"iPhone4,1"])   return @"iPhone4S";
    
    if ([platform isEqualToString:@"iPhone5,1"] ||
        [platform isEqualToString:@"iPhone5,2"])   return @"iPhone5";
    
    if ([platform isEqualToString:@"iPhone5,3"] ||
        [platform isEqualToString:@"iPhone5,4"])   return @"iPhone5C";
    
    if ([platform isEqualToString:@"iPhone6,1"] ||
        [platform isEqualToString:@"iPhone6,2"])   return @"iPhone5S";
    
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([platform isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"])   return @"iPhone_8";
    if ([platform isEqualToString:@"iPhone10,4"])   return @"iPhone_8";
    if ([platform isEqualToString:@"iPhone10,2"])   return @"iPhone_8_Plus";
    if ([platform isEqualToString:@"iPhone10,5"])   return @"iPhone_8_Plus";
    if ([platform isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    if ([platform isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";
    
    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad";
    
    if ([platform isEqualToString:@"iPad2,1"] ||
        [platform isEqualToString:@"iPad2,2"] ||
        [platform isEqualToString:@"iPad2,3"] ||
        [platform isEqualToString:@"iPad2,4"]) return @"iPad2";
    
    if ([platform isEqualToString:@"iPad3,1"] ||
        [platform isEqualToString:@"iPad3,2"] ||
        [platform isEqualToString:@"iPad3,3"]) return @"iPad3";
    
    if ([platform isEqualToString:@"iPad3,4"] ||
        [platform isEqualToString:@"iPad3,5"] ||
        [platform isEqualToString:@"iPad3,6"]) return @"iPad4";
    
    if ([platform isEqualToString:@"iPad4,1"] ||
        [platform isEqualToString:@"iPad4,2"] ||
        [platform isEqualToString:@"iPad4,3"]) return @"iPadAir";
    
    if ([platform isEqualToString:@"iPad5,3"] ||
        [platform isEqualToString:@"iPad5,4"]) return @"iPadAir2";
    
    if ([platform isEqualToString:@"iPad6,3"] ||
        [platform isEqualToString:@"iPad6,4"]) return @"iPadPro9.7-inch";
    
    if ([platform isEqualToString:@"iPad6,7"] ||
        [platform isEqualToString:@"iPad6,8"]) return @"iPadPro12.9-inch";
    
    if ([platform isEqualToString:@"iPad6,11"] ||
        [platform isEqualToString:@"iPad6,12"]) return @"iPad5";
    
    if ([platform isEqualToString:@"iPad7,1"] ||
        [platform isEqualToString:@"iPad7,2"]) return @"iPadPro12.9-inch 2";
    
    if ([platform isEqualToString:@"iPad7,3"] ||
        [platform isEqualToString:@"iPad7,4"]) return @"iPadPro10.5-inch";
    
    if ([platform isEqualToString:@"iPad2,5"] ||
        [platform isEqualToString:@"iPad2,6"] ||
        [platform isEqualToString:@"iPad2,7"]) return @"iPadmini";
    
    if ([platform isEqualToString:@"iPad4,4"] ||
        [platform isEqualToString:@"iPad4,5"] ||
        [platform isEqualToString:@"iPad4,6"]) return @"iPadmini2";
    
    if ([platform isEqualToString:@"iPad4,7"] ||
        [platform isEqualToString:@"iPad4,8"] ||
        [platform isEqualToString:@"iPad4,9"]) return @"iPadmini3";
    
    if ([platform isEqualToString:@"iPad5,1"] ||
        [platform isEqualToString:@"iPad5,2"]) return @"iPadmini4";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhoneSimulator";
    
    if ([platform isEqualToString:@"x86_64"])    return @"iPhoneSimulator";
    
    return platform;
}

/*
 *获取当前版本号
 */
NSString *YYReadAppVersion(void){
    //2先获取当前工程项目版本号
    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];
    //    ZQLog(@"currentVersion==%@",currentVersion);
    return currentVersion;
}

/**
 *  天朝专用检测app更新
 */
void YYhsUpdateApp(UIViewController *superVC){
    //3从网络获取appStore版本号[NSURLSession dataTaskWithRequest:completionHandler:]
    NSError *error;
    NSData *response = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",@"1460625090"]]] returningResponse:nil error:nil];
    if (response == nil) {
        ZQLog(@"你没有连接网络哦");
        return;
    }
    NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//        ZQLog(@"response====%@",appInfoDic);
    if (error) {
        ZQLog(@"hsUpdateAppError:%@",error);
        return;
    }
    NSArray *array = appInfoDic[@"results"];
    
    if (array.count < 1) {
        ZQLog(@"此APPID为未上架的APP或者查询不到");
        return;
    }
    
    NSDictionary *dic = array[0];
    NSString *appStoreVersion = dic[@"version"];
    //打印版本号
   ZQLog(@"当前版本号:\n商店版本号:%@",appStoreVersion);
    //设置版本号
    NSString *currentVersion = YYReadAppVersion();
    currentVersion = [currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    if (currentVersion.length==2) {
        currentVersion  = [currentVersion stringByAppendingString:@"0"];
    }else if (currentVersion.length==1){
        currentVersion  = [currentVersion stringByAppendingString:@"00"];
    }
    appStoreVersion = [appStoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    if (appStoreVersion.length==2) {
        appStoreVersion  = [appStoreVersion stringByAppendingString:@"0"];
    }else if (appStoreVersion.length==1){
        appStoreVersion  = [appStoreVersion stringByAppendingString:@"00"];
    }
    //4当前版本号小于商店版本号,就更新
    if([currentVersion floatValue] < [appStoreVersion floatValue])
    {
        UIAlertController *alercConteoller = [UIAlertController alertControllerWithTitle:@"版本有更新" message:[NSString stringWithFormat:@"检测到新版本(%@),是否更新?",dic[@"version"]] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //此处加入应用在app store的地址，方便用户去更新，一种实现方式如下
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:STOREAPPID]];
            [[UIApplication sharedApplication] openURL:url];
        }];
        UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
//        [actionNo setValue:YYColorLightText forKey:@"titleTextColor"];
//        [actionYes setValue:YYColorBlue forKey:@"titleTextColor"];
        [alercConteoller addAction:actionYes];
        [alercConteoller addAction:actionNo];
        [superVC presentViewController:alercConteoller animated:YES completion:nil];
    }
}

/*
 *检查是否是iPhone X
 */
BOOL YYIS_IPHONE_X(void){
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }else{
        return YYScreenHeight==812;
    }
    return iPhoneXSeries;
}
/*
 *获取NavContentBar高度
 */
CGFloat YYHeight_NavContentBar(void){
    return (YYIS_IPHONE_X()==YES)?34.0f: 0.0;
}
/*
 *获取StatusBar高度
 */
CGFloat YYHeight_StatusBar(void){
    return (YYIS_IPHONE_X()==YES)?44.0f: 20.0f;
}
/*
 *获取TabBar高度
 */
CGFloat YYHeight_TabBar(void){
    return (YYIS_IPHONE_X()==YES)?83.0f: 49.0f;
}
/*
 *获取NavBar高度
 */
CGFloat YYHeight_NavBar(void){
    return (YYIS_IPHONE_X()==YES)?88.0f: 64.0f;
}
/*
 *获取屏幕高度
 */
CGFloat YYHeight_Screen(void){
    return [UIScreen mainScreen].bounds.size.height;
}
/*
 *获取系统版本号
 */
NSString *YYSystemVersion(void){
    return [UIDevice currentDevice].systemVersion;
}

NSMutableAttributedString* YYTextNutableAttrubute(NSString *string,NSRange rangle,NSInteger font,UIColor *color){
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedText addAttribute:NSForegroundColorAttributeName value:color range:rangle];
    [attributedText addAttribute:NSFontAttributeName value:YYFontSize(font) range:rangle];
    return attributedText;
}

NSMutableAttributedString* YYTextNutableAttrubuteHorXian(NSString *string,NSRange rangle,NSInteger font,UIColor *color){
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedText addAttribute:NSForegroundColorAttributeName value:color range:rangle];
    [attributedText addAttribute:NSFontAttributeName value:YYFontSize(font) range:rangle];
    NSDictionary * attris = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInt:2],NSStrikethroughColorAttributeName:[UIColor grayColor]};
    [attributedText setAttributes:attris range:rangle];
    return attributedText;
}

NSArray * getAllProperties(Class cls) {
    if (!cls) return @[];
    NSMutableArray * all_p = [NSMutableArray array];
    unsigned int a;
    Ivar * iv = class_copyIvarList(cls, &a);
    for (unsigned int i = 0; i < a; i++) {
        Ivar i_v = iv[i];
        [all_p addObject:[[NSMutableString stringWithFormat:@"%s", ivar_getName(i_v)] stringByReplacingOccurrencesOfString:@"_" withString:@""]];
    }
    free(iv);
    
    return [all_p copy];
}

/** 保存微信OpenID */
void SaveWXOpenId(NSString *openId) {
    NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
    [defult setObject:openId forKey:@"openId"];

}
/** 读取微信OpenID */
NSString *ReadWXOpenId(void){
    NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
    return [defult objectForKey:@"openId"];
}
