//
//  YYAccountMether.h
//  YiYunSTP
//
//  Created by 易云物联 on 2019/5/24.
//  Copyright © 2019 yiyuniot. All rights reserved.
//

/** 存储用户账户和用密码 */
void SaveAccount(NSString *account,NSString *password);
/** 存储用户token */
void SaveUserToken(NSString *token);
/** 保存用户ID */
void SaveUserId(NSString *userId);
/** 保存用户身份 */
void SaveUserIdentity(BOOL identity);
/** 保存用户信息 */
void SavePersonalMsg(NSString *photo,NSString *name);
/** 保存deviceToken */
void SaveDeviceToken(NSString *deviceToken);
/** 保存蓝牙状态 */
void SaveBluetoothState(BOOL state);
/** 保存上传图片最大质量 */
void SaveMaxImgSize(NSString *size);

/** 读取账户 */
NSString *ReadAccount(void);
/** 读取密码 */
NSString *Readpassword(void);
/** 读取用户token */
NSString *ReadUserToken(void);
/** 读取用户ID */
NSString *ReadUserId(void);
/** 读取用户名 */
NSString *ReadName(void);
/** 读取用头像 */
NSString *ReadPhoto(void);
/** 读取deviceToken */
NSString *ReadDeviceToken(void);
/** 读取用户身份 */
BOOL ReadUserIdentity(void);
/** 读取蓝牙状态 */
BOOL ReadBluetoothState(void);
/** 读取上传图片最大质量 */
CGFloat ReadMaxImgSize(void);

/** 保存经纬度 */
void SaveLatAndLog(NSString *lat,NSString *log);
/** 保存地址 */
void SaveAddress(NSString *address);

/** 检查用户是否登录，如果未登录前去登录 */
BOOL ifLogin(UIViewController *_self);
/** 准备去登录 */
void ReadyToLogin(UIViewController *vc);
/** 跳转某一个界面 */
void PresentJumpToVC(NSString *vc);
