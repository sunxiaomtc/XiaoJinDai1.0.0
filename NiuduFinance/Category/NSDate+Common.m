//
//  NSDate+Helpers.m
//  Bali
//
//  Created by chicp on 13-7-25.
//  Copyright (c) 2013年 taobao. All rights reserved.
//

#import "NSDate+Common.h"

@implementation NSDate (Common)

//获取年月日如:19871127.
- (NSString *)getFormatYearMonthDay
{
    NSString *string = [NSString stringWithFormat:@"%lu%02lu%02lu", [self getYear], [self getMonth], [self getDay]];
    return string;
}

//该日期是该年的第几周
- (NSInteger)getWeekOfYear
{
    NSInteger i;
    NSInteger year = [self getYear];
    NSDate * date = [self endOfWeek];
    for (i = 1;[[date dateAfterDay:-7 * i] getYear] == year; i++) {
        
    }
    return i;
}
//返回day天后的日期(若day为负数,则为|day|天前的日期)
- (NSDate *)dateAfterDay:(NSInteger)day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get the weekday component of the current date
    // NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    // to get the end of week for a particular date, add (7 - weekday) days
    [componentsToAdd setDay:day];
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];

    return dateAfterDay;
}

- (NSDate *)dateAfterMinute:(NSInteger)minute
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get the weekday component of the current date
    // NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    // to get the end of week for a particular date, add (7 - weekday) days
    [componentsToAdd setMinute:minute];
    
    NSDate *dateAfterminute = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    
    return dateAfterminute;
}
//month个月后的日期
- (NSDate *)dateByAppendingMonths:(NSInteger)month
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateByAppendingMonths = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    
    return dateByAppendingMonths;
}
//获取日
- (NSUInteger)getDay{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:self];
    return [dayComponents day];
}
//获取月
- (NSUInteger)getMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents * dayComponents = [calendar components:(NSMonthCalendarUnit) fromDate:self];
    return [dayComponents month];
}
//获取年
- (NSUInteger)getYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:self];
    return [dayComponents year];
}
//获取小时
- (NSInteger)getHour {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit|NSMinuteCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    return [components hour];
}
//获取分钟
- (NSInteger)getMinute {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit|NSMinuteCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    return [components minute];
}

- (NSInteger)getHour:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit|NSMinuteCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    return [components hour];
}
- (NSInteger)getMinute:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit|NSMinuteCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    return [components minute];
}

//在当前日期前几天
- (NSUInteger)daysAgo {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                               fromDate:self
                                                 toDate:[NSDate date]
                                                options:0];
    return [components day];
}
//午夜时间距今几天
- (NSUInteger)daysAgoAgainstMidnight {
    // get a midnight version of ourself:
    NSDateFormatter *mdf = [[NSDateFormatter alloc] init];
    [mdf setDateFormat:@"yyyy-MM-dd"];
    NSDate *midnight = [mdf dateFromString:[mdf stringFromDate:self]];
    
    return [midnight timeIntervalSinceNow] / (60*60*24) *-1;
}

- (NSString *)stringDaysAgo
{
    return [self stringDaysAgoAgainstMidnight:YES];
}

- (NSString *)stringDaysAgoAgainstMidnight:(BOOL)flag {
    NSUInteger daysAgo = (flag) ? [self daysAgoAgainstMidnight] : [self daysAgo];
    NSString *text = nil;
    switch (daysAgo) {
        case 0:
            text = @"Today";
            break;
        case 1:
            text = @"Yesterday";
            break;
        default:
            text = [NSString stringWithFormat:@"%@ days ago", @(daysAgo)];
    }
    return text;
}

//返回一周的第几天(周末为第一天)
- (NSUInteger)weekday{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *weekdayComponents = [calendar components:(NSWeekdayCalendarUnit) fromDate:self];
    return [weekdayComponents weekday];
}
//转为NSString类型的
+ (NSDate *)dateFromString:(NSString *)string {
    return [NSDate dateFromString:string withFormat:[NSDate dbFormatString]];
}

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    NSDate *date = [inputFormatter dateFromString:string];
    return date;
}

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format {
    return [date stringWithFormat:format];
}

+ (NSString *)stringFromDate:(NSDate *)date {
    return [date string];
}

+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed {
    /*
     * if the date is in today, display 12-hour time with meridian,
     * if it is within the last 7 days, display weekday name (Friday)
     * if within the calendar year, display as Jan 23
     * else display as Nov 11, 2008
     */
    
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *offsetComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit)
                                                     fromDate:today];
    
    NSDate *midnight = [calendar dateFromComponents:offsetComponents];
    
    NSDateFormatter *displayFormatter = [[NSDateFormatter alloc] init];
    NSString *displayString = nil;
    
    // comparing against midnight
    if ([date compare:midnight] == NSOrderedDescending) {
        if (prefixed) {
            [displayFormatter setDateFormat:@"'at' h:mm a"]; // at 11:30 am
        } else {
            [displayFormatter setDateFormat:@"h:mm a"]; // 11:30 am
        }
    } else {
        // check if date is within last 7 days
        NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
        [componentsToSubtract setDay:-7];
        NSDate *lastweek = [calendar dateByAddingComponents:componentsToSubtract toDate:today options:0];
        if ([date compare:lastweek] == NSOrderedDescending) {
            [displayFormatter setDateFormat:@"EEEE"]; // Tuesday
        } else {
            // check if same calendar year
            NSInteger thisYear = [offsetComponents year];
            
            NSDateComponents *dateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit)
                                                           fromDate:date];
            NSInteger thatYear = [dateComponents year];
            if (thatYear >= thisYear) {
                [displayFormatter setDateFormat:@"MMM d"];
            } else {
                [displayFormatter setDateFormat:@"MMM d, yyyy"];
            }
        }
        if (prefixed) {
            NSString *dateFormat = [displayFormatter dateFormat];
            NSString *prefix = @"'on' ";
            [displayFormatter setDateFormat:[prefix stringByAppendingString:dateFormat]];
        }
    }
    
    // use display formatter to return formatted date string
    displayString = [displayFormatter stringFromDate:date];
    return displayString;
}

+ (NSString *)stringForDisplayFromDate:(NSDate *)date {
    return [self stringForDisplayFromDate:date prefixed:NO];
}

- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    NSString *timestamp_str = [outputFormatter stringFromDate:self];
    return timestamp_str;
}

- (NSString *)string {
    return [self stringWithFormat:[NSDate dbFormatString]];
}

- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateStyle:dateStyle];
    [outputFormatter setTimeStyle:timeStyle];
    NSString *outputString = [outputFormatter stringFromDate:self];
    return outputString;
}
//返回周日的的开始时间
- (NSDate *)beginningOfWeek {
    // largely borrowed from "Date and Time Programming Guide for Cocoa"
    // we'll use the default calendar and hope for the best
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *beginningOfWeek = nil;
    BOOL ok = [calendar rangeOfUnit:NSWeekCalendarUnit startDate:&beginningOfWeek
                           interval:NULL forDate:self];
    if (ok) {
        return beginningOfWeek;
    }
    
    // couldn't calc via range, so try to grab Sunday, assuming gregorian style
    // Get the weekday component of the current date
    NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    
    /*
     Create a date components to represent the number of days to subtract from the current date.
     The weekday value for Sunday in the Gregorian calendar is 1, so subtract 1 from the number of days to subtract from the date in question.  (If today's Sunday, subtract 0 days.)
     */
    NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
    [componentsToSubtract setDay: 0 - ([weekdayComponents weekday] - 1)];
    beginningOfWeek = nil;
    beginningOfWeek = [calendar dateByAddingComponents:componentsToSubtract toDate:self options:0];
    
    //normalize to midnight, extract the year, month, and day components and create a new date from those components.
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit)
                                               fromDate:beginningOfWeek];
    return [calendar dateFromComponents:components];
}
//返回当前天的年月日.
- (NSDate *)beginningOfDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get the weekday component of the current date
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit)
                                               fromDate:self];
    return [calendar dateFromComponents:components];
}
//返回该月的第一天
- (NSDate *)beginningOfMonth
{
    return [self dateAfterDay:-[self getDay] + 1];
}
//该月的最后一天
- (NSDate *)endOfMonth
{
    return [[[self beginningOfMonth] dateByAppendingMonths:1] dateAfterDay:-1];
}

//返回当前周的周末
- (NSDate *)endOfWeek {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get the weekday component of the current date
    NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    // to get the end of week for a particular date, add (7 - weekday) days
    [componentsToAdd setDay:(7 - [weekdayComponents weekday])];
    NSDate *endOfWeek = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    
    return endOfWeek;
}

+ (NSString *)dateFormatString {
    return @"yyyy-MM-dd";
}

+ (NSString *)timeFormatString {
    return @"HH:mm:ss";
}

+ (NSString *)timestampFormatString {
    return @"yyyy-MM-dd HH:mm:ss";
}

// preserving for compatibility
+ (NSString *)dbFormatString {
    return [NSDate timestampFormatString];
}

- (NSString *)getChinaWeekName{
    NSString *chineseName;
    switch ([self weekday]) {
        case 1:{
            chineseName = @"周日";
        }
            break;
        case 2:{
            chineseName = @"周一";
        }
            break;
        case 3:{
            chineseName = @"周二";
        }
            break;
        case 4:{
            chineseName = @"周三";
        }
            break;
        case 5:{
            chineseName = @"周四";
        }
            break;
        case 6:{
            chineseName = @"周五";
        }
            break;
        case 7:{
            chineseName = @"周六";
        }
            break;
        default:
            break;
    }
    return chineseName;
}

- (NSString *)getChinaWeekName2 {
    NSString *chineseName;
    switch ([self weekday]) {
        case 1:{
            chineseName = @"星期天";
        }
            break;
        case 2:{
            chineseName = @"星期一";
        }
            break;
        case 3:{
            chineseName = @"星期二";
        }
            break;
        case 4:{
            chineseName = @"星期三";
        }
            break;
        case 5:{
            chineseName = @"星期四";
        }
            break;
        case 6:{
            chineseName = @"星期五";
        }
            break;
        case 7:{
            chineseName = @"星期六";
        }
            break;
        default:
            break;
    }
    return chineseName;
}

- (NSInteger)yearAfterNumWithAnotherDate:(NSDate *)anotherDate
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = NSCalendarUnitYear;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:self toDate:anotherDate options:0];
    NSInteger year = [comps year];
    return year;
}

- (NSInteger)dayAfterNumWithAnotherDate:(NSDate *)anotherDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = [NSDate dateFormatString];
    NSString *startDateStr = [dateFormatter stringFromDate:self];
    NSString *endDateStr = [dateFormatter stringFromDate:anotherDate];
    
    startDateStr = [startDateStr stringByAppendingString:@" 23:00:00"];
    endDateStr = [endDateStr stringByAppendingString:@" 23:00:00"];
    
    dateFormatter.dateFormat = [NSDate dbFormatString];
    
    NSDate *startDate = [dateFormatter dateFromString:startDateStr];
    NSDate *endDate = [dateFormatter dateFromString:endDateStr];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = NSDayCalendarUnit;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:startDate toDate:endDate options:0];
    return [comps day];
}

- (NSInteger)minutesAfterNumWithAnotherDate:(NSDate *)anotherDate
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = NSMinuteCalendarUnit;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:self toDate:anotherDate options:0];
    return [comps minute];
}

- (NSInteger)secondAfterNumWithAnotherDate:(NSDate *)anotherDate
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = NSCalendarUnitSecond;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:self toDate:anotherDate options:0];
    return [comps second];
}

- (NSInteger)timeAfterNumType:(NSCalendarUnit)unitFlags timestamp:(NSString *)timestamp
{
    if (timestamp.length >= 10) {
        NSDate * date = [NSDate dateWithTimeIntervalSince1970:[[timestamp substringToIndex:10] longLongValue]];
        
        NSCalendar * gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents * comps = [gregorian components:unitFlags fromDate:date toDate:self options:0];
        
        if (unitFlags == NSCalendarUnitYear)
            return [comps year];
        else if (unitFlags == NSCalendarUnitMonth)
            return [comps month];
        else if (unitFlags == NSCalendarUnitDay)
            return [comps day];
        else if (unitFlags == NSCalendarUnitHour)
            return [comps hour];
        else if (unitFlags == NSCalendarUnitMinute)
            return [comps minute];
        else if (NSCalendarUnitSecond)
            return [comps second];
        else
            return 0;
    } else
        return 0;
}

- (NSInteger)minutesAfterNumWithTimestamp:(NSString *)timestamp
{
    return [self timeAfterNumType:NSCalendarUnitMinute timestamp:timestamp];
}

- (NSString *)getDateValue:(NSString *)aStr andFormatter:(NSString *)formatterStr
{
    if ([aStr isKindOfClass:[NSDate class]])
        return nil;
    
    @try {
        NSString *timestamp;
        if ([aStr isKindOfClass:[NSDate class]])
            timestamp = [NSString stringWithFormat:@"%ld", (long)[(NSDate *)aStr timeIntervalSince1970]];
        else
            timestamp = aStr;
        
        if (timestamp.length >= 10) {
            NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
            [dateformatter setDateFormat:formatterStr];
            
            NSString *dateStr = [timestamp substringFromIndex:0];
            //获取数字的位数，一般情况下像1394765482125的数字，后三个是代表毫秒的，所以我们去掉后三个
            NSString * tempStr = [dateStr substringToIndex:10];
            NSDate * dd = [NSDate dateWithTimeIntervalSince1970:[tempStr longLongValue]];
            NSString *dateString = [dateformatter stringFromDate:dd];
            
            return dateString;
        } else{
            NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
            [dateformatter setDateFormat:formatterStr];
            
            NSString *dateStr = [timestamp substringFromIndex:0];
            //获取数字的位数，一般情况下像1394765482125的数字，后三个是代表毫秒的，所以我们去掉后三个
            NSString * tempStr = [dateStr substringToIndex:timestamp.length];
            NSDate * dd = [NSDate dateWithTimeIntervalSince1970:[tempStr longLongValue]];
            NSString *dateString = [dateformatter stringFromDate:dd];
            return dateString;
        }
        
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
        
    }
}

- (NSString *)getMeetTimeWithTimestamp:(NSString *)timestamp
{
    return [self getDateValue:timestamp andFormatter:@"HH:mm"];
}

- (NSString *)getTimeWithValue:(NSString *)timestamp
{
    if ([self getYear] != [[self getDateValue:timestamp andFormatter:@"yyyy"] integerValue])
        return [self getDateValue:timestamp andFormatter:@"yyyy年MM月dd日"];
    if ([self month] != [[self getDateValue:timestamp andFormatter:@"MM"] integerValue])
        return [self getDateValue:timestamp andFormatter:@"MM-dd HH:mm"];
    else if ([self getDay] != [[self getDateValue:timestamp andFormatter:@"dd"] integerValue])
        return [self getDateValue:timestamp andFormatter:@"MM-dd HH:mm"];
    else
        return [self getDateValue:timestamp andFormatter:@"HH:mm:ss"];
}

// 蜜约 -----> 朋友---> 来访时间
- (NSString *)getTimeWithTimestamp:(NSString *)timestamp
{
    if ([self getYear] != [[self getDateValue:timestamp andFormatter:@"yyyy"] integerValue])
        return [self getDateValue:timestamp andFormatter:@"yyyy年MM月dd日HH:mm"];
    else if ([self month] != [[self getDateValue:timestamp andFormatter:@"MM"] integerValue])
        return [self getDateValue:timestamp andFormatter:@"MM月dd日HH:mm"];
    else if ([self getDay] != [[self getDateValue:timestamp andFormatter:@"dd"] integerValue]) {
        if ([self day] - [[self getDateValue:timestamp andFormatter:@"dd"] integerValue] == 1)
            return [self getDateValue:timestamp andFormatter:@"昨天HH:mm"];
        else
            return [self getDateValue:timestamp andFormatter:@"MM月dd日HH:mm"];
    } else
        return [self getDateValue:timestamp andFormatter:@"今天HH:mm"];
}

// 动态 -----> 发布动态时间
- (NSString *)getDynamicPublishTimeWithTimestamp:(NSString *)timestamp
{
    NSInteger minutes = [[NSDate date] minutesAfterNumWithTimestamp:timestamp];
    if (minutes < 0)
        minutes = 0;
    
    if (minutes >= 60 * 24)
        return [NSString stringWithFormat:@"%@天前", @(minutes / (24 * 60))];
    else if (minutes >= 60)
        return [NSString stringWithFormat:@"%@小时前", @(minutes / 60)];
    else if (minutes >= 1)
        return [NSString stringWithFormat:@"%@分钟前", @(minutes)];
    else
        return @"刚刚";
}

- (NSString *)getMessageTimeWithTimestamp:(NSString *)timestamp
{
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[[timestamp substringToIndex:10] longLongValue]];
    
    if ([self year] != [date year])
        return [date toString:@"yyyy-MM-dd"];
    else if ([self month] != [date month])
        return [date toString:@"MM-dd"];
    else if (([self day] - [date day] > 2))
        return [date toString:@"MM-dd"];
    else if (([self day] - [date day] == 2))
        return @"前天";
    else if (([self day] - [date day] == 1))
        return @"昨天";
    else
        return [date toString:@"HH:mm"];
}

//NSDate (Action)

- (NSString *)toShortDateString{
    return [self toString:@"yyyy-MM-dd"];
}

- (NSString *)toLongDateString{
    return [self toString:@"yyyy-MM-dd HH:mm:ss"];
}

- (NSString *)toString{
    return [self toLongDateString];
}

- (NSString *)toFileNameString{
    return [self toString:@"yyyyMMddHHmmss"];
}

- (NSString *)toHourMinString
{
    return [self toString:@"HH:mm"];
}

- (NSString *)toString:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *currentDateStr = [dateFormatter stringFromDate:self];
    //[dateFormatter dateFromString:<#(NSString *)#>];
    //[dateFormatter release];
    return currentDateStr;
    
}

- (NSString *)dateToYearMounthDay:(NSDate *)date
{
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"YYYY-MM-dd"];
    return [df stringFromDate:date];
}

- (NSDate *)stringToDate:(NSString *)string
{
    NSDateFormatter * st = [[NSDateFormatter alloc] init];
    [st setDateFormat:@"HH:mm"];
    return [st dateFromString:string];
    
}

- (NSDate *)stringToDateYearMd:(NSString *)string
{
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"YYYYMMddHHmmss"];
    return [df dateFromString:string];
}

- (BOOL)compareDate:(NSDate *)date
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:[NSDate date]];
    NSDate *todayDate = [cal dateFromComponents:components];
    components = [cal components:(NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:date];
    NSDate *otherDate = [cal dateFromComponents:components];
    if ([todayDate isEqualToDate:otherDate])
        return YES;
    
    NSDate * today = [NSDate date];
    NSDate * yesterday = [NSDate dateWithTimeIntervalSinceNow:-86400];
    NSDate * refDate = date;
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString * refDateString = [[refDate description] substringToIndex:10];
    
    if ([refDateString isEqualToString:todayString])
        return YES;
    else if ([refDateString isEqualToString:yesterdayString])
        return NO;
    else
        return NO;
}
- (NSString *)getOtherDay:(NSInteger)days{
    NSDate *nowDate = [NSDate date];
    NSDate *theDate;
    if (days!=0) {
        NSTimeInterval oneDay = 24*60*60*1;
        if (days>0) {
            theDate = [nowDate initWithTimeIntervalSinceNow:+oneDay*days];
        }else{
            theDate = [nowDate initWithTimeIntervalSinceNow:-oneDay*days];
        }
    }else{
        theDate = nowDate;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateString = [formatter stringFromDate:theDate];
    return dateString;
}
- (NSString *)getTimeFromSecound:(NSString *)secound{
    NSInteger secoundI = [secound integerValue];
    int hours = (int)(secoundI / 3600);
    int minutes = (int)(secoundI - hours*3600)/60;
    int seconds = (int)(secoundI-minutes*60-hours*3600);
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
}
@end
