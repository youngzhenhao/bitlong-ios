//
//  BLKeychain.h
//  TVLive
//
//  Created by 秦宏伟 on 2018/12/6.
//  Copyright © 2018年 xiaohesong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BLKeychain : NSObject

+ (void)save:(NSString *)key data:(id)data;
+ (id)load:(NSString *)key class:(Class)class;
+ (void)delete:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
