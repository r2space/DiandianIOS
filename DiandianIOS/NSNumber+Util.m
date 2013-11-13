//
//  NSNumber+Util.m
//  PictureBook
//
//  Created by ドリームアーツ on 2012/11/28.
//  Copyright (c) 2012年 ドリームアーツ. All rights reserved.
//

#import "NSNumber+Util.h"

@implementation NSNumber (Util)

+ (NSNumber *)numberWithString:(NSString *)stringValue {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    return [formatter numberFromString:stringValue];
}

@end
