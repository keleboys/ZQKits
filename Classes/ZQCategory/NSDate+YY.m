//
//  NSDate+YY.m
//  YiYunSTP
//
//  Created by apple on 2019/3/21.
//  Copyright © 2019年 yiyuniot. All rights reserved.
//

#import "NSDate+YY.h"
#define KOneYearM  (60*60*24*365*1000.f)

@implementation NSDate (YY)
/**
 *  是否为今天
 */
- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return
    (selfCmps.year == nowCmps.year) &&
    (selfCmps.month == nowCmps.month) &&
    (selfCmps.day == nowCmps.day);
}

- (NSDateComponents *)deltaWithNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
    calendar.locale=locale;
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}


/**
 *  是否为昨天
 */
- (BOOL)isYesterday
{
    // 2014-05-01
    NSDate *nowDate = [[NSDate date] dateWithYMD];
    
    // 2014-04-30
    NSDate *selfDate = [self dateWithYMD];
    
    // 获得nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 1;
}

+ (NSString *) compareDate:(NSDate *)date {
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *tomorrow, *yesterday;
    
    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today stringDateWithYMD] substringToIndex:10];
    NSString * yesterdayString = [[yesterday stringDateWithYMD] substringToIndex:10];
    NSString * tomorrowString = [[tomorrow stringDateWithYMD] substringToIndex:10];
    
    NSString * dateString = [[date stringDateWithYMD] substringToIndex:10];
    if ([dateString isEqualToString:todayString])
    {
        return @"今天";
    } else if ([dateString isEqualToString:yesterdayString])
    {
        return @"昨天";
    }else if ([dateString isEqualToString:tomorrowString])
    {
        return @"明天";
    }
    else {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *destDateString = [dateFormatter stringFromDate:date];
        return destDateString;
    }
}

/**
 * 计算指定时间与当前的时间差
 * @param compareDate   某一指定时间
 * @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
 */
+ (NSString *) compareCurrentTime:(NSDate*) compareDate {
    
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}


- (NSDate *)dateWithYMD
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}
- (NSDate *)dateWithMD
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy年MM月dd日";
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}
- (NSString *)stringDateWithYMD
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy年MM月dd日";
    NSString *selfStr = [fmt stringFromDate:self];
    return selfStr;
}
- (NSString *)stringDateWithMD
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
    fmt.locale=locale;
    fmt.dateFormat = @"MM月dd日";
    NSString *selfStr = [fmt stringFromDate:self];
    return selfStr;
}

/**
 *  是否为今年
 */
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year;
}


-(int)getDaysInMonth:(NSInteger)month
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps =[calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitWeekday | NSCalendarUnitDay) fromDate:self];
    [comps setMonth:month];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit: NSCalendarUnitMonth
                                  forDate: [calendar dateFromComponents:comps]];
    return (int)range.length;
}
-(NSString *)getWeekDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale=[NSLocale localeWithLocaleIdentifier:@"zh"];
    //設定日期格式
    //    [dateFormatter setDateFormat:@"yy/MM/dd"];
    //取得weekday symbol
    NSArray *weekdayArray = [dateFormatter weekdaySymbols];
    //取得月曆
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    gregorian.locale=[NSLocale localeWithLocaleIdentifier:@"zh"];
    NSDateComponents *dateComps = [gregorian components:NSCalendarUnitWeekday fromDate:self];
    long day = [dateComps weekday] - 1;
    return [weekdayArray objectAtIndex:day];
}
+(instancetype)getDateWithString:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date=[dateFormatter dateFromString:dateStr];
    return date;
}
-(NSInteger)yearWithDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay ) fromDate:self];
    return cmps.year;
}
-(NSInteger)monthWithDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay ) fromDate:self];
    return cmps.month;
    
}
-(NSInteger)dayWithDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay ) fromDate:self];
    return cmps.day;
}
+(NSString *)getDateStringWithString:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSInteger year = [[NSDate date]yearWithDate];
    NSString *finalStr = [NSString stringWithFormat:@"%ld年%@",(long)year,dateStr];
    NSDate *date=[dateFormatter dateFromString:finalStr];
    NSTimeInterval timeInterval=[date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%f",timeInterval];
}
+(NSString *)getBigDateStringWithString:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSInteger year=[[NSDate date]yearWithDate];
    NSString *finalStr=[NSString stringWithFormat:@"%ld年%@",(long)year,dateStr];
    NSDate *date=[dateFormatter dateFromString:finalStr];
    NSTimeInterval timeInterval=[date timeIntervalSince1970]*1000.f;
    //now
    NSTimeInterval nowTimeInteval=[[[NSDate date] dateWithMD]timeIntervalSince1970]*1000.f;
    if (timeInterval<nowTimeInteval) {
        //说明日期得加上一年
        timeInterval+=KOneYearM;
    }
    //筛选
    return [NSString stringWithFormat:@"%0.f",timeInterval];
}
+(NSString *)getBigDateStringWithYearMonthDayString:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSDate *date=[dateFormatter dateFromString:dateStr];
    //    NSTimeInterval timeInterval=[date timeIntervalSince1970]*1000;
    NSString * t = [NSString stringWithFormat:@"%lld",(long long)[date timeIntervalSince1970]*1000];
    return t;
}

+(NSString *)getBigDateStringWithYearMonthDayTimeString:(NSString *)dateStr {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate* myDate = [formatter dateFromString:dateStr];
    NSString * timeSp = [NSString stringWithFormat:@"%lld",(long long)[myDate timeIntervalSince1970]*1000];
    
    NSLog(@"%@ <--> %@",dateStr,timeSp); //时间戳的值
    return timeSp;
}

+(NSString *)getDateStringWithNumber:(NSNumber *)number
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:number.doubleValue];
    //    NSString * t = [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]*1000];
    return [dateFormatter stringFromDate:date];
}
+(NSString *)getDateStringExceptYearWithBigNumber:(NSNumber *)number
{
    NSNumber *smallNumber=[NSNumber numberWithLongLong:number.longLongValue/1000.f];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM/dd"];
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:smallNumber.doubleValue];
    NSString *dateStr=[dateFormatter stringFromDate:date];
    return dateStr;
}
+(NSString *)getDateStringWithBigNumber:(NSNumber *)number
{
    NSNumber *smallNumber=[NSNumber numberWithLongLong:number.doubleValue/1000.f];
    return [self getDateStringWithNumber:smallNumber];
}

+ (NSString *)getDetailDateStringWithBigNumber:(NSNumber *)number
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:number.longLongValue/1000];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)getDetailDateStringWithBigString:(NSString *)string
{
    if (string == nil) {
        return @"";
    }
    NSNumber *number = [NSNumber numberWithLongLong:string.longLongValue];
    return [self getDetailDateStringWithBigNumber:number];
}

+ (NSString *)getBigDateStringTillMonthWithString:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"yyyy年MM月"];
    
    NSInteger year=[[NSDate date]yearWithDate];
    
    NSString *finalStr=[NSString stringWithFormat:@"%ld年%@",(long)year,dateStr];
    
    NSDate *date=[dateFormatter dateFromString:finalStr];
    
    NSTimeInterval timeInterval=[date timeIntervalSince1970]*1000.f;
    
    return [NSString stringWithFormat:@"%f",timeInterval];
    
    
    
}

+ (NSString *)getDateStringTillMonthWithNumber:(NSNumber *)number
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"yyyy-MM"];
    
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:number.floatValue];
    
    NSString *dateStr=[dateFormatter stringFromDate:date];
    
    return dateStr;
}

+ (NSString *)getDateStringTillMonthWithBigNumber:(NSNumber *)number

{
    NSNumber *smallNumber=[NSNumber numberWithLongLong:number.doubleValue/1000.f];
    return [self getDateStringTillMonthWithNumber:smallNumber];
}

+ (NSString *)getDateStringTillMonthWithBigString:(NSString *)string
{
    if (string == nil) {
        return @"";
    }
    NSNumber *number = [NSNumber numberWithLongLong:string.longLongValue];
    return [NSDate getDateStringTillMonthWithBigNumber:number];
}


+ (NSString *)getDateStringWithBigNumberStyle:(NSNumber *)number
{
    NSNumber *smallNumber = [NSNumber numberWithDouble:number.doubleValue /1000.f];
    return [self getDateStringWithNumberStyle:smallNumber];
}

+ (NSString *)getDateStringWithBigStringStyle:(NSString *)string
{
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    NSNumber *number =  [fmt numberFromString:string];
    return [self getDateStringWithBigNumberStyle:number];
}


+ (NSString *)getDateStringWithNumberStyle:(NSNumber *)number
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:number.doubleValue];
    NSString *dateStr=[dateFormatter stringFromDate:date];
    return dateStr;
}



+ (NSString *)getDateStringWithDouble:(double)value
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:value];
    NSString *dateStr=[dateFormatter stringFromDate:date];
    return dateStr;
}

/*************************************************/
+ (NSString *)getDateStringWithNumberStyleHan:(NSNumber *)number
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:number.doubleValue];
    NSString *dateStr=[dateFormatter stringFromDate:date];
    return dateStr;
}

+ (NSString *)getDateStringWithBigNumberStyleHan:(NSNumber *)number
{
    NSNumber *smallNumber=[NSNumber numberWithDouble:number.doubleValue/1000.f];
    return [self getDateStringWithNumberStyleHan:smallNumber];
}

+ (NSString *)getDateStringWithBigStringStyleHan:(NSString *)string
{
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    NSNumber *destinationNum = [fmt numberFromString:string];
    return  [self getDateStringWithBigNumberStyleHan:destinationNum];
    
}

+(NSDate *)managerGetDateStringWithBigNumber:(NSNumber *)number
{
    NSNumber *smallNumber=[NSNumber numberWithLongLong:number.doubleValue/1000.f];
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:smallNumber.doubleValue];
    return date;
}

+(NSString *)getStandardTime:(NSString *)time formatter:(NSString *)formatter{
    if ([time isKindOfClass:[NSNull class]]) {
        return @"";
    }
    if (!time.length) {
        return @"";
    }
    NSDateFormatter  *dateformatter =[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date = [dateformatter dateFromString:time];
    if (![date isThisYear]&&![formatter hasPrefix:@"YYYY"]) {
        formatter = [NSString stringWithFormat:@"YYYY-%@",formatter];
    }
    ZQLog(@"date:%@",date);
    NSDateFormatter  *dateformatter1=[[NSDateFormatter alloc] init];
    [dateformatter1 setDateFormat:formatter];
    NSString * locationString=[dateformatter1 stringFromDate:date];
    return locationString;
}
@end
