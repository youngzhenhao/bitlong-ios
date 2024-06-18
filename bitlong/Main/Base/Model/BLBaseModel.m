//
//  BLBaseModel.m
//  TVLive
//
//  Created by xiaohesong on 15/10/12.
//  Copyright (c) 2015年 xiaohesong. All rights reserved.
//

#import "BLBaseModel.h"
#import "bitlong-Swift.h"

@implementation BLBaseModel

- (instancetype)initWithDict:(id)dict {
    if (self = [super init]) {
        if ([dict isKindOfClass:[NSDictionary class]]) {
            [self setAttributes:(NSDictionary *)dict];
        }
    }
    return self;
}

#pragma mark - private
-(void)setAttributes:(NSDictionary*)dataDic {
    NSDictionary *attrMapDic = [self attributeMapDictionary];
    if (attrMapDic == nil) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[dataDic count]];
        for (NSString *key in dataDic) {
            @autoreleasepool {
                [dic setValue:key forKey:key];
                attrMapDic = dic;
            }
        }
    }
    
    NSEnumerator *keyEnum = [attrMapDic keyEnumerator];
    id attributeName;
    while ((attributeName = [keyEnum nextObject])) {
        SEL sel = [self getSetterSelWithAttibuteName:attributeName];
        if ([self respondsToSelector:sel]) {
            NSString *dataDicKey = [attrMapDic objectForKey:attributeName];
            id attributeValue = [dataDic objectForKey:dataDicKey];
            
            [self performSelectorOnMainThread:sel
                                   withObject:attributeValue
                                waitUntilDone:[NSThread isMainThread]];
        }
    }
}

/**
 指定所需要的attribute
 */
-(NSDictionary*)attributeMapDictionary{
    
    return nil;
}

/**
 generate setter methods name
 */
-(SEL)getSetterSelWithAttibuteName:(NSString*)attributeName{
    NSString *capital = [[attributeName substringToIndex:1] uppercaseString];
    NSString *setterSelStr = [NSString stringWithFormat:@"set%@%@:", capital, [attributeName substringFromIndex:1]];
    return NSSelectorFromString(setterSelStr);
}

//新系统版本归解档 协议实现
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        [self mj_decode:decoder];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [self mj_encode:encoder];
}

// 这个需要返回YES
+(BOOL)supportsSecureCoding{
    return YES;
}

@end
