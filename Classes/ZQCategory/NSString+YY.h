//
//  NSString+YY.h
//  YiYunSTP
//
//  Created by apple on 2019/3/21.
//  Copyright © 2019年 yiyuniot. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (YY)
/** json转z数组 */
-(NSArray *)jsonToArray;
//是否为空
+ (BOOL)isEmpty:(NSString *)sender;

//是否有值
+ (BOOL)isPresent:(id)sender;

//字典转化字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

/**
 * 当精度丢失时 保留两位有效数字（字符串转浮点型 可能精度丢失）
 */
+ (NSString *)number2ScaleString:(NSNumber *)number;

//去除字符串两端的空格，换行
+ (NSString *)trim:(NSString *)string;

//获取ixuea.com/courses/1，的id
+ (NSString *)getUrlId:(NSString *)url;

//判断密码，格式，>=5 && <=15
+ (BOOL)isPassword:(NSString *)password;


/**
 格式化播放次数
 例如：289万
 
 @param count <#count description#>
 @return <#return value description#>
 */
+ (NSString *)formatCount:(long)count;


/**
 移除字符串中首的@；移除收尾的#
 
 @param str <#str description#>
 @return <#return value description#>
 */
+ (NSString *)removePlaceholderString:(NSString *)str;

/**
 从网址中获取path，并移除第一个斜线
 
 @param str <#str description#>
 @return <#return value description#>
 */
+ (NSString *)removePathString:(NSString *)str;

/**  获取GUID*/
+ (NSString *)getGUID;

@end

@interface NSString (Device)

/**  获取版本号*/
+ (NSString *)getAppVersion;

/**  获取UUID*/
+ (NSString *)getUUIDByKeyChain;

@end

@interface NSString (Regular)

/**
 通过正则判断手机号格式是否正确
 
 @param phone 手机号
 @return YES:正确，NO:不正确
 */
+ (BOOL)isPhone:(NSString *)phone;

/**
 *  身份证号码判断
 *  @param value 身份证号
 *  @return BOOL
 */
+ (BOOL)isIDCardNumber:(NSString *)value;

/**
 *  车牌号判断
 *  @param value车牌号
 *  @return BOOL
 */
+ (BOOL)isVehiclePlateNumber:(NSString *)value;

@end

@interface NSString (Emoji)

- (BOOL)isEmoji;

@end

@interface NSString (Time)
//时分秒
+ (NSString *)minuteStringWithTimeInterval:(NSTimeInterval)timeInterval;
//时分秒
+ (NSString *)stringWithTimeInterval:(NSTimeInterval)timeInterval;
//月 天
+ (NSString *)monthlyStringWithTimeInterval:(NSTimeInterval)timeInterval;

@end

@interface NSString (Number)

/**
 *  转换为逗号分割，保留2位小数
 */
+ (NSString *)convertToDecimalStyleWithTwoDigitsFromString:(NSString *)str;

@end

@interface NSString (Money)
/**
 *  判断输入单个字符后数字是否非法 金额输入
 */
+ (BOOL)illegalSingleNumber:(NSString *)originSingleNumberText withInput:(NSString *)input;

/**
 *  如果合法合成有效的字符串 金额输入
 */
+ (NSString *)changeSingleNumber:(NSString *)originSingleNumberText withInput: (NSString *)input;

@end

@interface NSString (System)
//获取 bundle version版本号
+ (NSString*)getLocalAppVersion;

//获取BundleID
+ (NSString*)getBundleID;

//获取app的名字
+ (NSString*)getAppName;

@end

@interface NSString (IsChinese)
/** 字符串是否是中文 */
- (BOOL)isChinese;
/** 字符串中是否包含中文 */
- (BOOL)checkContainsChinese;

@end


NS_ASSUME_NONNULL_END
