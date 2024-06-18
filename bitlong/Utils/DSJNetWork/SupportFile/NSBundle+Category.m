//
//  NSBundle+Category.m
//  TVLive
//
//  Created by 秦宏伟 on 2018/8/31.
//  Copyright © 2018年 xiaohesong. All rights reserved.
//

#import "NSBundle+Category.h"

@implementation NSBundle (Category)


+(NSString *)getAppVersion{
    return [[[self mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+(NSString *)getBundleID{
    return [[[self mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

@end
