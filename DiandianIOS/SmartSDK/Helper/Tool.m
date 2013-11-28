//
//  Tool.m
//  DiandianIOS
//
//  Created by Antony on 13-11-26.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "Tool.h"

@implementation Tool



// ---- 日期相关 ----
+ (NSDate *) dateFromISODateString:(NSString *)isodate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.zzz'Z'"];
    return [dateFormatter dateFromString:isodate];
}


+ (NSString *) stringFromISODate:(NSDate *)isodate
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"HH:mm"];
    return [format stringFromDate:isodate];
}

+ (NSString *) stringFromISODateString:(NSString *)isodate
{
    NSDate *date = [Tool dateFromISODateString:isodate];
    return [Tool stringFromISODate:date];
}

+ (NSString *) currentDateString
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [format stringFromDate:[NSDate date]];
}



@end
