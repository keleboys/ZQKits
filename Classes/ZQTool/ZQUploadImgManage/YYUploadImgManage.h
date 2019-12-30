//
//  YYUploadImgManage.h
//  YiYunSTP
//
//  Created by 易云物联 on 2019/5/10.
//  Copyright © 2019 yiyuniot. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYUploadImgManage : NSObject
/** 单张上传图片
 * image 需要上传的图片
 * success 图片上传h成功
 * fail 上传图片失败的原因
 */
+(void)upLoadImageWithImgData:(NSDictionary <NSString * ,  UIImage *>*)imgData success:(void(^)(NSString *imgUrl))success fail:(void(^)(NSError *error))fail;
/** 单张上传图片
 * image 需要上传的图片
 * success 图片上传h成功
 * fail 上传图片失败的原因
 */
+(void)upLoadFaceImageWithImgData:(NSDictionary <NSString * ,  UIImage *>*)imgData success:(void(^)(NSString *imgUrl))success fail:(void(^)(NSError *error))fail;
/** 批量上传图片
 * imgs 需要上传图片的array
 * allSuccess 上传图片的结果，true所有图片都上传成功，false最少有一张图片上传失败
 * callBcaks 返上传图片的结果回，字典类型。key值为图片的名称，value为上传图片的结果
 */
+(void)upLoadImageWithImgData:(NSDictionary <NSString * ,  UIImage *>*)imgData callBcaks:(void(^)(BOOL allSuccess, NSDictionary <NSString * ,  NSString *>*successData, NSDictionary <NSString * ,  NSError *>*faileData))callBcaks;
@end

NS_ASSUME_NONNULL_END
