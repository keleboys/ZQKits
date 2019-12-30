//
//  NSDictionary+YY.h
//  YiYunSTP
//
//  Created by apple on 2019/3/21.
//  Copyright © 2019年 yiyuniot. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (YY)

@end

@interface NSDictionary (Parsing)
/** 针对整个字典，判断其中是否包含null */
-(instancetype)yy_vaildateNull;
/** 判断value是否非法，非法的情况下返回空"" */
-(NSString *)yy_objectForKey:(id)key;
- (NSString *)parseStringForKey:(NSString *)key;
- (NSInteger)parseIntegerForKey:(NSString *)key;
- (float)parseFloatForKey:(NSString *)key;
- (NSArray *)parseArrayForKey:(NSString *)key;
- (NSNumber *)parseNumberForKey:(NSString *)key;
- (BOOL)parseBooleanForKey:(NSString *)key;
- (NSDictionary *)parseDictionaryForKey:(NSString *)key;
- (long long )parseLongLongForKey:(NSString *)key;

@end

@interface NSDictionary (JSON)

+ (NSDictionary *)dictionaryWithJSONData:(NSData *)data;
/** json串转字典 */
+ (NSDictionary *)dictionaryWithJSONString:(NSString *)str;
- (NSString *)toJSONString;

@end

@interface NSMutableDictionary (SETVALUE)

- (BOOL)setYYObject:(id)anObject forKey:(id<NSCopying>)aKey;
- (BOOL)setIntObject:(NSInteger)integerValue forKey:(id<NSCopying>)aKey;
@end


@interface NSDictionary (URL)

- (NSString *)toURLString;

@end

@interface NSDictionary (FileName)
+(NSDictionary *)jsonFileToDictWithFileName:(NSString *)fileName;
@end

NS_ASSUME_NONNULL_END
