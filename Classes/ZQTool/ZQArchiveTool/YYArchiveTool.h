//
//  YYArchiveTool.h
//  YiYunSTP
//
//  Created by 易云物联 on 2019/6/11.
//  Copyright © 2019 yiyunios. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYArchiveTool : NSObject
/**  */
@property (nonatomic) id data;

+(void)archiveRootObject:(id)object path:(NSString *)path;
+(id)unarchiveRootObjectWithPath:(NSString *)path;

+(void)clearArchiveDataWithPath:(NSString *)path;
@end

NS_ASSUME_NONNULL_END
