//
//  AbstractLogger.h
//
//  Created by David on 05/7/12.
//  Copyright (c) 2015年 Lic. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    LogTypeMessage = 0,
    LogTypeData = 1
} LogType;

typedef enum {
    LogLevelFatal = 0,
    LogLevelError,
    LogLevelWarning,
    LogLevelInfo,
    LogLevelDebug
} LogLevel;

@interface AbstractLogger : NSObject

+ (NSString *)loggerName;

@property (nonatomic) int logLevel;
@property (nonatomic) NSString *module;
@property (nonatomic) Class klass;

- (void)info:(NSString *)format, ...;
- (void)debug:(NSString *)format, ...;
- (void)warning:(NSString *)format, ...;
- (void)error:(NSString *)format, ...;
- (void)fatal:(NSString *)format, ...;

@end
