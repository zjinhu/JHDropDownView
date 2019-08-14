//
//  NLog.h
//  JHToolsModule
//
//  Created by HU on 2018/8/2.
//  Copyright © 2018年 HU. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM (NSUInteger , N_LOG_LEVEL_TYPE) {
    N_LOG_LEVEL_TYPE_UNDEF = 0,     //未定义
    N_LOG_LEVEL_TYPE_DEBUG,         //调试
    N_LOG_LEVEL_TYPE_INFO,          //提示
    N_LOG_LEVEL_TYPE_WARN,          //警告
    N_LOG_LEVEL_TYPE_ERROR,         //错误
    N_LOG_LEVEL_TYPE_FATAL          //致命
};


#define LOG(lv,s,...)       [NLog NLog:lv file:__FILE__ lineNumber:__LINE__ func:__FUNCTION__ format:(s),##__VA_ARGS__]

#define DLOG(s,...)         LOG(N_LOG_LEVEL_TYPE_DEBUG,s,##__VA_ARGS__)
#define ILOG(s,...)         LOG(N_LOG_LEVEL_TYPE_INFO,s,##__VA_ARGS__)
#define WLOG(s,...)         LOG(N_LOG_LEVEL_TYPE_WARN,s,##__VA_ARGS__)
#define ELOG(s,...)         LOG(N_LOG_LEVEL_TYPE_ERROR,s,##__VA_ARGS__)
#define FLOG(s,...)         LOG(N_LOG_LEVEL_TYPE_FATAL,s,##__VA_ARGS__)



@interface NLog : NSObject

+ (void) startLevel:(N_LOG_LEVEL_TYPE) leve;

/**
 * @brief 格式化输出日志信息
 *
 *
 * @param [in]     level        日志级别
 * @param [in]      sourceFile   源文件
 * @param [in]      lineNumber   行数
 * @param [in]      funcName     方法名
 * @param [in]      format    ....
 */
+(void)NLog:(N_LOG_LEVEL_TYPE)level
       file:(const char*)sourceFile
 lineNumber:(int)lineNumber
       func:(const char *)funcName
     format:(NSString*)format,...;
@end
