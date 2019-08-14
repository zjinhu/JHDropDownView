//
//  UserDefaults.h
//  JHToolsModule
//
//  Created by HU on 2018/8/2.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaults : NSObject

+ (void)setObject:(id)value forKey:(NSString *)defaultName;

+ (id)objectForKey:(NSString *)defaultName;

+ (void)setValue:(id)value forKey:(NSString *)defaultName;

+ (id)valueForKey:(NSString *)defaultName;

+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName;

+ (BOOL)boolForKey:(NSString *)defaultName;

+(void)removeObjectForKey:(NSString*)key;

+(void)clearAll;

@end
