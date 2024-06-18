//
//  SystemLogger.m
//  redlips
//
//  Created by David on 15/3/12.
//  Copyright (c) 2015年 xiaohongchun. All rights reserved.
//

#import "SystemLogger.h"

#define kDefaultLogDomain @"localhost"

#define LOG_MAKE(lvl,format,...)    va_list args; \
                                                    va_start(args, format); \
                                                    NSString *log = [[NSString alloc] initWithFormat:format arguments:args]; \
                                                    va_end(args); \
                                                    return [self level:lvl log:log]

@implementation SystemLogger

+ (NSString *)loggerName
{
    return @"NSLog";
}

- (void)info:(NSString *)format, ...
{
    LOG_MAKE(LogLevelInfo, format, ...);
}

- (void)debug:(NSString *)format, ...
{
    LOG_MAKE(LogLevelDebug, format, ...);
}

- (void)warning:(NSString *)format, ...
{
    LOG_MAKE(LogLevelWarning, format, ...);
}

- (void)error:(NSString *)format, ...
{
    LOG_MAKE(LogLevelError, format, ...);
}

- (void)fatal:(NSString *)format, ...
{
    LOG_MAKE(LogLevelFatal, format, ...);
}

- (void)level:(int)level log:(NSString *)log
{
    if (self.logLevel >= level) {
        NSString *levelString;
        switch (level) {
            case LogLevelDebug:
                levelString = @"Debug";
                break;
            case LogLevelInfo:
                levelString = @"Info";
                break;
            case LogLevelWarning:
                levelString = @"Warning";
                break;
            case LogLevelError:
                levelString = @"Error";
                break;
            case LogLevelFatal:
                levelString = @"Fatal Error";
                break;
                
            default:
                levelString = [NSString stringWithFormat:@"%d", level];
                break;
        }
        
        if (self.klass) {
            printf("%s : %s -> %s\n", [levelString UTF8String], [NSStringFromClass(self.klass) UTF8String], [log UTF8String]);
        } else {
            printf("%s : %s\n", [levelString UTF8String], [log UTF8String]);
        }
    }
}

@end
