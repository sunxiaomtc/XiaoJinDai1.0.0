//
//  NSDate+Helpers.h
//  Bali
//
//  Created by chicp on 13-7-25.
//  Copyright (c) 2013年 taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Common)

- (NSString *)dateToYearMounthDay:(NSDate *)date;

//返回day天后的日期(若day为负数,则为|day|天前的日期)
- (NSDate *)dateAfterDay:(NSInteger)day;

- (NSDate *)dateAfterMinute:(NSInteger)minute;

//返回一周的第几天(周末为第一天)
- (NSUInteger)weekday;

- (NSString *)getChinaWeekName;
- (NSString *)getChinaWeekName2;

//获取小时
- (NSInteger)getHour;

//获取分钟
- (NSInteger)getMinute;

// 差几年
- (NSInteger)yearAfterNumWithAnotherDate:(NSDate *)anotherDate;
//差几天
- (NSInteger)dayAfterNumWithAnotherDate:(NSDate *)anotherDate;

- (NSInteger)minutesAfterNumWithAnotherDate:(NSDate *)anotherDate;

- (NSInteger)secondAfterNumWithAnotherDate:(NSDate *)anotherDate;

// 差几分钟
- (NSInteger)minutesAfterNumWithTimestamp:(NSString *)timestamp;

// 花儿---->遇见页时间
- (NSString *)getMeetTimeWithTimestamp:(NSString *)timestamp;
// 时间显示规则
- (NSString *)getTimeWithValue:(NSString *)timestamp;
// -----> 朋友--->来访时间
- (NSString *)getTimeWithTimestamp:(NSString *)timestamp;
// 动态 -----> 发布动态时间
- (NSString *)getDynamicPublishTimeWithTimestamp:(NSString *)timestamp;

// ----> 消息时间
- (NSString *)getMessageTimeWithTimestamp:(NSString *)timestamp;

- (NSString *)getDateValue:(NSString *)aStr andFormatter:(NSString *)formatterStr;

- (NSUInteger)getDay;

- (NSUInteger)getMonth;

- (NSUInteger)getYear;

//NSDate (Action)
- (NSString *)toShortDateString;

- (NSString *)toLongDateString;

- (NSString *)toString;

- (NSString *)toFileNameString;

- (NSString *)toHourMinString;

- (NSString *)toString:(NSString *)format;

- (NSDate *)stringToDate:(NSString *)string;

- (NSDate *)stringToDateYearMd:(NSString *)string;
//判断是不是今天
- (BOOL)compareDate:(NSDate *)date;
//当前时间之前之后N天的日期
- (NSString *)getOtherDay:(NSInteger)days;

//秒数换算
- (NSString *)getTimeFromSecound:(NSString *)secound;
@end
