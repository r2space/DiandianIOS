//
//  DAPrintProxy.h
//  DiandianIOS
//
//  Created by Antony on 13-11-29.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ePOS-Print.h"

@interface DAPrintProxy : NSObject
{
    EposPrint *printer_;
    NSString* printername_;
    int language_;
    
    
}
- (id)initWithPrinter:(EposPrint*)printer
          printername:(NSString*)printername
             language:(int)language;

@end
