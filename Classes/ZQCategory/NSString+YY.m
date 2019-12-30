//
//  NSString+YY.m
//  YiYunSTP
//
//  Created by apple on 2019/3/21.
//  Copyright © 2019年 yiyuniot. All rights reserved.
//

#import "NSString+YY.h"
#import <objc/runtime.h>
#import "KeyChainStore.h"

@implementation NSString (YY)

-(NSArray *)jsonToArray{
    if (!self.length) {
        return @[];
    }
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    return[NSJSONSerialization JSONObjectWithData:jsonData
                                          options:NSJSONReadingMutableContainers
                                            error:&error];
}       

+ (BOOL)isEmpty:(NSString *)text{
    if([text isEqualToString:@""] || [text isEqualToString:@"<null>"] ||  text.length == 0 || text == nil){
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)isPresent:(id)text{
    if (text == nil || text == NULL) {
        return NO;
    }
    
    if ([text isKindOfClass:[NSNull class]]) {
        return NO;
    }
    
    if ([text isKindOfClass:[NSString class]]) {
        if ([[text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
            return NO;
        }
    }
    return YES;
}

+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSString *)number2ScaleString:(NSNumber *)number
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setMinimumFractionDigits:2];
    
    return [numberFormatter stringFromNumber:number];
}

+ (NSString *)trim:(NSString *)string{
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    NSString *trimmedStr = [string stringByTrimmingCharactersInSet:set];
    return trimmedStr;
}


+ (NSString *)getUrlId:(NSString *)url{
    return [url lastPathComponent];
}

+ (BOOL)isPassword:(NSString *)password{
    return password.length>=6 && password.length<=30;
}

+ (NSString *)formatCount:(long)count{
    if (count>=10000) {
        count=count/10000;
        return [NSString stringWithFormat:@"%ld万",count];
    }
    return [NSString stringWithFormat:@"%ld",count];
}

+ (NSString *)removePlaceholderString:(NSString *)str{
    if ([str hasPrefix:@"@"]) {
        return [str substringFromIndex:1];
    }else if ([str hasPrefix:@"#"]){
        return [str substringWithRange:NSMakeRange(1, str.length-2)];
    }
    
    return str;
}

+ (NSString *)removePathString:(NSString *)str{
    //获取业务数据，如：名称
    //由于当前下载框架，不可以自定义Id，所以只能用Uri查询
    
    //例如：http://dev-courses-misuc.ixuea.com/assets/s1.mp3
    NSURL *url=[NSURL URLWithString:str];
    
    //path为/assets/s1.mp3
    
    //还需要将第一个斜线去除
    return [url.path substringFromIndex:1];
}

+ (NSString *)getGUID {
    CFUUIDRef uuidObj = CFUUIDCreate(kCFAllocatorDefault);//create a new UUID
    //get the string representation of the UUID
    NSString *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuidObj);
    CFRelease(uuidObj);
    return uuidString;
}

@end

@implementation NSString (Device)

/**  获取版本号*/
+ (NSString *)getAppVersion;
{
    NSString *key = @"CFBundleShortVersionString";
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    
    return version;
}

/**  获取UUID*/
+ (NSString *)getUUID{
    NSString *uuid = [[UIDevice currentDevice].identifierForVendor UUIDString];
    return uuid;
}

/**  获取UUID*/
+ (NSString *)getUUIDByKeyChain{
    
    NSString *key = [NSString getBundleID];
    NSString*strUUID = (NSString*)[KeyChainStore load:key];
    
    //首次执行该方法时，uuid为空
    if([strUUID isEqualToString:@""]|| !strUUID)
    {
        
        // 获取UUID
        strUUID = [self getUUID];
        
        if(strUUID.length ==0 || [strUUID isEqualToString:@"00000000-0000-0000-0000-000000000000"])
        {
            //生成一个uuid的方法
            CFUUIDRef uuidRef= CFUUIDCreate(kCFAllocatorDefault);
            strUUID = (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault,uuidRef));
            CFRelease(uuidRef);
        }
        
        //将该uuid保存到keychain
        [KeyChainStore save:key data:strUUID];
        
    }
    return strUUID;
}

@end


@implementation NSString (Regular)

+ (BOOL)isPhone:(NSString *)phone{
//    /**
//     * 手机号码
//     * 移动：134 135 136 137 138 139 147 150 151 152 157 158 159 178 182 183 184 187 188 198
//     * 联通：130 131 132 145 155 156 166 171 175 176 185 186
//     * 电信：133 149 153 173 177 180 181 189 199
//     * 虚拟运营商: 170
//     */
//    NSString *target = @"^(0|86|17951)?(13[0-9]|15[012356789]|16[6]|19[89]]|17[01345678]|18[0-9]|14[579])[0-9]{8}$";
    NSString *target = @"^(1)\\d{10}$";
    NSPredicate *targetPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", target];
    if ([targetPredicate evaluateWithObject:phone]) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isVehiclePlateNumber:(NSString *)value {
    NSString *target = @"^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$";
    NSPredicate *targetPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", target];
    if ([targetPredicate evaluateWithObject:value]) {
        return YES;
    }
    return NO;
}

/**
 *  身份证号码判断
 *  @param value 身份证号
 *  @return BOOL
 */
+ (BOOL)isIDCardNumber:(NSString *)value{
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length =0;
    if (!value) {
        return NO;
    }else {
        length = value.length;
        //不满足15位和18位，即身份证错误
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray = @[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    // 检测省份身份行政区代码
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag =NO; //标识省份代码是否正确
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return NO;
    }
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    //分为15位、18位身份证进行校验
    switch (length) {
        case 15:
            //获取年份对应的数字
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                //创建正则表达式 NSRegularExpressionCaseInsensitive：不区分字母大小写的模式
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }
            //使用正则表达式匹配字符串 NSMatchingReportProgress:找到最长的匹配字符串后调用block回调
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|71|(8[12])|91)\\d{4}(((19|20)\\d{2}(0[13-9]|1[012])(0[1-9]|[12]\\d|30))|((19|20)\\d{2}(0[13578]|1[02])31)|((19|20)\\d{2}02(0[1-9]|1\\d|2[0-8]))|((19|20)([13579][26]|[2468][048]|0[048])0229))\\d{3}(\\d|X|x)?$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|71|(8[12])|91)\\d{4}(((19|20)\\d{2}(0[13-9]|1[012])(0[1-9]|[12]\\d|30))|((19|20)\\d{2}(0[13578]|1[02])31)|((19|20)\\d{2}02(0[1-9]|1\\d|2[0-8]))|((19|20)([13579][26]|[2468][048]|0[048])0229))\\d{3}(\\d|X|x)?$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch >0) {
                //1：校验码的计算方法 身份证号码17位数分别乘以不同的系数。从第一位到第十七位的系数分别为：7－9－10－5－8－4－2－1－6－3－7－9－10－5－8－4－2。将这17位数字和系数相乘的结果相加。
                
                int S = [value substringWithRange:NSMakeRange(0,1)].intValue*7 + [value substringWithRange:NSMakeRange(10,1)].intValue *7 + [value substringWithRange:NSMakeRange(1,1)].intValue*9 + [value substringWithRange:NSMakeRange(11,1)].intValue *9 + [value substringWithRange:NSMakeRange(2,1)].intValue*10 + [value substringWithRange:NSMakeRange(12,1)].intValue *10 + [value substringWithRange:NSMakeRange(3,1)].intValue*5 + [value substringWithRange:NSMakeRange(13,1)].intValue *5 + [value substringWithRange:NSMakeRange(4,1)].intValue*8 + [value substringWithRange:NSMakeRange(14,1)].intValue *8 + [value substringWithRange:NSMakeRange(5,1)].intValue*4 + [value substringWithRange:NSMakeRange(15,1)].intValue *4 + [value substringWithRange:NSMakeRange(6,1)].intValue*2 + [value substringWithRange:NSMakeRange(16,1)].intValue *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                
                //2：用加出来和除以11，看余数是多少？余数只可能有0－1－2－3－4－5－6－7－8－9－10这11个数字
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 3：获取校验位
                
                NSString *lastStr = [value substringWithRange:NSMakeRange(17,1)];
                
                //4：检测ID的校验位
                if ([lastStr isEqualToString:@"x"]) {
                    if ([M isEqualToString:@"X"]) {
                        return YES;
                    }else{
                        return NO;
                    }
                }else{
                    
                    if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                        return YES;
                    }else {
                        return NO;
                    }
                    
                }
            }else {
                return NO;
            }
        default:
            return NO;
    }
}

@end

@implementation NSString (Emoji)

- (BOOL)isEmoji{
    const unichar high = [self characterAtIndex:0];
    
    // Surrogate pair (U+1D000-1F77F)
    if (0xd800 <= high && high <= 0xdbff && self.length >= 2) {
        const unichar low = [self characterAtIndex:1];
        const int codepoint = ((high - 0xd800) * 0x400) + (low - 0xdc00) + 0x10000;
        
        return (0x1d000 <= codepoint && codepoint <= 0x1f77f);
        
        // Not surrogate pair (U+2100-27BF)
    } else {
        return (0x2100 <= high && high <= 0x27bf);
    }
}

@end

@implementation NSString (Time)

+ (NSString *)minuteStringWithTimeInterval:(NSTimeInterval)timeInterval {
    
    long min = (long)timeInterval /60;
    long sec = (long)timeInterval % 60;
    return [NSString stringWithFormat:@"%02ld:%02ld",min,sec];
    
}

+ (NSString *)stringWithTimeInterval:(NSTimeInterval)timeInterval {
    long hour = timeInterval/3600;
    long min = ((long)timeInterval % 3600)/60;
    long sec = (long)timeInterval % 60;
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",hour,min,sec];
}

+ (NSString *)monthlyStringWithTimeInterval:(NSTimeInterval)timeInterval {
    long month = timeInterval/(3600 *24*30);
    long day = ((long)timeInterval%(3600*24*30))/(3600*24);
    if (month > 0) {
        return [NSString stringWithFormat:@"%ld月%ld天",month,day];
    } else {
        if (day > 0) {
            return [NSString stringWithFormat:@"%ld天",day];
        } else {
            return [NSString stringWithTimeInterval:timeInterval];
        }
    }
}

@end

@implementation NSString (Number)

+ (NSString *)convertToDecimalStyleWithTwoDigitsFromString:(NSString *)str{
    if (str==nil||[str isEqualToString:@""]) {
        return @"";
    }else{
        double amount = [str doubleValue];
        NSNumber *f2 = [NSNumber numberWithDouble:amount];
        NSNumberFormatter *numf = [[NSNumberFormatter alloc] init];
        numf.numberStyle = NSNumberFormatterDecimalStyle;
        numf.roundingMode = NSNumberFormatterRoundHalfEven;
        [numf setMinimumFractionDigits:2];
        [numf setMaximumFractionDigits:2];
        NSString *result = [numf stringFromNumber:f2];
        return result;
    }
}

@end

static const NSInteger defaultNumberStrLength = 20;//默认数字字符串最大长度
static const NSInteger defaultAfterDecimalPointStrLength = 2;//默认小数点后两位字符串

@implementation NSString (Money)

//判断输入后是否是合法输入单个数字
+ (BOOL)illegalSingleNumber:(NSString *)originSingleNumberText withInput:(NSString *)input {
    //当前数量框中字符串
    if (input == nil || [input isEqualToString:@""]) {
        //删除按钮
        if (originSingleNumberText.length == 0 || originSingleNumberText == nil) {
            //空字符串不支持删除
            return YES;
        }
    } else if ([input isEqualToString:@"."]) {
        //非法输入判断
        if ([originSingleNumberText containsString:@"."]) {
            //".."
            return YES;
        }else{
            return [[self class] illegalSingleNumberLength:originSingleNumberText withInput:input];
        }
    } else if ([input isEqualToString:@"0"]) {
        if ([originSingleNumberText isEqualToString:@"0"]) {
            //"00"
            return YES;
        } else {
            return [[self class] illegalSingleNumberLength:originSingleNumberText withInput:input];
        }
    } else {
        return [[self class] illegalSingleNumberLength:originSingleNumberText withInput:input];
    }
    return NO;
}

+ (BOOL)illegalSingleNumberLength:(NSString *)originSingleNumberText withInput:(NSString *)input {
    //增加字符
    //先进行输入上限判断，最长输入20个字符。小数点后最多保留defaultAfterDecimalPointStrLength位
    if (originSingleNumberText.length >= defaultNumberStrLength) {
        //最长输入20个字符
        return YES;
    } else if ([originSingleNumberText containsString:@"."]) {
        //小数点后最多输入defaultAfterDecimalPointStrLength位
        if (originSingleNumberText.length >= defaultAfterDecimalPointStrLength) {
            NSString *str2 = [originSingleNumberText mutableCopy];
            NSString * judgeStr = [str2 substringToIndex:str2.length - defaultAfterDecimalPointStrLength];
            if ([judgeStr containsString:@"."]) {
                return YES;
            }
        }
    }
    return NO;
}


+ (NSString *)changeSingleNumber:(NSString *)originSingleNumberText withInput:(NSString *)input {
    if (originSingleNumberText == nil) {
        originSingleNumberText = @"";
    }
    NSString *result = [[NSString alloc] init];
    
    if (input == nil || [input isEqualToString:@""]) {
        //删除字符
        if (originSingleNumberText.length == 1){
            result = @"";
        } else if (originSingleNumberText.length > 1) {
            result = [originSingleNumberText substringToIndex:originSingleNumberText.length - 1];
        }
    } else {
        //增加字符
        if (originSingleNumberText.length == 0) {
            if ([input isEqualToString:@"."]) {
                //"."->"0."
                result = @"0.";
            } else {
                //"1"->"1"
                result = input;
            }
        }else if ([originSingleNumberText isEqualToString:@"0"] && ![input isEqualToString:@"."]) {
            //"01"->"1"
            result = input;
        } else {
            //"12"->"12"
            result = [originSingleNumberText stringByAppendingString:input];
        }
    }
    if ([result isEqualToString:@""]) {
        return nil;
    } else {
        return result;
    }
}

@end

@implementation NSString (System)

//获取 bundle version版本号
+ (NSString*)getLocalAppVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

//获取BundleID
+ (NSString*)getBundleID {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

//获取app的名字
+ (NSString*)getAppName {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

@end

@implementation NSString (IsChinese)

- (BOOL)isChinese{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)checkContainsChinese{
    for (int i=0; i<self.length; i++) {
        unichar ch = [self characterAtIndex:i];
        if (0x4E00 <= ch  && ch <= 0x9FA5) {
            return YES;
        }
    }
    return NO;
}

@end
