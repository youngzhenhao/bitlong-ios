//
//  Logger.m
//  redlips
//
//  Created by David on 15/3/12.
//  Copyright (c) 2015年 xiaohongchun. All rights reserved.
//

#import "AbstractLogger.h"

@implementation AbstractLogger 

+ (NSString *)loggerName
{
    @throw [NSException exceptionWithName:@"MethodError" reason:@"[loggerName] must be override by sub classe" userInfo:nil];
}

- (instancetype)init
{
    if (self = [super init]) {
        self.logLevel = LogLevelInfo;
    }
    return self;
}

- (void)info:(NSString *)format, ...
{
    @throw [NSException exceptionWithName:@"MethodError" reason:@"[info] must be override by sub classe" userInfo:nil];
}

- (void)debug:(NSString *)format, ...
{
    @throw [NSException exceptionWithName:@"MethodError" reason:@"[debug] must be override by sub classe" userInfo:nil];
}

- (void)warning:(NSString *)format, ...
{
    @throw [NSException exceptionWithName:@"MethodError" reason:@"[warning] must be override by sub classe" userInfo:nil];
}

- (void)error:(NSString *)format, ...
{
    @throw [NSException exceptionWithName:@"MethodError" reason:@"[error] must be override by sub classe" userInfo:nil];
}

- (void)fatal:(NSString *)format, ...
{
    @throw [NSException exceptionWithName:@"MethodError" reason:@"[fatal] must be override by sub classe" userInfo:nil];
}

@end
