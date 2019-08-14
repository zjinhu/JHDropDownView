//
//  UserDefaults.m
//  IKToolsModule
//
//  Created by HU on 2018/8/2.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "UserDefaults.h"

@implementation UserDefaults
+ (void)setObject:(id)value forKey:(NSString *)defaultName{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:defaultName];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (id)objectForKey:(NSString *)defaultName{
    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}

+(void)setValue:(id)value forKey:(NSString *)defaultName{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:defaultName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(id)valueForKey:(NSString *)defaultName{
    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}

+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:defaultName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)boolForKey:(NSString *)defaultName{
    return [[NSUserDefaults standardUserDefaults] boolForKey:defaultName];
}

+(void)removeObjectForKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)clearAll {
    //  清空本地数据，第一次进入的标识不清楚
    NSUserDefaults *userDefatluts = [NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = userDefatluts.dictionaryRepresentation;;
    for(NSString* key in [dictionary allKeys]){
        if ([key isEqualToString:@"isFirst"]) {
            continue;
        }
        [userDefatluts removeObjectForKey:key];
        [userDefatluts synchronize];
    }
}

@end
