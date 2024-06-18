//
//  LoggerFactory.m
//  redlips
//
//  Created by David on 15/3/12.
//  Copyright (c) 2015年 xiaohongchun. All rights reserved.
//

#import "LoggerFactory.h"
#import "SystemLogger.h"

@implementation LoggerFactory


+ (AbstractLogger *)defaultLogger:(Class)c
{
    return [LoggerFactory getLoggerByName:[SystemLogger loggerName] inClass:c];
}

+ (AbstractLogger *)getLoggerByName:(NSString *)loggerName inClass:(Class)c
{
    if ([loggerName isEqualToString:[SystemLogger loggerName]]) {
        AbstractLogger *logger = [[SystemLogger alloc] init];
        logger.logLevel = kLogLevel;
        logger.klass = c;
        return logger;
    }
    
    return nil;
}

@end
