//
//  NSDictionary+YY.m
//  YiYunSTP
//
//  Created by apple on 2019/3/21.
//  Copyright © 2019年 yiyuniot. All rights reserved.
//

#import "NSDictionary+YY.h"

@implementation NSDictionary (YY)

@end

#pragma mark - Parsing
@implementation NSDictionary (Parsing)

-(instancetype)yy_vaildateNull{
    NSMutableDictionary *data = [self mutableCopy];
    [data.allKeys enumerateObjectsUsingBlock:^(NSString  *key, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *value = [NSString stringWithFormat:@"%@",self[key]];
        if ([value.class isKindOfClass:[NSNull class]]||[value isEqualToString:@""]||value==nil||[value isEqualToString:@"<null>"]) {
            [data setObject:@"" forKey:key];
        }
    }];
    return data;
}

-(NSString *)yy_objectForKey:(id)key{
    id code = [self objectForKey:key];
    if ([code isKindOfClass:[NSNull class]]||code==nil) {
        return @"";
    } else if ([code isKindOfClass:[NSNumber class]]) {
        NSNumber *tmp = (NSNumber *)code;
        return tmp.stringValue;
    } else if ([code isKindOfClass:[NSString class]]) {
        return code;
    } else {
        return [NSString stringWithFormat:@"%@", code];
    }
}


- (NSString *)parseStringForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]]) {
        return object;
    } else if ([object isKindOfClass:[NSNumber class]]) {
        NSNumber *tmp = (NSNumber *)object;
        return tmp.stringValue;
    }
    return nil;
}

- (NSInteger)parseIntegerForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]]) {
        NSString *tmp = (NSString *)object;
        return tmp.integerValue;
    } else if ([object isKindOfClass:[NSNumber class]]) {
        NSNumber *tmp = (NSNumber *)object;
        return tmp.integerValue;
        
    }
    return -999999;
}

- (long long)parseLongLongForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]]) {
        NSString *tmp = (NSString *)object;
        return tmp.longLongValue;
    } else if ([object isKindOfClass:[NSNumber class]]) {
        NSNumber *tmp = (NSNumber *)object;
        return tmp.longLongValue;
    }
    return 0.f;
}

- (float)parseFloatForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]]) {
        NSString *tmp = (NSString *)object;
        return tmp.doubleValue;
    } else if ([object isKindOfClass:[NSNumber class]]) {
        NSNumber *tmp = (NSNumber *)object;
        return tmp.doubleValue;
    }
    return 0.0000000000000000000000000000000000000000000014f;
}

- (BOOL)parseBooleanForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)object boolValue];
    }
    if ([object isKindOfClass:[NSString class]]) {
        return [(NSString *)object boolValue];
    }
    return NO;
}

- (NSNumber *)parseNumberForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSNumber class]]) {
        return object;
    }
    return nil;
}

- (NSArray *)parseArrayForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSArray class]]) {
        return object;
    }
    return nil;
}

- (NSDictionary *)parseDictionaryForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSDictionary class]]) {
        return object;
    }
    return nil;
}

@end

#pragma mark - JSON
@implementation NSDictionary (JSON)

+ (NSDictionary *)dictionaryWithJSONData:(NSData *)data
{
    NSError *error;
    if (data == nil) return [[NSDictionary alloc] init];
    if ([data length] <= 0) return [[NSDictionary alloc] init];
    
    return [NSJSONSerialization JSONObjectWithData:data
                                           options:NSJSONReadingMutableContainers
                                             error:&error];
}


+ (NSDictionary *)dictionaryWithJSONString:(NSString *)str
{
    if (str) {
        NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
        return [NSDictionary dictionaryWithJSONData:jsonData];
    }
    return nil;
}

- (NSString *)toJSONString
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
        return @"";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
}

@end


@implementation NSMutableDictionary (SETVALUE)

- (BOOL)setYYObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (anObject != nil) {
        [self setObject:anObject forKey:aKey];
        return YES;
    } 
    return NO;
}

- (BOOL)setIntObject:(NSInteger)integerValue forKey:(id<NSCopying>)aKey
{
    [self setObject:[NSNumber numberWithInteger:integerValue] forKey:aKey];
    return YES;
}

@end


#pragma mark - URL
@implementation NSDictionary (URL)

- (NSString *)toURLString
{
    NSMutableString *str = [NSMutableString stringWithString:@""];
    
    for (NSString *key in [self allKeys]) {
        if (key) {
            NSString *value = [self objectForKey:key];
            if (value) {
                [str appendFormat:@"%@=%@&", key, value];
            }
        }
    }
    
    if (str.length > 0) {
        [str deleteCharactersInRange:NSMakeRange(str.length - 1, 1)];
    }
    
    return str;
}

@end

#pragma mark - FileName
@implementation NSDictionary(FileName)
+(NSDictionary *)jsonFileToDictWithFileName:(NSString *)fileName
{
    NSString *filePath=[[NSBundle mainBundle]pathForResource:fileName ofType:@"json"];
    return  [self jsonFileToDictWithFilePath:filePath];
}
+(NSDictionary *)jsonFileToDictWithFilePath:(NSString *)filePath
{
    NSData *fileData=[NSData dataWithContentsOfFile:filePath];
    if (fileData == nil) return [[NSDictionary alloc] init];
    if ([fileData length] <= 0) return [[NSDictionary alloc] init];
    NSError *error=nil;
    NSDictionary *contentDict=[NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        NSLog(@"Got an error: %@", error);
        return [[NSDictionary alloc] init];
    }else{
        return contentDict;
    }
}
@end
