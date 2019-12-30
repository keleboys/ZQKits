//
//  ZQBasisDefine.h
//  ZQKitTest
//
//  Created by 张泉 on 2019/12/30.
//  Copyright © 2019 张泉. All rights reserved.
//

#ifndef ZQBasisDefine_h
#define ZQBasisDefine_h

#define YYFontSize(s)          ([UIFont systemFontOfSize:s])

#define YYScreenWidth         ([[UIScreen mainScreen] bounds].size.width)
#define YYScreenHeight        ([[UIScreen mainScreen] bounds].size.height)
#define YYStatusBarHeight     ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define YYApplicationHeight   (YYScreenHeight - YYStatusBarHeight)

#define SVProgressHudBackColor [UIColor colorWithRed:(51)/255.0f  green:(51)/255.0f  blue:(51)/255.0f alpha:1]

#define YYViewScaleX_375    (YYScreenWidth / 375.f)
#define YYViewScaleY_375    YYViewScaleX_375
#define YYViewScaleY_667    (YYFourSevenInch ? 1 : (YYScreenHeight / 667.f))
#define YYFlt(Width)       Width*YYViewScaleX_375



#ifdef DEBUG // 调试状态, 打开LOG功能
#define ZQLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else // 发布状态, 关闭LOG功能
#define ZQLog(...)
#endif

//开发环境
//#ifdef DEBUG
//  #define ENDPOINT @"http://192.168.5.101:8400"
//  #define WEBENDPOINT @"http://192.168.5.180:3000/#"
//  #define PAYPOINT @"https://manager.yiyun-smart.com/"
//#else
  #define ENDPOINT @"https://proapi.yiyun-smart.com"
  #define WEBENDPOINT @"https://h5.yiyun-smart.com/#"
  #define PAYPOINT @"https://manager.yiyun-smart.com/"
//#endif


#endif /* ZQBasisDefine_h */
