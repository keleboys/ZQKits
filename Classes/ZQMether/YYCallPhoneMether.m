//
//  YYCallPhoneMether.m
//  YiYunSTP
//
//  Created by 易云物联 on 2019/4/10.
//  Copyright © 2019 yiyuniot. All rights reserved.
//

#import "YYCallPhoneMether.h"

@implementation YYCallPhoneMether

+ (void)callPhoneNumber:(NSString*)number yy_self:(UIViewController *)yy_self;{
    if (number.length >= 10) {
        NSString *str2 = [[UIDevice currentDevice] systemVersion];
        if ([str2 compare:@"10.2" options:NSNumericSearch] == NSOrderedDescending || [str2 compare:@"10.2" options:NSNumericSearch] == NSOrderedSame)
        {
            NSString* PhoneStr = [NSString stringWithFormat:@"telprompt://%@",number];
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:PhoneStr] options:@{} completionHandler:^(BOOL success) {
                    ZQLog(@"phone success");
                }];
            } else {
                // Fallback on earlier versions
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:PhoneStr]];
            }
            
        }else {
            NSMutableString* str1 = [[NSMutableString alloc]initWithString:number];// 存在堆区，可变字符串
            if (number.length == 10) {
                [str1 insertString:@"-"atIndex:3];// 把一个字符串插入另一个字符串中的某一个位置
                [str1 insertString:@"-"atIndex:7];// 把一个字符串插入另一个字符串中的某一个位置
            }else {
                [str1 insertString:@"-"atIndex:3];// 把一个字符串插入另一个字符串中的某一个位置
                [str1 insertString:@"-"atIndex:8];// 把一个字符串插入另一个字符串中的某一个位置
            }
            NSString * message = [NSString stringWithFormat:@"是否拨打电话:\n%@",str1];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:message];
            [attributedText addAttribute:NSForegroundColorAttributeName value:ColorWithHex(@"#373737") range:NSMakeRange(0, message.length)];
            [attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, message.length)];
            // 添加按钮
            UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                ZQLog(@"点击了呼叫按钮10.2下");
                NSString* PhoneStr = [NSString stringWithFormat:@"tel://%@",number];
                if ([PhoneStr hasPrefix:@"sms:"] || [PhoneStr hasPrefix:@"tel:"]) {
                    UIApplication * app = [UIApplication sharedApplication];
                    if ([app canOpenURL:[NSURL URLWithString:number]]) {
                        [app openURL:[NSURL URLWithString:PhoneStr]];
                    }
                }
            }];
            UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                ZQLog(@"点击了取消按钮");
            }];
            if (YYSystemVersion().doubleValue>9.1) {
                [noAction setValue:ColorWithHex(@"#8E8E93") forKey:@"_titleTextColor"];
                [yesAction setValue:ColorWithHex(@"#78C1EF") forKey:@"_titleTextColor"];
            }
            [alertController setValue:attributedText forKey:@"attributedMessage"];
            [alertController addAction:yesAction];
            [alertController addAction:noAction];
            [yy_self presentViewController:alertController animated:YES completion:nil];
        }
    }
}

@end
