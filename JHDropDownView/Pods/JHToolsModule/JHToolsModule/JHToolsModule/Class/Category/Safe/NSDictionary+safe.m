//
//  NSDictionary+safe.m
//  Juanpi
//
//  Created by huang jiming on 14-1-8.
//  Copyright (c) 2014年 Juanpi. All rights reserved.
//

#import "NSDictionary+safe.h"

@implementation NSDictionary (safe)

+ (id)safeDictionaryWithObject:(id)object forKey:(id <NSCopying>)key
{
    if (object==nil || key==nil) {
        return [self dictionary];
    } else {
        return [self dictionaryWithObject:object forKey:key];
    }
}

@end
