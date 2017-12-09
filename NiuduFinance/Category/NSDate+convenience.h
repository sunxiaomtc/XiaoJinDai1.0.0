//
//  NSDate+convenience.h
//
//  Created by chicp on 13-12-16.
//  Copyright (c) 2013年 KK.net All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Convenience)

- (NSDate *)dateByAppendingYears:(NSInteger)years;
- (NSDate *)dateByAppendingMonths:(NSInteger)months;
- (NSDate *)dateByAppendingDays:(NSInteger)days;
- (NSDate *)dateByAppendingHours:(NSInteger)hours;
- (NSDate *)dateByAppendingMinutes:(NSInteger)minutes;

// 一个月的天数
- (NSInteger)numberOfDaysOfMonth;
//date所对应的年 月 日
- (NSString *)hourAndMinutes;
- (NSString *)getDateWithTypeString:(NSString *)string;
- (NSString *)yearAndMonth;
- (NSString *)monthAndDay;
- (NSString *)yearAndMonthAndDay;
//设置新的年月
- (NSDate *)newDateWithYear:(NSInteger)year month:(NSInteger)month;
- (NSDate *)newDateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
- (NSDate *)newDateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minutes:(NSInteger)minutes;
//获取上个月的data
- (NSDate *)lastMonth;
//获取下个月的data
- (NSDate *)nextMonth;

- (NSString *)dateAfterDayForCanlendar:(NSInteger)day;

// 这个月的第一天是星期几
- (NSInteger)weekdayInFirstDayOfMonth;
- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)day;
- (NSInteger)hour;
- (NSInteger)minute;
- (NSInteger)second;

- (NSInteger)monthsBetweenDate:(NSDate *)anotherDate;
- (NSInteger)daysBetweenDate:(NSDate *)anotherDate;
- (NSInteger)minutesBetweenDate:(NSDate *)anotherDate;

// 最近第一个工作日的日期
- (NSDate *)nearestFirstWeekdayOfDate;
- (NSDate *)dateOfStartOfMonth;
// 月底日期
- (NSDate *)dateOfEndOfMonth;

- (NSDate *)dateOfStartOfWeek;
- (NSDate *)dateOfEndOfWeek;

// 一天的开始日期
- (NSDate *)dateOfStartOfDay;
// 一天的结束日期
- (NSDate *)dateOfEndOfDay;

@end
