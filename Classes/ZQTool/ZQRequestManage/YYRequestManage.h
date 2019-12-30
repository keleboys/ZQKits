//
//  YYRequestManage.h
//  YYRequestManage
//
//  Created by 易云物联 on 2019/4/25.
//  Copyright © 2019 易云物联. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


/**
 *  下载进度
 *
 *  @param bytesRead       已下载的大小
 *  @param totalBytesRead  文件总大小
 */
typedef void (^SNDownloadProgress)(int64_t bytesRead,
                                   int64_t totalBytesRead);

typedef SNDownloadProgress SNGetProgress;
typedef SNDownloadProgress SNPostProgress;

/**
 *  上传进度
 *
 *  @param bytesWritten      已上传的大小
 *  @param totalBytesWritten 总上传大小
 */
typedef void (^SNUploadProgress)(int64_t bytesWritten,
                                  int64_t totalBytesWritten);

typedef NS_ENUM(NSUInteger, SNResponseType) {
    kSNResponseTypeJSON = 1, // 默认
    kSNResponseTypeXML  = 2, // XML
    // 特殊情况下，一转换服务器就无法识别的，默认会尝试转换成JSON，若失败则需要自己去转换
    kSNResponseTypeData = 3
};

typedef NS_ENUM(NSUInteger, SNRequestType) {
    kSNRequestTypeJSON = 1, // 默认
    kSNRequestTypePlainText  = 2 // 普通text/html
};

typedef NS_ENUM(NSUInteger, SNHttpMethod) {
    kSNHttpMethodGet   = 1, // 默认
    kSNHttpMethodPost  = 2  // Post
};

@class NSURLSessionTask;
typedef NSURLSessionTask SNURLSessionTask;
/**
 *  响应成功回调
 *
 *  @param response
 */
typedef void(^SNResponseSuccess)(id response);
/**
 *  响应失败回调
 *
 *  @param error
 */
typedef void(^SNResponseFail)(NSError *error);

@interface SNRequestManager : NSObject
/**
 *  更新地址
 *
 *  @param baseUrl url
 */
+ (void)updateBaseUrl:(NSString *)baseUrl;
/**
 *  返回地址
 *
 *  @return url
 */
+ (NSString *)baseUrl;

/*!
 *  @author 黄仪标, 15-11-15 14:11:40
 *
 *  开启或关闭接口打印信息
 *
 *  @param isDebug 开发期，最好打开，默认是NO
 */
+ (void)enableInterfaceDebug:(BOOL)isDebug;

/*!
 *
 *
 *  配置返回格式
 *
 *  @param responseType 响应格式
 */
+ (void)configResponseType:(SNResponseType)responseType;

/*!
 *
 *
 *  配置请求格式，默认为JSON
 *
 *  @param requestType 请求格式
 */
+ (void)configRequestType:(SNRequestType)requestType;

/*!
 *
 *
 *  开启或关闭是否自动将URL使用UTF8编码，用于处理链接中有中文时无法请求的问题
 *
 *  @param shouldAutoEncode YES or NO,默认为NO
 */
+ (void)shouldAutoEncodeUrl:(BOOL)shouldAutoEncode;

/*!
 *
 *  配置公共的请求头，只调用一次即可，通常放在应用启动的时候配置就可以了
 *
 *  @param httpHeaders 只需要将与服务器商定的固定参数设置即可
 */
+ (void)configCommonHttpHeaders:(NSDictionary *)httpHeaders;

/*!
 *
 *
 *  GET请求接口，若不指定baseurl，可传完整的url
 *
 *  @param url     接口路径，如/path/getArticleList?categoryid=1
 *  @param success 接口成功请求到数据的回调
 *  @param fail    接口请求数据失败的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (SNURLSessionTask *)getWithUrl:(NSString *)url
                          success:(SNResponseSuccess)success
                             fail:(SNResponseFail)fail;
/*!
 *
 *
 *  GET请求接口，若不指定baseurl，可传完整的url
 *
 *  @param url     接口路径，如/path/getArticleList
 *  @param params  接口中所需要的拼接参数，如@{"categoryid" : @(12)}
 *  @param success 接口成功请求到数据的回调
 *  @param fail    接口请求数据失败的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (SNURLSessionTask *)getWithUrl:(NSString *)url
                           params:(NSDictionary *)params
                          success:(SNResponseSuccess)success
                             fail:(SNResponseFail)fail;

+ (SNURLSessionTask *)getWithUrl:(NSString *)url
                           params:(NSDictionary *)params
                         progress:(SNGetProgress)progress
                          success:(SNResponseSuccess)success
                             fail:(SNResponseFail)fail;

/*!
 *
 *
 *  POST请求接口，若不指定baseurl，可传完整的url
 *
 *  @param url     接口路径，如/path/getArticleList
 *  @param params  接口中所需的参数，如@{"categoryid" : @(12)}
 *  @param success 接口成功请求到数据的回调
 *  @param fail    接口请求数据失败的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (SNURLSessionTask *)postWithUrl:(NSString *)url
                            params:(NSDictionary *)params
                           success:(SNResponseSuccess)success
                              fail:(SNResponseFail)fail;

+ (SNURLSessionTask *)postWithUrl:(NSString *)url
                            params:(NSDictionary *)params
                          progress:(SNPostProgress)progress
                           success:(SNResponseSuccess)success
                              fail:(SNResponseFail)fail;
/*!
 *
 *
 *  POST请求接口，若不指定baseurl，可传完整的url
 *  form 表单上传方式
 *  @param url     接口路径，如/path/getArticleList
 *  @param params  接口中所需的参数，如@{"categoryid" : @(12)}
 *  @param success 接口成功请求到数据的回调
 *  @param fail    接口请求数据失败的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */

+(SNURLSessionTask *)postWithUrl:(NSString *)url
                          params:(NSDictionary *)params
                          images:(NSArray*)images
                         success:(SNResponseSuccess)success
                            fail:(SNResponseFail)fail;
/**
 *
 *
 *    图片上传接口，若不指定baseurl，可传完整的url
 *
 *    @param image            图片对象
 *    @param url                上传图片的接口路径，如/path/images/
 *    @param filename        给图片起一个名字，默认为当前日期时间,格式为"yyyyMMddHHmmss"，后缀为`jpg`
 *    @param name                与指定的图片相关联的名称，这是由后端写接口的人指定的，如imagefiles
 *    @param mimeType        默认为image/jpeg
 *    @param parameters    参数
 *    @param progress        上传进度
 *    @param success        上传成功回调
 *    @param fail                上传失败回调
 *
 *    @return
 */
+ (SNURLSessionTask *)uploadWithImage:(UIImage *)image
                                   url:(NSString *)url
                              filename:(NSString *)filename
                                  name:(NSString *)name
                              mimeType:(NSString *)mimeType
                            parameters:(NSDictionary *)parameters
                              progress:(SNUploadProgress)progress
                               success:(SNResponseSuccess)success
                                  fail:(SNResponseFail)fail;

/**
 *
 *
 *    上传文件操作
 *
 *    @param url                        上传路径
 *    @param uploadingFile    待上传文件的路径
 *    @param progress            上传进度
 *    @param success                上传成功回调
 *    @param fail                    上传失败回调
 *
 *    @return
 */
+ (SNURLSessionTask *)uploadFileWithUrl:(NSString *)url
                           uploadingFile:(NSString *)uploadingFile
                                progress:(SNUploadProgress)progress
                                 success:(SNResponseSuccess)success
                                    fail:(SNResponseFail)fail;


/*!
 *
 *
 *  下载文件
 *
 *  @param url           下载URL
 *  @param saveToPath    下载到哪个路径下
 *  @param progressBlock 下载进度
 *  @param success       下载成功后的回调
 *  @param failure       下载失败后的回调
 */
+ (SNURLSessionTask *)downloadWithUrl:(NSString *)url
                            saveToPath:(NSString *)saveToPath
                              progress:(SNDownloadProgress)progressBlock
                               success:(SNResponseSuccess)success
                               failure:(SNResponseFail)failure;
/**
 *  取消对应task的网络请求
 */
+(void)cancleRequest:(SNURLSessionTask *)task;
/**
 *  取消所有网络请求
 */
+(void)cancleAllRequest;
@end
