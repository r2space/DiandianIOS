//
//  DADateUtil.h
//  PictureBook
//
//  Created by ドリームアーツ on 2012/11/26.
//  Copyright (c) 2012年 ドリームアーツ. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kDefaultDispDateFormat  @"yyyy/MM/dd"
#define kDefaultSendDateFormat  @"yyyy-MM-dd"
#define kYYYYMMDDDateFormat     @"yyyyMMdd"

#define kDefaultDispDateTimeFormat          @"yyyy/MM/dd HH:mm"
#define kSendToServerDateTimeFormat         @"yyyy-MM-dd'T'HH:mm:ss"
#define kRecieveFromServerDateTimeFormat    @"yyyy-MM-dd HH:mm"

@interface DADateUtil : NSObject

// date format
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)convertToServerDateFormat:(NSString *)dateString;
+ (NSString *)convertToDispDateFormat:(NSString *)dateString;

// date time format
+ (NSString *)stringFromDateTime:(NSDate *)date;
+ (NSString *)convertToServerDateTimeFormat:(NSString *)dateTimeString;
+ (NSString *)convertToDispDateTimeFormat:(NSString *)dateTimeString;
+ (NSString *)convertToDispDateTimeFormatFromDateTimeWithTimeZone:(NSString *)dateTimeString;

// common methods
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format;
+ (NSString *)convertDateFormat:(NSString *)dateString from:(NSString *)fromFormat to:(NSString *)toFormat;

@end
