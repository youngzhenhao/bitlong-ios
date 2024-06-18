//
//  BLBaseModel.h
//  TVLive
//
//  Created by xiaohesong on 15/10/12.
//  Copyright (c) 2015年 xiaohesong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface BLBaseModel : NSObject<NSSecureCoding>

- (instancetype)initWithDict:(id)dict;

// 这个需要返回YES
+(BOOL)supportsSecureCoding;

@end
