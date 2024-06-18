//
//  NetworkManager.h
//
//  Created by David on 05/7/15.
//  Copyright (c) 2015年 Lic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ErrorRespModel.h"
#import "NSBundle+Category.h"
#import "LoggerFactory.h"
#import "AbstractLogger.h"
#import "Error.h"
#import "Util.h"

static NSString * _Nullable const  MYMUSIC = @"myMusic.mp3";

typedef NS_ENUM(NSInteger,RequestSerializerType){
    RequestJSONType = 0,
    RequestHTTPType
};

typedef NS_ENUM(NSInteger,RequestMethodType){
    RequestGET = 0,
    RequestPOST,
    RequestPUT,
};

typedef void(^OnSuccessBlock)(id _Nullable respObj);
//typedef void(^OnUploadProgressBlock)(id uploadProgress);
//typedef void(^OnDownloadProgressBlock)(id downloadProgress);
typedef void(^DownloadProgress)(id _Nullable progress);
typedef void(^OnRedirectBlock)(id _Nullable redirectBlock);
typedef void(^OnFailureBlock)(ErrorRespModel * _Nullable resp);

#define Device [UIDevice currentDevice]

#ifdef DEBUG
static NSString *_Nonnull const kServiceBaseUrl = @"http://132.232.109.84:8090/";
#else
static NSString *_Nonnull const kServiceBaseUrl = @"http://132.232.109.84:8090/";

#endif

@interface NetworkManager : NSObject

@property (nonatomic, strong) NSNumber* _Nullable requestNum;

+(instancetype _Nonnull )share;
- (void)addNewRequest;
- (void)subRequest;
-(void)setRequestHeader:(NSDictionary *_Nullable)headerParameter;


//新添加的方法
/**
 网络get请求
 @param urlStr 请求url
 @param parameter 请求参数
 @param onSuccess 成功回调
 @param onFailure 失败回调
 */
-(void)GETRequestUrlString:(NSString *_Nullable)urlStr paramerers:(NSDictionary *_Nullable)parameter requestHeader:(NSDictionary *_Nullable)header onSuccessBlock:(OnSuccessBlock _Nullable )onSuccess  onFailureBlock:(OnFailureBlock _Nullable )onFailure requestSerializerType:(RequestSerializerType)type;


//新添加的方法-获取bytes
/**
 网络get请求
 @param urlStr 请求url
 @param parameter 请求参数
 @param onSuccess 成功回调
 @param onFailure 失败回调
 */
-(void)GETBytesRequestUrlString:(NSString *_Nullable)urlStr paramerers:(NSDictionary *_Nullable)parameter requestHeader:(NSDictionary *_Nullable)header onSuccessBlock:(OnSuccessBlock _Nullable )onSuccess  onFailureBlock:(OnFailureBlock _Nullable )onFailure;

/**
 网络get请求
 @param urlStr 请求url
 @param parameter 请求参数
 @param onSuccess 成功回调
 @param onProgress 进度
 @param onFailure 失败回调
 */
-(void)GETRequestUrlString:(NSString *_Nullable)urlStr paramerers:(NSDictionary *_Nullable)parameter requestHeader:(NSDictionary *_Nullable)header onSuccessBlock:(OnSuccessBlock _Nullable )onSuccess OnProgressBlock:(DownloadProgress _Nullable )onProgress onFailureBlock:(OnFailureBlock _Nullable )onFailure requestSerializerType:(RequestSerializerType)type;

-(void)GETRequestUrlString_withOutHeader:(NSString * _Nullable)urlStr paramerers:(NSDictionary * _Nullable)parameter requestHeader:(NSDictionary * _Nullable)header onSuccessBlock:(OnSuccessBlock _Nullable )onSuccess onFailureBlock:(OnFailureBlock _Nullable)onFailure requestSerializerType:(RequestSerializerType)type;

/**
 网络post请求
 @param urlStr 请求url
 @param parameter 请求参数
 @param onSuccess 成功回调
 @param onFailure 失败回调
 */
-(void)POSTRequestUrlString:(NSString *_Nullable)urlStr paramerers:(NSDictionary *_Nullable)parameter requestHeader:(NSDictionary *_Nullable)header onSuccessBlock:(OnSuccessBlock _Nullable )onSuccess onFailureBlock:(OnFailureBlock _Nullable )onFailure requestSerializerType:(RequestSerializerType)type;
/**
 网络post请求
 @param urlStr 请求url
 @param parameter 请求参数
 @param onSuccess 成功回调
 @param onProgress 进度
 @param onFailure 失败回调
 */
-(void)POSTRequestUrlString:(NSString *_Nullable)urlStr paramerers:(NSDictionary *_Nullable)parameter requestHeader:(NSDictionary *_Nullable)header onSuccessBlock:(OnSuccessBlock _Nullable )onSuccess onProgressBlock:(DownloadProgress _Nullable )onProgress onFailureBlock:(OnFailureBlock _Nullable )onFailure requestSerializerType:(RequestSerializerType)type;



/**
 @param onProgress 进度
 */
-(void)setTaskRedirecBlock:(DownloadProgress _Nullable )onProgress;


/**
 网络post请求 body 是 json
 */
-(void)URLPOSTRequestUrlString:(NSString *_Nullable)urlStr paramerers:(id _Nullable )parameter requestHeader:(NSDictionary *_Nullable)header onSuccessBlock:(OnSuccessBlock _Nullable )onSuccess onFailureBlock:(OnFailureBlock _Nullable )onFailure;
 
/**
 请求protocbuf 数据
 */
-(void)GETBufRequestUrlString:(NSString *_Nullable)urlStr paramerers:(NSDictionary *_Nullable)parameter requestHeader:(NSDictionary *_Nullable)header onSuccessBlock:(OnSuccessBlock _Nullable )onSuccess onFailureBlock:(OnFailureBlock _Nullable )onFailure;

/**
 参数是json 格式
 */
-(void)POSTJsonRequestUrlString:(NSString *_Nullable)url paramerers:(NSString *_Nullable)jsonStr requestHeader:(NSDictionary *_Nullable)header onSuccessBlock:(OnSuccessBlock _Nullable )onSuccess onFailureBlock:(OnFailureBlock _Nullable )onFailure;

-(void)POSTJsonBody:(NSString *_Nullable)url paramerers:(NSString *_Nullable)jsonStr requestHeader:(NSDictionary *_Nullable)header onSuccessBlock:(OnSuccessBlock _Nullable )onSuccess onFailureBlock:(OnFailureBlock _Nullable )onFailure;


//加载音乐数据
-(void)loadDataWithUrlString:(NSString *_Nullable)urlStr isSaveTofile:(BOOL)isSave resaultBlock:(void(^_Nullable)(BOOL isSuccessed,NSData * _Nullable audioData))resault;


-(void)PUTRequestUrlString:(NSString *_Nullable)urlStr paramerers:(NSDictionary *_Nullable)parameter requestHeader:(NSDictionary *_Nullable)header onSuccessBlock:(OnSuccessBlock _Nullable )onSuccess onFailureBlock:(OnFailureBlock _Nullable )onFailure requestSerializerType:(RequestSerializerType)type;

//-(RACSignal *_Nullable)RacRequestUrlString:(NSString *_Nullable)urlStr paramerers:(NSDictionary *_Nullable)parameter requestHeader:(NSDictionary *_Nullable)header methodType:(RequestMethodType)methodType requestSerializerType:(RequestSerializerType)serializerType;

@end
