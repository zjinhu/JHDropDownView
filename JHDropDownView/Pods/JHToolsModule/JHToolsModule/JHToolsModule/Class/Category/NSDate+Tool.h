//
//  NSDate+Tool.h
//  JHToolsModule
//
//  Created by 狄烨 . on 2019/4/26.
//  Copyright © 2019 HU. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Tool)
/**
 *  获得当前 NSDate 对象对应的日子
 */
- (NSInteger)dateDay;

/**
 *  获得当前 NSDate 对象对应的月份
 */
- (NSInteger)dateMonth;

/**
 *  获得当前 NSDate 对象对应的年份
 */
- (NSInteger)dateYear;

/**
 *  获得当前 NSDate 对象的上个月的某一天（此处定为15号）的 NSDate 对象
 */
- (NSDate *)previousMonthDate;

/**
 *  获得当前 NSDate 对象的下个月的某一天（此处定为15号）的 NSDate 对象
 */
- (NSDate *)nextMonthDate;

/**
 *  获得当前 NSDate 对象对应的月份的总天数
 */
- (NSInteger)totalDaysInMonth;

/**
 *  获得当前 NSDate 对象对应月份当月第一天的所属星期
 */
- (NSInteger)firstWeekDayInMonth;

/// 获取日
+ (NSInteger)day:(NSString *)date;
/// 获取月
+ (NSInteger)month:(NSString *)date;
/// 获取年
+ (NSInteger)year:(NSString *)date;
/// 获取当月第一天周几
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;
/// 获取当前月有多少天
+ (NSInteger)totaldaysInMonth:(NSDate *)date;
/// 计算两个日期之间相差天数
+ (NSDateComponents *)calcDaysbetweenDate:(NSString *)startDateStr endDateStr:(NSString *)endDateStr;
/// 获取日期
+ (NSString *)timeStringWithInterval:(NSTimeInterval)timeInterval;
///根据具体日期获取时间戳
+ (NSTimeInterval)timeIntervalFromDateString:(NSString *)dateString;

+ (BOOL)isToday:(NSString *)date;
+ (BOOL)isEqualBetweenWithDate:(NSString *)date toDate:(NSString *)toDate;
///格式：2018-01
+ (BOOL)isCurrenMonth:(NSString *)date;
+ (NSDateFormatter *)setDataFormatter;
+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate;
/**
  获取距离当前时间多久的一个日期
  @param year year=1表示1年后的时间 year=-1为1年前的日期
  @param month 距离现在几个月
  @param days 距离现在几天
  @return 返回一个新的日期
  */
+(NSDate *)getNewDateDistanceNowWithYear:(NSInteger)year withMonth:(NSInteger)month withDays:(NSInteger)days;

/**
 *  NSDate日期格式化转为NSString
 *
 *  @param date      待格式化Date
 *  @param formatter style
 *
 *  @return 格式化字符串
 */
+ (NSString *)stringFromDate:(NSDate *)date toFormatter: (NSString *) formatter;

/**
 *  NSString日期格式化转为NSDate
 *
 *  @param string    待格式化字符串
 *  @param formatter style
 *
 *  @return 格式化NSDate
 */
+ (NSDate *)dateFromString:(NSString *)string toFormatter: (NSString *) formatter;
@end

NS_ASSUME_NONNULL_END
