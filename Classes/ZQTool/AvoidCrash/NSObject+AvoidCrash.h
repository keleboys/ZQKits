//
//  NSObject+AvoidCrash.h
//  AvoidCrashDemo-19-8-2-0
//
//  Created by 易云物联 on 2019/8/2.
//  Copyright © 2019 易云物联. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AvoidCrash)
/**
 *  ifDealWithNoneSel : 是否开启"unrecognized selector sent to instance"异常的捕获
 */
+ (void)avoidCrashExchangeMethodIfDealWithNoneSel:(BOOL)ifDealWithNoneSel;


+ (void)setupNoneSelClassStringsArr:(NSArray<NSString *> *)classStrings;

+ (void)setupNoneSelClassStringPrefixsArr:(NSArray<NSString *> *)classStringPrefixs;

@end

NS_ASSUME_NONNULL_END
