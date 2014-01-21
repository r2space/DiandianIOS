//
//  Tool.m
//  DiandianIOS
//
//  Created by Antony on 13-11-26.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "Tool.h"

@implementation Tool


+ (NSString *) stringWithPad:(NSString *)str length:(int )length
{
    
    int add = length -[str length];
    if (add > 0) {
        NSString *pad = [[NSString string] stringByPaddingToLength:add*2 withString:@" " startingAtIndex:0];
        str = [str stringByAppendingString:pad];
    }
    return str;
}
// ---- 日期相关 ----
+ (NSDate *) dateFromISODateString:(NSString *)isodate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.zzz'Z'"];
    return [dateFormatter dateFromString:isodate];
}


+ (NSString *) stringFromISODateForBill:(NSDate *)isodate
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [format stringFromDate:isodate];
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

/**
 * 计算指定时间与当前的时间差
 * @param compareDate   某一指定时间
 * @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
 */
+(NSString *) compareCurrentTime:(NSString*) compareDate
//
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.zzz'Z'"];
   
    
    NSTimeInterval  timeInterval = [[dateFormatter dateFromString:compareDate] timeIntervalSinceNow];
    timeInterval = -timeInterval;
    int temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%d分",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%d小时",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%d天",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%d月",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%d年",temp];
    }
    
    return  result;
}


@end
