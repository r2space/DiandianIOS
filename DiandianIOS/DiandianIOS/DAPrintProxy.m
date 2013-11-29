//
//  DAPrintProxy.m
//  DiandianIOS
//
//  Created by Antony on 13-11-29.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAPrintProxy.h"

@implementation DAPrintProxy


- (id)initWithPrinter:(EposPrint*)printer
          printername:(NSString*)printername
             language:(int)language
{
    self = [super init];
    if (self) {
        printer_ = printer ;
        printername_ = printername ;
        language_ = language;
        
    }
    return self;
}

@end
