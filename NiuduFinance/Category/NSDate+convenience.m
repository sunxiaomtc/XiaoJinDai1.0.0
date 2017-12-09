//
//  NSDate+convenience.m
//
//  Created by chicp on 13-12-16.
//  Copyright (c) 2013年 KK.net All rights reserved.
//

#import "NSDate+convenience.h"

@implementation NSDate (Convenience)

- (NSDate *)dateByAppendingYears:(NSInteger)years
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    //[gregorian setFirstWeekday:1]; //monday is first day
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:years];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:self options:0];
}

- (NSDate *)dateByAppendingMonths:(NSInteger)months
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    //[gregorian setFirstWeekday:1]; //monday is first day
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:months];

    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:self options:0];
}

- (NSDate *)dateByAppendingDays:(NSInteger)days
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    //[gregorian setFirstWeekday:1]; //sunday is first day
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:days];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:self options:0];
}

- (NSDate *)dateByAppendingHours:(NSInteger)hours
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    //[gregorian setFirstWeekday:1]; //sunday is first day
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:hours];
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:self options:0];
}

- (NSDate *)dateByAppendingMinutes:(NSInteger)minutes
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    //[gregorian setFirstWeekday:1]; //sunday is first day
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMinute:minutes];
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:self options:0];
}

- (NSInteger)numberOfDaysOfMonth
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSRange range = [gregorian rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self];
    NSUInteger numberOfDaysOfMonth = range.length;
    return numberOfDaysOfMonth;
}

//返回day天后的日期(若day为负数,则为|day|天前的日期)
- (NSString *)dateAfterDayForCanlendar:(NSInteger)day;
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get the weekday component of the current date
    // NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    // to get the end of week for a particular date, add (7 - weekday) days
    [componentsToAdd setDay:day];
    NSDate * dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"YYYY-MM-dd"];
    
    return [df stringFromDate:dateAfterDay];
}


- (NSString *)getDateWithTypeString:(NSString *)string
{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:string];
    return [format stringFromDate:self];
}

- (NSString *)hourAndMinutes
{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"HH:mm"];
    return [format stringFromDate:self];
}

- (NSString *)yearAndMonthAndDay
{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    return [format stringFromDate:self];
}

- (NSString *)yearAndMonth
{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy年MM月"];
    return [format stringFromDate:self];
}

- (NSString *)monthAndDay
{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM月dd日"];
    NSString *dateStr = [format stringFromDate:self];
    NSString *weekdayStr = [self getChinaWeekName];
    return [NSString stringWithFormat:@"%@ %@",dateStr, weekdayStr];
}

- (NSString *)getChinaWeekName {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *weekdayComponents = [calendar components:(NSWeekdayCalendarUnit) fromDate:self];
    NSInteger weekday = [weekdayComponents weekday];
    NSString *chineseName;
    switch (weekday) {
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

- (NSDate *)newDateWithYear:(NSInteger)year month:(NSInteger)month
{
    NSDateComponents *comp = [[NSDateComponents alloc]init];
    [comp setMonth:month];
    [comp setYear:year];
    [comp setHour:8];
    NSCalendar *myCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return [myCal dateFromComponents:comp];
}

- (NSDate *)newDateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSDateComponents *comp = [[NSDateComponents alloc]init];
    [comp setYear:year];
    [comp setMonth:month];
    [comp setDay:day];
    [comp setHour:8];
    NSCalendar *myCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return [myCal dateFromComponents:comp];
}

- (NSDate *)newDateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minutes:(NSInteger)minutes
{
    NSDateComponents *comp = [[NSDateComponents alloc]init];
    if (year > 0)
        [comp setYear:year];
    if (month > 0)
        [comp setMonth:month];
    if (day > 0)
        [comp setDay:day];
    if (hour > 0)
        [comp setHour:hour];
    [comp setMinute:minutes];
    NSCalendar *myCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return [myCal dateFromComponents:comp];
}

- (NSDate *)lastMonth
{
    NSInteger year = [self year];
    NSInteger month = [self month];
    if (month == 1) {
        year--;
        month = 12;
    } else {
        month--;
    }
    return [self newDateWithYear:year month:month];
}

- (NSDate *)nextMonth
{
    NSInteger year = [self year];
    NSInteger month = [self month];
    if (month == 12) {
        year++;
        month = 1;
    } else {
        month++;
    }
    return [self newDateWithYear:year month:month];
}

- (NSInteger)weekdayInFirstDayOfMonth
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setFirstWeekday:1]; //sun is first day
    //[gregorian setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"nl_NL"]];
    
    //Set date to first of month
    NSDateComponents *comps = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit fromDate:self];
    [comps setDay:1];
    NSDate *newDate = [gregorian dateFromComponents:comps];
    
    return [gregorian ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSWeekCalendarUnit forDate:newDate];
}

- (NSInteger)year
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSYearCalendarUnit fromDate:self];
    return [components year];
}


- (NSInteger)month
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSMonthCalendarUnit fromDate:self];
    return [components month];
}

- (NSInteger)day
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSDayCalendarUnit fromDate:self];
    return [components day];
}

- (NSInteger)hour
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSHourCalendarUnit fromDate:self];
    return [components hour];
}

- (NSInteger)minute
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSMinuteCalendarUnit fromDate:self];
    return [components minute];
}

- (NSInteger)second
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSSecondCalendarUnit fromDate:self];
    return [components second];
}

- (NSInteger)monthsBetweenDate:(NSDate *)anotherDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM";
    NSString *startDateStr = [dateFormatter stringFromDate:self];
    NSString *endDateStr = [dateFormatter stringFromDate:anotherDate];
    
    NSDate *startDate = [dateFormatter dateFromString:startDateStr];
    NSDate *endDate = [dateFormatter dateFromString:endDateStr];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = NSMonthCalendarUnit;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:startDate toDate:endDate options:0];
    return [comps month];
}

- (NSInteger)daysBetweenDate:(NSDate *)anotherDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *startDateStr = [dateFormatter stringFromDate:self];
    NSString *endDateStr = [dateFormatter stringFromDate:anotherDate];

    NSDate *startDate = [dateFormatter dateFromString:startDateStr];
    NSDate *endDate = [dateFormatter dateFromString:endDateStr];

    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = NSDayCalendarUnit;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:startDate toDate:endDate options:0];
    NSInteger days = [comps day];
    return days;
}

- (NSInteger)minutesBetweenDate:(NSDate *)anotherDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *startDateStr = [dateFormatter stringFromDate:self];
    NSString *endDateStr = [dateFormatter stringFromDate:anotherDate];
    
    NSDate *startDate = [dateFormatter dateFromString:startDateStr];
    NSDate *endDate = [dateFormatter dateFromString:endDateStr];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = NSMinuteCalendarUnit;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:startDate toDate:endDate options:0];
    NSInteger minutes = [comps minute];
    return minutes;
}

- (NSDate *)nearestFirstWeekdayOfDate
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setFirstWeekday:1]; //sun is first day
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:self];
    
    NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
    
    [componentsToSubtract setDay: - ((([components weekday] - [gregorian firstWeekday])
                                      + 7 ) % 7)];
    NSDate *beginningOfWeek = [gregorian dateByAddingComponents:componentsToSubtract toDate:self options:0];
    
    NSDateComponents *componentsStripped = [gregorian components: (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                        fromDate: beginningOfWeek];
    
    //gestript
    beginningOfWeek = [gregorian dateFromComponents: componentsStripped];
    
    return beginningOfWeek;
}

- (NSDate *)dateOfStartOfMonth
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:self];
    [components setDay:1];
    
    return [gregorian dateFromComponents:components];
}

- (NSDate *)dateOfEndOfMonth
{
    NSInteger numberOfDays = [self numberOfDaysOfMonth];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:self];
    [components setDay:numberOfDays];
    
    return [gregorian dateFromComponents:components];
}

- (NSDate *)dateOfStartOfWeek
{
    NSDate *date = [self nearestFirstWeekdayOfDate];
    
    return [date dateOfStartOfDay];
}

- (NSDate *)dateOfEndOfWeek
{
    NSDate *date = [self nearestFirstWeekdayOfDate];
    NSDate *endWeekDate = [date dateByAppendingDays:6];
    
    return [endWeekDate dateOfEndOfDay];
}

- (NSDate *)dateOfStartOfDay
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:self];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    dateStr = [dateStr stringByAppendingString:@" 00:00:00.000"];
    
    return [formatter dateFromString:dateStr];
}

- (NSDate *)dateOfEndOfDay
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:self];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    dateStr = [dateStr stringByAppendingString:@" 23:59:59.999"];
    
    return [formatter dateFromString:dateStr];
}

@end
