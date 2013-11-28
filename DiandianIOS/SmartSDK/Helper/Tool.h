//
//  Tool.h
//  DiandianIOS
//
//  Created by Antony on 13-11-26.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tool : NSObject


+ (NSDate *) dateFromISODateString:(NSString *)isodate;
+ (NSString *) stringFromISODateString:(NSString *)isodate;

@end
