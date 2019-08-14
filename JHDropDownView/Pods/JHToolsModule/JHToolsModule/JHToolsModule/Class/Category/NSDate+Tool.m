//
//  NSDate+Tool.m
//  JHToolsModule
//
//  Created by 狄烨 . on 2019/4/26.
//  Copyright © 2019 HU. All rights reserved.
//

#import "NSDate+Tool.h"

@implementation NSDate (Tool)
- (NSInteger)dateDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:self];
    return components.day;
}

- (NSInteger)dateMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth fromDate:self];
    return components.month;
}

- (NSInteger)dateYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:self];
    return components.year;
}

- (NSDate *)previousMonthDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    components.day = 15; // 定位到当月中间日子
    
    if (components.month == 1) {
        components.month = 12;
        components.year -= 1;
    } else {
        components.month -= 1;
    }
    
    NSDate *previousDate = [calendar dateFromComponents:components];
    
    return previousDate;
}

- (NSDate *)nextMonthDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    components.day = 15; // 定位到当月中间日子
    
    if (components.month == 12) {
        components.month = 1;
        components.year += 1;
    } else {
        components.month += 1;
    }
    
    NSDate *nextDate = [calendar dateFromComponents:components];
    
    return nextDate;
}

- (NSInteger)totalDaysInMonth {
    NSInteger totalDays = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
    return totalDays;
}

- (NSInteger)firstWeekDayInMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    components.day = 1; // 定位到当月第一天
    NSDate *firstDay = [calendar dateFromComponents:components];
    
    // 默认一周第一天序号为 1 ，而日历中约定为 0 ，故需要减一
    NSInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDay] - 1;
    
    return firstWeekday;
}
#pragma mark -- 获取日
+ (NSInteger)day:(NSString *)date {
    NSDateFormatter  *dateFormatter = [[self class] setDataFormatter];
    NSDate           *startDate     = [dateFormatter dateFromString:date];
    NSDateComponents *components    = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:startDate];
    
    return components.day;
}

#pragma mark -- 获取月
+ (NSInteger)month:(NSString *)date {
    NSDateFormatter  *dateFormatter = [[self class] setDataFormatter];
    NSDate           *startDate     = [dateFormatter dateFromString:date];
    NSDateComponents *components    = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:startDate];
    
    return components.month;
}

#pragma mark -- 获取年
+ (NSInteger)year:(NSString *)date {
    NSDateFormatter  *dateFormatter = [[self class] setDataFormatter];
    NSDate           *startDate     = [dateFormatter dateFromString:date];
    NSDateComponents *components    = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:startDate];
    
    return components.year;
}

#pragma mark -- 获得当前月份第一天星期几
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //设置每周的第一天从周几开始,默认为1,从周日开始
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate     *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday         = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    //若设置从周日开始算起则需要减一,若从周一开始算起则不需要减
    return firstWeekday - 1;
}

#pragma mark -- 获取当前月共有多少天
+ (NSInteger)totaldaysInMonth:(NSDate *)date {
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    
    return daysInLastMonth.length;
}

#pragma mark -- 获取日期
+ (NSString *)timeStringWithInterval:(NSTimeInterval)timeInterval {
    NSDateFormatter *dateFormatter = [[self class] setDataFormatter];
    NSDate          *date          = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString        *dateString    = [dateFormatter stringFromDate:date];
    
    return dateString;
}

#pragma mark -- 设置日期格式
+ (NSDateFormatter *)setDataFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    return dateFormatter;
}
//把国际时间转换为当前系统时间
+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}

#pragma mark -- 计算两个日期之间相差天数
+ (NSDateComponents *)calcDaysbetweenDate:(NSString *)startDateStr endDateStr:(NSString *)endDateStr {
    NSDateFormatter *dateFormatter = [[self class] setDataFormatter];
    NSDate          *startDate     = [dateFormatter dateFromString:startDateStr];
    NSDate          *endDate       = [dateFormatter dateFromString:endDateStr];
    
    //利用NSCalendar比较日期的差异
    NSCalendar *calendar = [NSCalendar currentCalendar];
    /**
     * 要比较的时间单位,常用如下,可以同时传：
     *    NSCalendarUnitDay : 天
     *    NSCalendarUnitYear : 年
     *    NSCalendarUnitMonth : 月
     *    NSCalendarUnitHour : 时
     *    NSCalendarUnitMinute : 分
     *    NSCalendarUnitSecond : 秒
     */
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth;
    
    NSDateComponents *delta = [calendar components:unit fromDate:startDate toDate:endDate options:0];
    
    return delta;
}

+ (NSTimeInterval)timeIntervalFromDateString:(NSString *)dateString {
    static NSDateFormatter *dateFormatter = nil;
    
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [dateFormatter setLocale:[NSLocale currentLocale]];
    }
    
    NSDate         *date    = [dateFormatter dateFromString:dateString];
    NSTimeInterval interval = [date timeIntervalSince1970];
    
    return interval;
}


+ (BOOL)isToday:(NSString *)date {
    BOOL isToday = NO;
    NSString *today = [NSDate timeStringWithInterval:[NSDate date].timeIntervalSince1970];
    if ([date isEqualToString:today]) {
        isToday = YES;
    }
    return isToday;
}

+ (BOOL)isEqualBetweenWithDate:(NSString *)date toDate:(NSString *)toDate {
    BOOL isToday = NO;
    if ([toDate isEqualToString:date]) {
        isToday = YES;
    }
    return isToday;
}

+ (BOOL)isCurrenMonth:(NSString *)date {
    BOOL isCurrenMonth = NO;
    NSString *month = [[NSDate timeStringWithInterval:[NSDate date].timeIntervalSince1970] substringWithRange:NSMakeRange(0, 7)];
    
    if ([date isEqualToString:month]) {
        isCurrenMonth = YES;
    }
    return isCurrenMonth;
}
+(NSDate *)getNewDateDistanceNowWithYear:(NSInteger)year withMonth:(NSInteger)month withDays:(NSInteger)days{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    NSDateComponents *adcomps = [[NSDateComponents alloc]init];
    [adcomps setYear:year];//year=1表示1年后的时间 year=-1为1年前的日期
    [adcomps setMonth:month];
    [adcomps setDay:days];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:[NSDate date] options:0];
    return newdate;
}

/**
 *  NSDate日期格式化转为NSString
 *
 *  @param date      待格式化Date
 *  @param formatter style
 *
 *  @return 格式化字符串
 */
+ (NSString *)stringFromDate:(NSDate *)date toFormatter: (NSString *) formatter {
    if (date && [formatter length] > 0) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        [dateFormatter setDateFormat: formatter];
        return [dateFormatter stringFromDate: date];
    }
    return nil;
}

/**
 *  NSString日期格式化转为NSDate
 *
 *  @param string    待格式化字符串
 *  @param formatter style
 *
 *  @return 格式化NSDate
 */
+ (NSDate *)dateFromString:(NSString *)string toFormatter: (NSString *) formatter {
    if ([string length] > 0 && [formatter length] > 0) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        [dateFormatter setDateFormat: formatter];
        return [dateFormatter dateFromString: string];
    }
    return nil;
}

@end
