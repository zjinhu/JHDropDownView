//
//  NLog.m
//  JHToolsModule
//
//  Created by HU on 2018/8/2.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "NLog.h"
static NSInteger G_N_DEBUG_START_LEVEL = N_LOG_LEVEL_TYPE_UNDEF;
@implementation NLog
+ (void) startLevel:(N_LOG_LEVEL_TYPE) level {
    if (level<N_LOG_LEVEL_TYPE_UNDEF || level>N_LOG_LEVEL_TYPE_FATAL) {
        return;
    }
    G_N_DEBUG_START_LEVEL = level;
}

+(void)NLog:(N_LOG_LEVEL_TYPE)level
       file:(const char*)sourceFile
 lineNumber:(int)lineNumber
       func:(const char *)funcName
     format:(NSString*)format,...{
    if (level < G_N_DEBUG_START_LEVEL) {
        return;
    }
    
    NSInteger logLevel = level==0 ? N_LOG_LEVEL_TYPE_UNDEF:level;
    NSString* func = [[NSString alloc] initWithBytes:funcName length:strlen(funcName) encoding:NSUTF8StringEncoding];
    if ([func length] > 50) {
        func = [func substringToIndex:50];
    }
    NSString* levelDesc = @"UDF";
    
    switch (logLevel) {
        case N_LOG_LEVEL_TYPE_DEBUG:
        {
            levelDesc = @"D";
            break;
        }
        case N_LOG_LEVEL_TYPE_INFO:
        {
            levelDesc = @"I";
            break;
        }
        case N_LOG_LEVEL_TYPE_WARN:
        {
            levelDesc = @"W";
            break;
        }
        case N_LOG_LEVEL_TYPE_ERROR:
        {
            levelDesc = @"E";
            break;
        }
        case N_LOG_LEVEL_TYPE_FATAL:
        {
            levelDesc = @"F";
            break;
        }
        default:
            break;
    }
#ifdef DEBUG
    va_list args;
    if (format) {
        va_start(args, format);
        NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
        NSString* newFormat = [NSString stringWithFormat:@"\n\n↓↓↓↓↓↓↓↓↓↓↓↓[%@]↓↓↓↓↓↓↓↓↓↓↓↓\n>>>>>>>>>>>>位置<<<<<<<<<<<<\n%@\n>>>>>>>>>>>>行数<<<<<<<<<<<<\n第%d行\n>>>>>>>>>>>>信息<<<<<<<<<<<<\n%@\n↑↑↑↑↑↑↑↑↑↑↑[END]↑↑↑↑↑↑↑↑↑↑↑\n\n",levelDesc,func,lineNumber,message];
        NSLogv(newFormat,args);
        va_end(args);
    }
#endif
}
@end


