//
//  DAPosIO.h
//  DiandianIOS
//
//  Created by Antony on 14-1-23.
//  Copyright (c) 2014年 DAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ePOS-Print.h"
#define SEND_TIMEOUT    30 * 1000
@class DAPosIO;



@protocol DAPosIODelegate <NSObject>
@optional
- (void) posIODidConnect:(DAPosIO *)pos;
- (void)onOpenPrinter:(EposPrint*)prn
            ipaddress:(NSString*)ipaddress
          printername:(NSString*)printername
             language:(int)language;

@end

@interface DAPosIO : NSObject<DAPosIODelegate>
{
    __unsafe_unretained id<DAPosIODelegate> _delegate;
    EposPrint *printer_;
}


@end
