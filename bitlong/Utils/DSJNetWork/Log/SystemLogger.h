//
//  NSLoggerWrapper.h
//  redlips
//
//  Created by David on 15/3/12.
//  Copyright (c) 2015年 xiaohongchun. All rights reserved.
//

#import "AbstractLogger.h"

@interface SystemLogger : AbstractLogger

+ (SystemLogger *)instance;

@end
