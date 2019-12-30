//
//  AvoidCrashConst.h
//  AvoidCrashDemo-19-8-2-0
//
//  Created by 易云物联 on 2019/8/2.
//  Copyright © 2019 易云物联. All rights reserved.
//

#ifndef AvoidCrashConst_h
#define AvoidCrashConst_h

#define AvoidCrashNotification @"AvoidCrashNotification"
#define AvoidCrashIsiOS(version) ([[UIDevice currentDevice].systemVersion floatValue] >= version)


//user can ignore below define
#define AvoidCrashDefaultReturnNil  @"AvoidCrash default is to return nil to avoid crash."
#define AvoidCrashDefaultIgnore     @"AvoidCrash default is to ignore this operation to avoid crash."

#define AvoidCrashSeparator         @"================================================================"
#define AvoidCrashSeparatorWithFlag @"========================AvoidCrash Log=========================="


#ifdef DEBUG

#define  AvoidCrashLog(...) NSLog(@"%@",[NSString stringWithFormat:__VA_ARGS__])

#else

#define AvoidCrashLog(...)
#endif

#endif /* AvoidCrashConst_h */
