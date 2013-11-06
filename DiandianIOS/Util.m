//
//  Util.m
//  DiandianIOS
//
//  Created by Antony on 13-11-6.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "Util.h"

@implementation Util


+ (UIColor *) colorWithHexString: (NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [Util colorComponentFrom: colorString start: 0 length: 1];
            green = [Util colorComponentFrom: colorString start: 1 length: 1];
            blue  = [Util colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [Util colorComponentFrom: colorString start: 0 length: 1];
            red   = [Util colorComponentFrom: colorString start: 1 length: 1];
            green = [Util colorComponentFrom: colorString start: 2 length: 1];
            blue  = [Util colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [Util colorComponentFrom: colorString start: 0 length: 2];
            green = [Util colorComponentFrom: colorString start: 2 length: 2];
            blue  = [Util colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [Util colorComponentFrom: colorString start: 0 length: 2];
            red   = [Util colorComponentFrom: colorString start: 2 length: 2];
            green = [Util colorComponentFrom: colorString start: 4 length: 2];
            blue  = [Util colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

@end
