//
//  AvoidCrashProtocol.h
//  AvoidCrashDemo-19-8-2-0
//
//  Created by 易云物联 on 2019/8/2.
//  Copyright © 2019 易云物联. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AvoidCrashProtocol <NSObject>

@required
+ (void)avoidCrashExchangeMethod;

@end

NS_ASSUME_NONNULL_END
