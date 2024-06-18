//
//  NetworkManager.m
//
//  Created by David on 06/7/15
//  Copyright (c) 2014年 Lic. All rights reserved.
//

#import "NetworkManager.h"
#import "AFNetworking.h"

@interface NetworkManager (){
    NSString *_appId;
    NSString *_uuid;
}
@property (nonatomic, strong) NSString* language;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) AFHTTPSessionManager *bufManager;
@property (nonatomic, strong) AFURLSessionManager *urlManager;
@property (nonatomic, copy) NSString *sysVersion;
@end

@implementation NetworkManager {
    AbstractLogger *logger;
}

+(instancetype)share{
    static NetworkManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NetworkManager alloc] init];
    });
    return instance;
}


- (id)init {
    self = [super init];
    if (self) {
        logger = [LoggerFactory defaultLogger:[NetworkManager class]];
        self.requestNum = @0;
        _sysVersion = [NSBundle getAppVersion];
//        _appId = [NSBundle getAppId];

        [self createAFNManager:kServiceBaseUrl];
    }
    
    return self;
}

-(void)createAFNManager:(NSString *)baseUrl{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData; //忽略本地缓存数据，直接请求服务端
    
    configuration.timeoutIntervalForRequest = 10; //设置请求超时时间
    NSURL *url = [NSURL URLWithString:baseUrl];
    self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url sessionConfiguration:configuration];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"multipart/form-data",@"text/plain",@"application/octet-stream",nil];
    
    self.urlManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    self.bufManager = [[AFHTTPSessionManager alloc] initWithBaseURL:url sessionConfiguration:configuration];
    self.bufManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    AFHTTPResponseSerializer *seria = [AFHTTPResponseSerializer serializer];
    seria.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"multipart/form-data",@"text/plain",@"application/octet-stream",nil];
    self.urlManager.responseSerializer = seria;
}


-(AFSecurityPolicy *)securityPolicy:(NSString *)url {
    AFSecurityPolicy *securityPolicy = nil;
    if([url hasPrefix:@"https://"]) {
        securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        securityPolicy.allowInvalidCertificates = NO;
        securityPolicy.validatesDomainName = YES;
    }else {
        securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        securityPolicy.allowInvalidCertificates = NO;
        securityPolicy.validatesDomainName = NO;
    }
    return securityPolicy;
}


#pragma mark - 取消所有网络请求
- (void)cancleAllOperation{
    if (self.manager) {
        [self.manager invalidateSessionCancelingTasks:YES resetSession:NO];
    }
}


-(void)setRequestHeader:(NSDictionary *)headerParameter{
    if (headerParameter) {
        NSArray *allKeys = headerParameter.allKeys;
        if(allKeys && 0 < allKeys.count){
            for (NSString *key in allKeys) {
                if(key && headerParameter[key]){
                    [self.manager.requestSerializer setValue:headerParameter[key] forHTTPHeaderField:key];
                    [self.bufManager.requestSerializer setValue:headerParameter[key] forHTTPHeaderField:key];
                }
            }
        }
    }
}


#pragma mark - Cache
- (void)setCache {
    NSURLCache* URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:300 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
}

- (NSString*)getPreferredLanguage {
    if (self.language == nil) {
        NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
        NSArray* languages = [defs objectForKey:@"AppleLanguages"];
        self.language = [languages objectAtIndex:0];
        if ([self.language hasPrefix:@"zh-Hans"]) {
            self.language = @"zh_cn";
        } else if ([self.language hasPrefix:@"zh-Hant"]) {
            self.language = @"zh_tw";
        } else if ([self.language hasPrefix:@"zh-TW"]) {
            self.language = @"zh_tw";
        } else if ([self.language hasPrefix:@"zh-HK"]) {
            self.language = @"zh_hk";
        } else if ([self.language hasPrefix:@"en-US"]) {
            self.language = @"en";
        }
    }
    
    return self.language;
}

#pragma mark - 每多添加一次请求, 计数 +1
- (void)addNewRequest {
    NSInteger num = [self.requestNum integerValue];
    num++;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.requestNum = @(num);
    [logger debug:@"add new REQUEST_NUM -> %li", (long)num];
}
#pragma mark - 每取消一次请求, 计数 -1
- (void)subRequest {
    NSInteger num = [self.requestNum integerValue];
    num--;
    if(num == 0)
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.requestNum = @(num);
    
    [logger debug:@"sub REQUEST_NUM -> %li", (long)num];
}

-(void)GETRequestUrlString:(NSString *)urlStr paramerers:(NSDictionary *)parameter requestHeader:(NSDictionary * _Nullable)header onSuccessBlock:(OnSuccessBlock _Nullable)onSuccess onFailureBlock:(OnFailureBlock _Nullable)onFailure requestSerializerType:(RequestSerializerType)type{
    self.manager.securityPolicy = [self securityPolicy:urlStr];
    [self GETRequestUrlString:urlStr paramerers:parameter requestHeader:header onSuccessBlock:^(id  _Nullable respObj) {
        if (onSuccess) {
            onSuccess(respObj);
        }
    } OnProgressBlock:^(id  _Nullable progress) {
        
    } onFailureBlock:^(ErrorRespModel * _Nullable resp) {
        if (onFailure) {
            onFailure(resp);
        }
    } requestSerializerType:type];
}

-(void)GETRequestUrlString:(NSString *)urlStr paramerers:(NSDictionary *)parameter requestHeader:(NSDictionary *)header onSuccessBlock:(OnSuccessBlock)onSuccess OnProgressBlock:(DownloadProgress)onProgress onFailureBlock:(OnFailureBlock)onFailure requestSerializerType:(RequestSerializerType)type{
    [self setRequestHeader:header];
    if (type == RequestJSONType) {
        [self.manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    }else{
        [self.manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    }
    
    [self.manager GET:urlStr parameters:parameter headers:header progress:^(NSProgress * _Nullable downloadProgress) {
        if(onProgress){
            onProgress(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)task.response;
        if (httpRes.statusCode == 200) {  //200请求成功 返回数据
            if(onSuccess){
                onSuccess(responseObject);
            }
        }else{
            ErrorRespModel *errModel = [[ErrorRespModel alloc] init];
            NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)task.response;
            errModel.msg = [NSHTTPURLResponse localizedStringForStatusCode:httpRes.statusCode];
            errModel.statusCode = httpRes.statusCode;
            if (onFailure) {
                onFailure(errModel);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        ErrorRespModel *errModel = [[ErrorRespModel alloc] init];
        NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)task.response;
        if (onFailure && error) {
            if (error.code  == -1001) {
                NSLog(@"==请求超时==");
            }
            errModel.code = [NSString stringWithFormat:@"%ld",(long)error.code];
            errModel.msg = error.userInfo[@"NSDebugDescription"];
            errModel.statusCode = httpRes.statusCode;
            onFailure(errModel);
        }
    }];
}

-(void)GETBytesRequestUrlString:(NSString *)urlStr paramerers:(NSDictionary *)parameter requestHeader:(NSDictionary *)header onSuccessBlock:(OnSuccessBlock)onSuccess onFailureBlock:(OnFailureBlock)onFailure{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
     
    NSURL * URL = [NSURL URLWithString:urlStr relativeToURL:self.manager.baseURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    // 设置请求头部，指定接收的数据类型
    request.HTTPMethod = @"GET";
    for (NSString *headerField in header.keyEnumerator) {
        [request setValue:header[headerField] forHTTPHeaderField:headerField];
    }
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:
                                   ^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)response;
        if (error) {
            if(onFailure){
                ErrorRespModel *errModel = [[ErrorRespModel alloc] init];
                errModel.msg = error.userInfo[@"NSDebugDescription"];
                errModel.statusCode = httpRes.statusCode;
                onFailure(errModel);
            }
        }else{
            if (httpRes.statusCode == 200) {  //200请求成功 返回数据
                if(onSuccess){
                    onSuccess(data);
                }
            }else{
                if(onFailure){
                    ErrorRespModel *errModel = [[ErrorRespModel alloc] init];
                    errModel.msg = [NSHTTPURLResponse localizedStringForStatusCode:httpRes.statusCode];
                    errModel.statusCode = httpRes.statusCode;
                    onFailure(errModel);
                }
            }
        }
    }];
    
    [task resume];
}


-(void)POSTRequestUrlString:(NSString *)urlStr paramerers:(NSDictionary *)parameter requestHeader:(NSDictionary * _Nullable)header onSuccessBlock:(OnSuccessBlock)onSuccess onFailureBlock:(OnFailureBlock)onFailure requestSerializerType:(RequestSerializerType)type{
    [self POSTRequestUrlString:urlStr paramerers:parameter requestHeader:header onSuccessBlock:^(id respObj) {
        if (onSuccess) {
            onSuccess(respObj);
        }
    } onProgressBlock:^(id  _Nullable progress) {
        
    } onFailureBlock:^(ErrorRespModel *resp) {
        if (onFailure) {
            onFailure(resp);
        }
    } requestSerializerType:type];
}

-(void)POSTRequestUrlString:(NSString *)urlStr paramerers:(NSDictionary *)parameter requestHeader:(NSDictionary * _Nullable)header onSuccessBlock:(OnSuccessBlock)onSuccess onProgressBlock:(DownloadProgress)onProgress onFailureBlock:(OnFailureBlock)onFailure requestSerializerType:(RequestSerializerType)type{
    [self setRequestHeader:header];
    if(type == RequestJSONType){//需要json序列化
        [self.manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    }else{
        [self.manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    }
    self.manager.securityPolicy = [self securityPolicy:urlStr];
    
    [self.manager POST:urlStr parameters:parameter headers:header progress:^(NSProgress * _Nullable uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)task.response;
        if (httpRes.statusCode == 200) {  //200请求成功 返回数据
            if(onSuccess){
                onSuccess(responseObject);
            }
        }else{
            ErrorRespModel *errModel = [[ErrorRespModel alloc] init];
            NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)task.response;
            errModel.msg = [NSHTTPURLResponse localizedStringForStatusCode:httpRes.statusCode];
            errModel.statusCode = httpRes.statusCode;
            if (onFailure) {
                onFailure(errModel);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        ErrorRespModel *errModel = [[ErrorRespModel alloc] init];
        NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)task.response;
        if (onFailure && error) {
            if (error.code  == -1001) {
                NSLog(@"==请求超时==");
            }
            errModel.code = [NSString stringWithFormat:@"%ld",(long)error.code];;
            errModel.msg = error.userInfo[@"NSDebugDescription"];
            errModel.statusCode = httpRes.statusCode;
            onFailure(errModel);
        }
    } ];
    //    [self setTaskRedirecBlock:^(id redirecObj) { //检测重定向
    //        if (onRedirect) {
    //            onRedirect(redirecObj);
    //        }
    //    }];
    //
}


-(void)PUTRequestUrlString:(NSString *)urlStr paramerers:(NSDictionary *)parameter requestHeader:(NSDictionary * _Nullable)header  onSuccessBlock:(OnSuccessBlock)onSuccess onFailureBlock:(OnFailureBlock)onFailure requestSerializerType:(RequestSerializerType)type{
    [self setRequestHeader:header];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",nil];
    if (type == RequestJSONType) {
        [self.manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    }else{
        [self.manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    }
    self.manager.responseSerializer= [AFHTTPResponseSerializer serializer];
    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self.manager.requestSerializer setValue:@"image/jpeg" forHTTPHeaderField:@"Content-Type"];
    

    [self.manager PUT:urlStr parameters:parameter headers:@{@"Content-Type":@"image/jpeg"} success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)task.response;
        if (httpRes.statusCode == 200) {  //200请求成功 返回数据
            if(onSuccess){
                onSuccess(responseObject);
            }
        }else{
            ErrorRespModel *errModel = [[ErrorRespModel alloc] init];
            NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)task.response;
            errModel.msg = [NSHTTPURLResponse localizedStringForStatusCode:httpRes.statusCode];
            errModel.statusCode = httpRes.statusCode;
            if (onFailure) {
                onFailure(errModel);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        ErrorRespModel *errModel = [[ErrorRespModel alloc] init];
        NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)task.response;
        if (onFailure && error) {
            if (error.code  == -1001) {
                NSLog(@"==请求超时==");
            }
            errModel.code = [NSString stringWithFormat:@"%ld",(long)error.code];;
            errModel.msg = error.userInfo[@"NSDebugDescription"];
            errModel.statusCode = httpRes.statusCode;
            onFailure(errModel);
        }
    }];
}


#pragma mark - 检测重定向
-(void)setTaskRedirecBlock:(OnRedirectBlock)onRedirect{
    [self.manager setTaskWillPerformHTTPRedirectionBlock:^NSURLRequest * _Nullable(NSURLSession * _Nullable session, NSURLSessionTask * _Nullable task, NSURLResponse * _Nullable response, NSURLRequest * _Nullable request) {
        NSLog(@"%@",request);
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSInteger statusCode = httpResponse.statusCode;
        NSDictionary *headerDic = httpResponse.allHeaderFields;
        if (statusCode == 302) { //302重定向后去location 返回数据
            NSString *importKey = headerDic[@"Location"];
            if (onRedirect) {
                onRedirect(importKey);
            }
        }
        return request;
    }];
}

#pragma mark - 传json数据
-(void)URLPOSTRequestUrlString:(NSString *)urlStr paramerers:(id)parameter requestHeader:(NSDictionary * _Nullable)header onSuccessBlock:(OnSuccessBlock)onSuccess onFailureBlock:(OnFailureBlock)onFailure{
    [self setRequestHeader:header];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameter options:0 error:&error];
    if (error) return;
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlStr parameters:nil error:nil];
    
    [req setValue:@"Dsj/Log1.0(iOS)" forHTTPHeaderField:@"User-Agent"];
    
    NSDictionary *headDict = header;
    NSArray *allKeys = headDict.allKeys;
    for (NSString *key in allKeys) {
        [req setValue:headDict[key] forHTTPHeaderField:key];
        
    }
    
    [req setHTTPBody:[mutStr dataUsingEncoding:NSUTF8StringEncoding]];
    [[self.urlManager dataTaskWithRequest:req uploadProgress:^(NSProgress * _Nullable uploadProgress) {
                
    } downloadProgress:^(NSProgress * _Nullable downloadProgress) {
                
    } completionHandler:^(NSURLResponse * _Nullable response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            if([responseObject isKindOfClass:[NSData class]]){
                if (onSuccess) {
                    id res = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                    onSuccess(res);
                }
            }else{
                if (onSuccess) {
                    onSuccess(responseObject);
                }
            }
        } else {
            if (onFailure) {
                ErrorRespModel *errModel = [[ErrorRespModel alloc] init];
                NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)response;
                if (error.code  == -1001) {
                    NSLog(@"==请求超时==");
                }
                errModel.code = [NSString stringWithFormat:@"%ld",(long)error.code];;
                errModel.msg = error.userInfo[@"NSDebugDescription"];
                errModel.statusCode = httpRes.statusCode;
                onFailure(errModel);
            }
        }
    }] resume];
}



-(void)GETBufRequestUrlString:(NSString *)urlStr paramerers:(NSDictionary *)parameter requestHeader:(NSDictionary * _Nullable)header  onSuccessBlock:(OnSuccessBlock)onSuccess onFailureBlock:(OnFailureBlock)onFailure{
    [self setRequestHeader:header];
    self.bufManager.securityPolicy = [self securityPolicy:urlStr];
    [self.bufManager GET:urlStr parameters:parameter headers:header progress:^(NSProgress * _Nullable downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)task.response;
        if (httpRes.statusCode == 200) {  //200请求成功 返回数据
            if(onSuccess){
                onSuccess(responseObject);
            }
        }else{
            if(onFailure){
                ErrorRespModel *errModel = [[ErrorRespModel alloc] init];
                NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)task.response;
                errModel.msg = [NSHTTPURLResponse localizedStringForStatusCode:httpRes.statusCode];
                errModel.statusCode = httpRes.statusCode;
                onFailure(errModel);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        ErrorRespModel *errModel = [[ErrorRespModel alloc] init];
        NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)task.response;
        if (onFailure && error) {
            if (error.code  == -1001) {
                NSLog(@"==请求超时==");
            }
            errModel.code = [NSString stringWithFormat:@"%ld",(long)error.code];;
            errModel.msg = error.userInfo[@"NSDebugDescription"];
            errModel.statusCode = httpRes.statusCode;
            onFailure(errModel);
        }
    }];
}

-(void)POSTJsonRequestUrlString:(NSString *)url paramerers:(NSString *)jsonStr requestHeader:(NSDictionary * _Nullable)header onSuccessBlock:(OnSuccessBlock)onSuccess onFailureBlock:(OnFailureBlock)onFailure{
    [self setRequestHeader:header];
    NSURLSession *shareSessin = [NSURLSession sharedSession];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setValue:@"Dsj/Log1.0(iOS)" forHTTPHeaderField:@"User-Agent"];
    
    NSDictionary *headDict = header;
    NSArray *allKeys = headDict.allKeys;
    for (NSString *key in allKeys) {
        [urlRequest setValue:headDict[key] forHTTPHeaderField:key];
    }
    
    [urlRequest setHTTPBody:[jsonStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *dataTask = [shareSessin dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)response;
        
        if (data && httpRes.statusCode == 200) {
            id res =  [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                if(onSuccess){
                    onSuccess(res);
                }
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                ErrorRespModel *errModel = [[ErrorRespModel alloc] init];
                if(error){
                    if (error.code  == -1001) {
                        NSLog(@"==请求超时==");
                    }
                    errModel.code = [NSString stringWithFormat:@"%ld",(long)error.code];
                }else{
                    errModel.code = [NSString stringWithFormat:@"-1"];
                }
                errModel.msg = error.userInfo[@"NSDebugDescription"];
                errModel.statusCode = httpRes.statusCode;
                if (onFailure) {
                    onFailure(errModel);
                }
            });
        }
    }];
    
    [dataTask resume];
}


-(void)GETRequestUrlString_withOutHeader:(NSString *)urlStr paramerers:(NSDictionary *)parameter requestHeader:(NSDictionary * _Nullable)header onSuccessBlock:(OnSuccessBlock)onSuccess onProgressBlock:(DownloadProgress)onProgress onFailureBlock:(OnFailureBlock)onFailure requestSerializerType:(RequestSerializerType)type{
    [self GETRequestUrlString_WithOutHeaderInfo:urlStr paramerers:parameter requestHeader:header onSuccessBlock:^(id  _Nullable respObj) {
        if (onSuccess) {
            onSuccess(respObj);
        }
    } onProgressBlock:^(id  _Nullable progress) {
        if (onProgress) {
            onProgress(progress);
        }
    } onFailureBlock:^(ErrorRespModel * _Nullable resp) {
        if (onFailure) {
            onFailure(resp);
        }
    } requestSerializerType:type];
}
-(void)GETRequestUrlString_WithOutHeaderInfo:(NSString *)urlStr paramerers:(NSDictionary *)parameter requestHeader:(NSDictionary * _Nullable)header onSuccessBlock:(OnSuccessBlock)onSuccess onProgressBlock:(DownloadProgress)onProgress onFailureBlock:(OnFailureBlock)onFailure requestSerializerType:(RequestSerializerType)type{
    [self setRequestHeader:header];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (type == RequestJSONType) {
        [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    }else{
        [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    }
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.securityPolicy = [self securityPolicy:urlStr];
    [manager GET:urlStr parameters:nil headers:header progress:^(NSProgress * _Nullable downloadProgress) {
        if (onProgress && downloadProgress) {
            onProgress(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
        NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)task.response;
        if (httpRes.statusCode == 200) {  //200请求成功 返回数据
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            if (onSuccess && jsonDict) {
                onSuccess(jsonDict);
            }
        }else{
            if (onFailure) {
                ErrorRespModel *errModel = [[ErrorRespModel alloc] init];
                NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)task.response;
                errModel.msg = [NSHTTPURLResponse localizedStringForStatusCode:httpRes.statusCode];
                errModel.statusCode = httpRes.statusCode;
                onFailure(errModel);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
        ErrorRespModel *errModel = [[ErrorRespModel alloc] init];
        NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)task.response;
        if (onFailure && error) {
            if (error.code  == -1001) {
                NSLog(@"==请求超时==");
            }
            errModel.code = [NSString stringWithFormat:@"%ld",(long)error.code];
            errModel.msg = error.userInfo[@"NSDebugDescription"];
            errModel.statusCode = httpRes.statusCode;
            onFailure(errModel);
        }
    }];
}

-(void)POSTJsonBody:(NSString *)url paramerers:(NSString *)jsonStr requestHeader:(NSDictionary * _Nullable)header  onSuccessBlock:(OnSuccessBlock)onSuccess onFailureBlock:(OnFailureBlock)onFailure{
    [self setRequestHeader:header];
    NSURLSession *shareSessin = [NSURLSession sharedSession];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setValue:@"Dsj/Log1.0(iOS)" forHTTPHeaderField:@"User-Agent"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary *headDict = header;
    NSArray *allKeys = headDict.allKeys;
    for (NSString *key in allKeys) {
        [urlRequest setValue:headDict[key] forHTTPHeaderField:key];
    }
    [urlRequest setHTTPBody:[jsonStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *dataTask = [shareSessin dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *httpRes = (NSHTTPURLResponse *)response;
        
        if (data && httpRes.statusCode == 200) {
            id res =  [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (onSuccess) {
                    onSuccess(res);
                }
            });
        }
        if(onFailure && error){
            if (error.code  == -1001) {
                NSLog(@"==请求超时==");
            }
            ErrorRespModel *errModel = [[ErrorRespModel alloc] init];
            errModel.code = [NSString stringWithFormat:@"%ld",(long)error.code];;
            errModel.msg = error.userInfo[@"NSDebugDescription"];
            errModel.statusCode = httpRes.statusCode;
            dispatch_async(dispatch_get_main_queue(), ^{
                onFailure(errModel);
            });
        }
    }];
    
    [dataTask resume];
}

-(void)loadDataWithUrlString:(NSString *_Nullable)urlStr isSaveTofile:(BOOL)isSave resaultBlock:(void(^_Nullable)(BOOL isSuccessed,NSData * _Nullable audioData))resault{
    if (!urlStr || [urlStr isKindOfClass:[NSNull class]]) {
        
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData * audioData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
        if (isSave) {
            NSString * path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",MYMUSIC]];
            [audioData writeToFile:path atomically:YES];
            BOOL isHave = [[NSFileManager defaultManager] fileExistsAtPath:path];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (resault) {
                    resault(isHave,audioData);
                }
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (resault) {
                    resault(NO,audioData);
                }
            });
        }
    });
}

//-(RACSignal *_Nullable)RacRequestUrlString:(NSString *_Nullable)urlStr paramerers:(NSDictionary *_Nullable)parameter requestHeader:(NSDictionary *_Nullable)header methodType:(RequestMethodType)methodType requestSerializerType:(RequestSerializerType)serializerType{
//    if (!urlStr) {
//        return [RACSignal error:[NSError errorWithDomain:NSNetServicesErrorDomain code:-1 userInfo:nil]];
//    }
//    
//    @weakify(self);
//    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nullable subscriber) {
//        @strongify(self);
//        self.manager.securityPolicy = [self securityPolicy:urlStr];
//        
//        if (methodType == RequestGET) {
//            [self GETRequestUrlString:urlStr paramerers:parameter requestHeader:header onSuccessBlock:^(id  _Nullable respObj) {
//                [subscriber sendNext:respObj];
//                [subscriber sendCompleted];
//            } onFailureBlock:^(ErrorRespModel * _Nullable resp) {
//                [subscriber sendNext:resp];
//                [subscriber sendCompleted];
//            } requestSerializerType:serializerType];
//        }else if (methodType == RequestPOST){
//            [self POSTRequestUrlString:urlStr paramerers:parameter requestHeader:header onSuccessBlock:^(id respObj) {
//                [subscriber sendNext:respObj];
//                [subscriber sendCompleted];
//            } OnRedirectBlock:^(id redirecObj) {
//                
//            } onFailureBlock:^(ErrorRespModel *resp) {
//                [subscriber sendNext:resp];
//                [subscriber sendCompleted];
//            } requestSerializerType:serializerType];
//        }
//        
//        //用于取消订阅或者清理资源
//        return [RACDisposable disposableWithBlock:^{
//        }];
//    }];
//    
//    
//    return [signal replayLazily]; //多次订阅同样的信号，执行一次
//}


@end
