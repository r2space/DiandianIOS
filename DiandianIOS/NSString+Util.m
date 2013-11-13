//
//  NSString+Util.m
//  PictureBook
//
//  Created by ドリームアーツ on 2012/11/21.
//  Copyright (c) 2012年 ドリームアーツ. All rights reserved.
//

#import "NSString+Util.h"
#import "NSNumber+Util.h"

@implementation NSString (Util)

+ (NSString *)stringWithValue:(NSNumber *)number {
    return [NSString stringWithFormat:@"%@", number];
}

+ (BOOL)isEmpty:(NSString *)str {
    return (![self isNotEmpty:str]);
}

+ (BOOL)isNotEmpty:(NSString *)str {
    return (str && 0 < str.length);
}

+ (NSString *)commaSeparatedNumber:(NSNumber *)number {
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setGroupingSeparator:@","];
    [formatter setGroupingSize:3];
    
    return [formatter stringFromNumber:number];
}

+ (NSString *)commaSeparatedNumberWith1stDecimalPlace:(NSNumber *)number {
    NSString *num = [NSString stringWithFormat:@"%.1f", [number doubleValue]];
    return [self commaSeparatedNumber:[NSNumber numberWithString:num]];
}

+ (NSString *)commaSeparatedNumberWith2ndDecimalPlace:(NSNumber *)number {
    NSString *num = [NSString stringWithFormat:@"%.2f", [number doubleValue]];
    return [self commaSeparatedNumber:[NSNumber numberWithString:num]];
}

+ (NSString *)stringWithYenKingakuFormat:(NSNumber *)kingaku {
    
    return [NSString stringWithFormat:@"¥%@", [self commaSeparatedNumber:kingaku]];
}

+ (NSString *)fileSizeFromNumberString:(NSString *)fileSize {
    
    NSDecimalNumber *KILO = [NSDecimalNumber decimalNumberWithString:@"1000"];
    NSDecimalNumber *MEGA = [NSDecimalNumber decimalNumberWithString:@"1000000"];
    NSDecimalNumber *GIGA = [NSDecimalNumber decimalNumberWithString:@"1000000000"];
    
    NSDecimalNumber *size = [NSDecimalNumber decimalNumberWithString:fileSize];

    NSString *result = nil;
    
    if (NSOrderedDescending != [GIGA compare:size]) {
        // GIGA <= size
        NSDecimalNumber *num = [size decimalNumberByDividingBy:GIGA];
        result = [NSString stringWithFormat:@"%@GB", [self commaSeparatedNumberWith1stDecimalPlace:num]];
        
    } else if (NSOrderedDescending != [MEGA compare:size]) {
        // MEGA <= size
        NSDecimalNumber *num = [size decimalNumberByDividingBy:MEGA];
        result = [NSString stringWithFormat:@"%@MB", [self commaSeparatedNumberWith1stDecimalPlace:num]];
        
    } else if (NSOrderedDescending != [KILO compare:size]) {
        // KILO <= size
        NSDecimalNumber *num = [size decimalNumberByDividingBy:KILO];
        result = [NSString stringWithFormat:@"%@KB", [self commaSeparatedNumberWith1stDecimalPlace:num]];
    } else {
        result = [NSString stringWithFormat:@"%@B", [self commaSeparatedNumberWith1stDecimalPlace:size]];
    }
    
    return result;
}

+ (NSString *)trimNonNumbersFromString:(NSString *)string {
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\d\\.-]"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    return [regex stringByReplacingMatchesInString:string
                                           options:0
                                             range:NSMakeRange(0, [string length])
                                      withTemplate:@""];
}

@end
