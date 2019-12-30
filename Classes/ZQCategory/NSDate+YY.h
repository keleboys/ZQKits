//
//  NSDate+YY.h
//  YiYunSTP
//
//  Created by apple on 2019/3/21.
//  Copyright © 2019年 yiyuniot. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (YY)
/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;
/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;
/**
 *  根据NSDate返回昨天还是明天的字符串
 */
+ (NSString *) compareDate:(NSDate *)date;
/**
 *  根据NSDate返回昨天还是明天的字符串
 */
+ (NSString *) compareCurrentTime:(NSDate*) compareDate;
/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;
/**
 *  返回一个只有月日的时间
 */
- (NSDate *)dateWithMD;
/**
 *  返回一个只有年月日的时间字符
 */
- (NSString *)stringDateWithYMD;
/**
 *  返回一个只有月日的时间字符
 */
- (NSString *)stringDateWithMD;
/**
 *  返回一月的天数
 *
 */
- (int)getDaysInMonth:(NSInteger)month;
/**
 *  返回这个日期对应的星期几
 */
- (NSString *)getWeekDay;
/**
 *  返回这个日期的年
 */
- (NSInteger)yearWithDate;
/**
 *  返回这个日期的月
 */
- (NSInteger)monthWithDate;
/**
 *  返回这个日期的日
 */
- (NSInteger)dayWithDate;
/**
 *  根据一个字符窜返回日期
 */
+ (instancetype)getDateWithString:(NSString *)dateStr;
/**
 *  根据一个xx月xx日的日期返回今年这天到1970的秒数字符窜
 *  这个是秒
 */
+ (NSString *)getDateStringWithString:(NSString *)dateStr;
/**
 *  根据一个xx月xx日的日期返回今年这天到1970的秒数字符窜
 *  这个是毫秒
 */
+ (NSString *)getBigDateStringWithString:(NSString *)dateStr;
/**
 *  根据一个xxxx年xx月xx日的日期返回今年这天到1970的秒数字符窜
 *  这个是毫秒
 */
+ (NSString *)getBigDateStringWithYearMonthDayString:(NSString *)dateStr;

/**
 *  根据一个YYYY-MM-DD HH:MM 的日期返回今年这天到1970的秒数字符窜
 *  这个是毫秒
 */
+ (NSString *)getBigDateStringWithYearMonthDayTimeString:(NSString *)dateStr;
/**
 *  根据一个自1970年的秒数返回一个yyyy-MM-dd格式的日期字符
 *  这个是秒
 */
+ (NSString *)getDateStringWithNumber:(NSNumber *)number;
/**
 *  根据一个自1970年的秒数返回一个yyyy/MM/dd格式的日期字符
 *  这个是秒
 */
+ (NSString *)getDateStringWithNumberStyle:(NSNumber *)number;
/**
 *  根据一个自1970年的秒数返回一个yyyy年MM月dd日格式的日期字符
 *  这个是秒
 */
+ (NSString *)getDateStringWithNumberStyleHan:(NSNumber *)number;
/**
 *  根据一个自1970年的秒数返回一个yyyy-MM-dd格式的日期字符
 *  这个是毫秒
 */
+ (NSString *)getDateStringWithBigNumber:(NSNumber *)number;
/**
 *  根据一个自1970年的秒数返回一个yyyy/MM/dd格式的日期字符
 *  这个是毫秒
 */
+ (NSString *)getDateStringWithBigNumberStyle:(NSNumber *)number;
/**
 *  根据一个自1970年的秒数返回一个yyyy/MM/dd格式的日期字符
 *  这个是毫秒
 */
+ (NSString *)getDateStringWithBigStringStyle:(NSString *)string;
/**
 *  根据一个自1970年的秒数返回一个yyyy年MM月dd日格式的日期字符
 *  这个是毫秒
 */
+ (NSString *)getDateStringWithBigNumberStyleHan:(NSNumber *)number;
/**
 *  根据一个自1970年的秒数返回一个yyyy年MM月dd日格式的日期字符
 *  这个是毫秒
 */
+ (NSString *)getDateStringWithBigStringStyleHan:(NSString *)string;
/**
 *  根据一个自1970年的秒数返回一个@"yyyy/MM/dd HH:mm:ss"格式的日期字符
 *  这个是毫秒
 */
+ (NSString *)getDetailDateStringWithBigNumber:(NSNumber *)number;
/**
 *  根据一个自1970年的秒数返回一个@"yyyy/MM/dd HH:mm:ss"格式的日期字符
 *  这个是毫秒
 */
+ (NSString *)getDetailDateStringWithBigString:(NSString *)string;
/**
 *  根据一个自1970年的秒数返回一个@"yyyy-MM"格式的日期字符
 *  这个是秒
 */
+ (NSString *)getDateStringTillMonthWithNumber:(NSNumber *)number;
/**
 *  根据一个自1970年的秒数返回一个@"yyyy-MM"格式的日期字符
 *  这个是毫秒
 */
+ (NSString *)getDateStringTillMonthWithBigNumber:(NSNumber *)number;
/**
 *  根据一个自1970年的秒数返回一个@"yyyy-MM"格式的日期字符
 *  这个是毫秒
 */
+ (NSString *)getDateStringTillMonthWithBigString:(NSString *)string;
/**
 *  根据一个自1970年的秒数返回一个@"MM/dd"格式的日期字符
 *  这个是毫秒
 */
+(NSString *)getDateStringExceptYearWithBigNumber:(NSNumber *)number;
/**
 *  manager计算时间专用
 */
+(NSDate *)managerGetDateStringWithBigNumber:(NSNumber *)number;
/**
 *当前时间YYYY-MM-dd HH:mm:ss转换成当前时间HH:mm
 */
+(NSString *)getStandardTime:(NSString *)time formatter:(NSString *)formatter;
@end

NS_ASSUME_NONNULL_END
