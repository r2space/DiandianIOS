//
//  DADateUtil.m
//  PictureBook
//
//  Created by ドリームアーツ on 2012/11/26.
//  Copyright (c) 2012年 ドリームアーツ. All rights reserved.
//

#import "DADateUtil.h"

@implementation DADateUtil

/*------------------------------------------------------------------------------------------------*/
#pragma mark - date format
/*------------------------------------------------------------------------------------------------*/
+ (NSString *)stringFromDate:(NSDate *)date {
    return [self stringFromDate:date withFormat:kDefaultDispDateFormat];
}

+ (NSString *)convertToServerDateFormat:(NSString *)dateString {
    return [self convertDateFormat:dateString from:kDefaultDispDateFormat to:kDefaultSendDateFormat];
}

+ (NSString *)convertToDispDateFormat:(NSString *)dateString {
    return [self convertDateFormat:dateString from:kDefaultSendDateFormat to:kDefaultDispDateFormat];
}

/*------------------------------------------------------------------------------------------------*/
#pragma mark - date time format
/*------------------------------------------------------------------------------------------------*/
+ (NSString *)stringFromDateTime:(NSDate *)date {
    return [self stringFromDate:date withFormat:kDefaultDispDateTimeFormat];
}

+ (NSString *)convertToServerDateTimeFormat:(NSString *)dateTimeString {
    return [self convertDateFormat:dateTimeString from:kDefaultDispDateTimeFormat to:kSendToServerDateTimeFormat];
}

+ (NSString *)convertToDispDateTimeFormat:(NSString *)dateTimeString {
    return [self convertDateFormat:dateTimeString from:kRecieveFromServerDateTimeFormat to:kDefaultDispDateTimeFormat];
}

+ (NSString *)convertToDispDateTimeFormatFromDateTimeWithTimeZone:(NSString *)dateTimeString {
    NSString *result = nil;
    
    NSArray *tokens = [dateTimeString componentsSeparatedByString:@"+"];
    if (0 < tokens.count) {
        result = [self convertDateFormat:[tokens objectAtIndex:0] from:kSendToServerDateTimeFormat to:kDefaultDispDateTimeFormat];
    } else {
        result = [self convertDateFormat:dateTimeString from:kSendToServerDateTimeFormat to:kDefaultDispDateTimeFormat];
    }
    
    return result;
}


/*------------------------------------------------------------------------------------------------*/
#pragma mark - common methods
/*------------------------------------------------------------------------------------------------*/
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = format;
    return [df stringFromDate:date];
}

+ (NSString *)convertDateFormat:(NSString *)dateString from:(NSString *)fromFormat to:(NSString *)toFormat {
    NSDateFormatter *fromFormatter = [[NSDateFormatter alloc] init];
    fromFormatter.dateFormat = fromFormat;
    NSDate *date = [fromFormatter dateFromString:dateString];
    
    NSDateFormatter *toFormatter = [[NSDateFormatter alloc] init];
    toFormatter.dateFormat = toFormat;
    return [toFormatter stringFromDate:date];
}

@end
