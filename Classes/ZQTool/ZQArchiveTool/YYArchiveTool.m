//
//  YYArchiveTool.m
//  YiYunSTP
//
//  Created by 易云物联 on 2019/6/11.
//  Copyright © 2019 yiyunios. All rights reserved.
//

#import "YYArchiveTool.h"
@interface YYArchiveTool ()
/**  */
@property (nonatomic, strong) id object;
@end
@implementation YYArchiveTool

+(YYArchiveTool *)manage{
    static dispatch_once_t onceToken;
    static YYArchiveTool *tool = nil;
    dispatch_once(&onceToken, ^{
        tool = [[YYArchiveTool alloc]init];
    });
    return tool;
}

+(void)archiveRootObject:(id)object path:(NSString *)path{
    NSAssert(object, @"object must not be nil.");
    NSAssert(path, @"path must not be nil.");
    [self manage].object = object;
    BOOL flag = [NSKeyedArchiver archiveRootObject:object toFile:[self getArchiveDataPath:path]];
    if (flag) {
        ZQLog(@"归档成功");
    }else ZQLog(@"归档失败");
}
+(id)unarchiveRootObjectWithPath:(NSString *)path{
    NSAssert(path, @"path must not be nil.");
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self getArchiveDataPath:path]];
}

+(void)clearArchiveDataWithPath:(NSString *)path{
    NSError *error = nil;
    [[NSFileManager defaultManager]removeItemAtPath:[self getArchiveDataPath:path] error:&error];
    if (error) {
        ZQLog(@"清除本地序列化账户信息的文件失败....:%@",error);
    }else ZQLog(@"清除本地序列化账户信息的文件成功");
}

+(NSString *)getArchiveDataPath:(NSString *)path{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.archive",path]];
}
/** 归档 */
-(void)encodeWithCoder:(NSCoder *)aCoder{
    if (![[self.object class] isKindOfClass:[NSDictionary class]]&&![[self.object class] isKindOfClass:[NSArray class]]&&![[self.object class] isKindOfClass:[NSString class]]&&![[self.object class] isKindOfClass:[NSData class]]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self.object class], &count);
        for (int i = 0; i<count; i++) {
            // 取出i位置对应的成员变量
            Ivar ivar = ivars[i];
            // 查看成员变量
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [self valueForKey:key];
            [aCoder encodeObject:value forKey:key];
        }
        free(ivars);
    }else{
        [aCoder encodeObject:self.data forKey:@"data"];
    }
    
}
/** 解档 */
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        if (![[self.object class] isKindOfClass:[NSDictionary class]]&&![[self.object class] isKindOfClass:[NSArray class]]&&![[self.object class] isKindOfClass:[NSString class]]&&![[self.object class] isKindOfClass:[NSData class]]) {
            unsigned int count = 0;
            Ivar *ivars = class_copyIvarList([self.object class], &count);
            for (int i = 0; i<count; i++) {
                // 取出i位置对应的成员变量
                Ivar ivar = ivars[i];
                // 查看成员变量
                const char *name = ivar_getName(ivar);
                // 解档
                NSString *key = [NSString stringWithUTF8String:name];
                id value = [aDecoder decodeObjectForKey:key];
                if ([value isEqualToString:@"null"]) {
                    value = @"";
                }
                // 设置到成员变量身上
                [self setValue:value forKey:key];
            }
            free(ivars);
        }else{
            id value = [aDecoder decodeObjectForKey:@"data"];
            if ([value isEqualToString:@"null"]) {
                value = @"";
            }
            [self setValue:value forKey:@"data"];
        }
    }
    return self;
}
@end
