//
//  YYUploadImgManage.m
//  YiYunSTP
//
//  Created by 易云物联 on 2019/5/10.
//  Copyright © 2019 yiyuniot. All rights reserved.
//

#import "YYUploadImgManage.h"
#import <AFNetworking.h>

@implementation YYUploadImgManage

+(void)upLoadImageWithImgData:(NSDictionary <NSString * ,  UIImage *>*)imgData success:(void(^)(NSString *imgUrl))success fail:(void(^)(NSError *error))fail{
    NSString *url = [ENDPOINT stringByAppendingString:@"/Pedestrian/SmallFileUpload/PicUpload"];
    [self privateUpLoadImageWithImgData:imgData url:url callBcaks:^(BOOL allSuccess, NSDictionary<NSString *,NSString *> *successData, NSDictionary<NSString *,NSError *> *faileData) {
        if (allSuccess) {
            !success ?: success(successData.allValues.lastObject);
        }else{
            !fail ?: fail(faileData.allValues.lastObject);
        }
    }];
}

+(void)upLoadFaceImageWithImgData:(NSDictionary <NSString * ,  UIImage *>*)imgData success:(void(^)(NSString *imgUrl))success fail:(void(^)(NSError *error))fail{
    NSString *url = [ENDPOINT stringByAppendingString:@"/User/UserManage/AddFaceAsync"];
    [self privateUpLoadImageWithImgData:imgData url:url callBcaks:^(BOOL allSuccess, NSDictionary<NSString *,NSString *> *successData, NSDictionary<NSString *,NSError *> *faileData) {
        if (allSuccess) {
            !success ?: success(successData.allValues.lastObject);
        }else{
            !fail ?: fail(faileData.allValues.lastObject);
        }
    }];
}

+(void)upLoadImageWithImgData:(NSDictionary <NSString * ,  UIImage *>*)imgData callBcaks:(void(^)(BOOL allSuccess, NSDictionary <NSString * ,  NSString *>*successData, NSDictionary <NSString * ,  NSError *>*faileData))callBcaks{
    NSString *url = [ENDPOINT stringByAppendingString:@"/Pedestrian/SmallFileUpload/PicUpload"];
    [self privateUpLoadImageWithImgData:imgData url:url callBcaks:callBcaks];
}

+(void)privateUpLoadImageWithImgData:(NSDictionary <NSString * ,  UIImage *>*)imgData url:(NSString *)url callBcaks:(void(^)(BOOL allSuccess, NSDictionary <NSString * ,  NSString *>*successData, NSDictionary <NSString * ,  NSError *>*faileData))callBcaks{
    NSMutableDictionary *success = [NSMutableDictionary dictionary];
    NSMutableDictionary *faile = [NSMutableDictionary dictionary];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    [imgData enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, UIImage * image, BOOL * _Nonnull stop) {
        dispatch_group_enter(group);
        if (!image) {
            dispatch_group_leave(group);
            NSError *error = [NSError errorWithDomain:@"upload" code:0 userInfo:@{@"errorKey":@"image is null"}];
            [faile setValue:error forKey:key];
        }else{
            dispatch_async(queue, ^{
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                [manager.requestSerializer setValue:ReadUserToken() forHTTPHeaderField:@"TwiAuth"];
                manager.requestSerializer.timeoutInterval = 20;
                [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    NSData *imageData = [UIImage compressImageData:image];
                    
                    if (imageData.length < ReadMaxImgSize()*1024) {
                        ZQLog(@"upload image size: %ld k", (long)(imageData.length / 1024));
                        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                        formatter.dateFormat = @"yyyyMMddHHmmssSSS";
                        NSString *str = [formatter stringFromDate:[NSDate date]];
                        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
                        //上传的参数(上传图片，以文件流的格式)
                        [formData appendPartWithFileData:imageData
                                                    name:key
                                                fileName:fileName
                                                mimeType:@"image/jpeg"];
                    } else {
                        NSError *error = [NSError errorWithDomain:@"upload" code:1 userInfo:@{@"errorKey":@"image oversize"}];
                        [faile setValue:error forKey:key];
                    }
                } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    ZQLog(@"responseObject:%@",responseObject);
                    if ([responseObject[@"state"]boolValue]) {
                        NSArray *imgUrls = responseObject[@"result"];
                        [success setValue:[imgUrls firstObject] forKey:key];
                    }else{
                        NSError *error = [NSError errorWithDomain:@"upload" code:1 userInfo:@{@"errorKey":@"image upload faile"}];
                        [faile setValue:error forKey:key];
                    }
                    dispatch_group_leave(group);
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    ZQLog(@"error:%@",error);
                    dispatch_group_leave(group);
                    [faile setValue:error forKey:key];
                }];
            });
        }
    }];
    dispatch_group_notify(group, queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            !callBcaks ?: callBcaks(faile.count>0 ? NO:YES, success, faile);
        });
    });
}


@end
