//
//  NSArray+YY.m
//  YiYunSTP
//
//  Created by apple on 2019/3/21.
//  Copyright © 2019年 yiyuniot. All rights reserved.
//

#import "NSArray+YY.h"

@implementation NSArray (YY)

- (NSString *)toJSONString {
    
    NSError * error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if ([jsonData length] > 0  && error == nil) {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    } else {
        NSLog(@"toJSONString - error: %@", error );
        return @"";
    }
}

@end
