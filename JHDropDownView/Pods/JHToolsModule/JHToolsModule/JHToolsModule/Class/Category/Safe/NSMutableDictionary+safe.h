//
//  NSMutableDictionary+safe.h
//  Juanpi
//
//  Created by airspuer on 13-5-8.
//  Copyright (c) 2013年 Juanpi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary(safe)

- (void)safeSetObject:(id)aObj forKey:(id<NSCopying>)aKey;

- (id)safeObjectForKey:(id<NSCopying>)aKey;

@end
