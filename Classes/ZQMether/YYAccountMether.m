//
//  YYAccountMether.m
//  YiYunSTP
//
//  Created by 易云物联 on 2019/5/24.
//  Copyright © 2019 yiyuniot. All rights reserved.
//

#import "YYAccountMether.h"

/*/////////////////////////////////////////////////////////////////////
 * 信息存储
 *///////////////////////////////////////////////////////////////////////
/** 存储用户账户和用密码 */
void SaveAccount(NSString *account,NSString *password){
    NSUserDefaults *userPhones = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *userPasswords = [NSUserDefaults standardUserDefaults];
    [userPhones setObject:account forKey:@"userPhone"];
    [userPasswords setObject:password forKey:@"userPassword"];
}
/** 存储用户token */
void SaveUserToken(NSString *token){
    NSUserDefaults *tokenDefault = [NSUserDefaults standardUserDefaults];
    [tokenDefault setObject:token forKey:@"token"];
}
/** 保存用户ID */
void SaveUserId(NSString *userId){
    NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
    [defult setObject:userId forKey:@"userId"];
}
/** 保存用户身份 */
void SaveUserIdentity(BOOL identity){
    NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
    [defult setBool:identity forKey:@"identity"];
}
/** 保存用户信息 */
void SavePersonalMsg(NSString *photo,NSString *name){
    NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
    [defult setObject:photo forKey:@"photo"];
    [defult setObject:name forKey:@"name"];
}
/** 保存deviceToken */
void SaveDeviceToken(NSString *deviceToken){
    NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
    [defult setObject:deviceToken forKey:@"deviceToken"];
}
/** 保存蓝牙状态 */
void SaveBluetoothState(BOOL state){
    NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
    [defult setBool:state forKey:@"BluetoothState"];
}
/** 保存上传图片最大质量 */
void SaveMaxImgSize(NSString *size){
    NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
    [defult setFloat:[size floatValue] forKey:@"maxImgSize"];
}
/*/////////////////////////////////////////////////////////////////////
 * 信息读取
 *///////////////////////////////////////////////////////////////////////
/** 读取账户 */
NSString *ReadAccount(void){
    NSUserDefaults *userPhones = [NSUserDefaults standardUserDefaults];
    return [userPhones objectForKey:@"userPhone"];
}
/** 读取密码 */
NSString *Readpassword(void){
    NSUserDefaults *userPasswords = [NSUserDefaults standardUserDefaults];
    return [userPasswords objectForKey:@"userPassword"];
}
/** 读取用户token */
NSString *ReadUserToken(void){
    NSUserDefaults *userToken = [NSUserDefaults standardUserDefaults];
    return [userToken objectForKey:@"token"];
}
/** 读取用户ID */
NSString *ReadUserId(void){
    NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
    return [defult objectForKey:@"userId"];
}
/** 读取用户名 */
NSString *ReadName(void){
    NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
    return [defult objectForKey:@"name"];
}
/** 读取用头像 */
NSString *ReadPhoto(void){
    NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
    return [defult objectForKey:@"photo"];
}
/** 读取deviceToken */
NSString *ReadDeviceToken(void){
    NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
    return [defult objectForKey:@"deviceToken"];
}
/** 读取用户身份 */
BOOL ReadUserIdentity(void){
    NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
    return [[defult objectForKey:@"identity"] boolValue];
}
BOOL ReadBluetoothState(void){
    NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
    return [defult boolForKey:@"BluetoothState"];
}
/** 读取上传图片最大质量 */
CGFloat ReadMaxImgSize(void){
    NSUserDefaults *defult = [NSUserDefaults standardUserDefaults];
    CGFloat size = [defult floatForKey:@"maxImgSize"];
    return !size ? 60:size;
}

/** 保存经纬度 */
void SaveLatAndLog(NSString *lat,NSString *log){
    NSUserDefaults *latDefult = [NSUserDefaults standardUserDefaults];
    NSUserDefaults *logDefult = [NSUserDefaults standardUserDefaults];
    [latDefult setObject:lat forKey:@"lat"];
    [logDefult setObject:log forKey:@"log"];
}
/** 保存地址 */
void SaveAddress(NSString *address){
    NSUserDefaults *addressDefult = [NSUserDefaults standardUserDefaults];
    [addressDefult setObject:address forKey:@"address"];
}

/*
 *保存需要上传的图片
 */
void saveImage(UIImage *currentImage,NSString *imageName)
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}


NSString *ReadLat(){
    NSUserDefaults *latDefult = [NSUserDefaults standardUserDefaults];
    NSString *lat = [latDefult objectForKey:@"lat"];
    if (!lat.length) {
        lat = @"";
    }
    return lat;
}
NSString *ReadLog(){
    NSUserDefaults *logDefult = [NSUserDefaults standardUserDefaults];
    NSString *log = [logDefult objectForKey:@"log"];
    if (!log.length) {
        log = @"";
    }
    return log;
}

/** 检查用户是否登录，如果未登录前去登录 */
BOOL ifLogin(UIViewController *_self){
    if (!ReadUserId()) {
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[NSClassFromString(@"YYLoginViewController") new]];
        UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
        [root presentViewController:nav animated:YES completion:nil];
        return NO;
    }else return YES;
}
/** 准备去登录 */
void ReadyToLogin(UIViewController *vc){
    NSString *string = nil;
    if (ReadUserToken()) {
        string = @"登录失效，请重新登录";
    }else string = @"您还未登录，请前去登录";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:string message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *rightAction = [UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[NSClassFromString(@"YYLoginViewController") new]];
        UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
        [root presentViewController:nav animated:YES completion:nil];
    }];
    //    UIAlertAction *cancleActions = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
    //        //        !actionBlock ?: actionBlock(@"取消");
    //    }];
    //    [alertController addAction:cancleActions];
    [alertController addAction:rightAction];
    [vc presentViewController:alertController animated:YES completion:nil];
}

/** 跳转某一个界面 */
void PresentJumpToVC(NSString *vc){
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[NSClassFromString(vc) new]];
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    [root presentViewController:nav animated:YES completion:nil];
}
