//
//  DAPosIO.m
//  DiandianIOS
//
//  Created by Antony on 14-1-23.
//  Copyright (c) 2014年 DAC. All rights reserved.
//

#import "DAPosIO.h"

@implementation DAPosIO


+ (DAPosIO *)sharedClient:(id<DAPosIODelegate>)delegate{
    
    static DAPosIO *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[DAPosIO alloc] initWithDelegate:delegate];
        
    });
    
    return _sharedClient;
}

- (id) initWithDelegate:(id<DAPosIODelegate>)delegate
{
    self = [super init];
    if (self) {
        _delegate = delegate;
    }
    return self;
}

//called OpenView
- (void)onOpenPrinter:(EposPrint*)prn
            ipaddress:(NSString*)ipaddress
          printername:(NSString*)printername
             language:(int)language
{
    if(printer_ != nil){
        [printer_ closePrinter];
    }
    
    
    [printer_ setStatusChangeEventCallback:@selector(onStatusChange:Status:) Target:self];
    [printer_ setBatteryStatusChangeEventCallback:@selector(onBatteryStatusChange:Battery:) Target:self];
    
    
}

- (void)getPrinter:(NSString *)ip
{
    EposPrint *printer = [[EposPrint alloc] init];

    if(printer == nil){
        return;
    }
    int result = [printer openPrinter:EPOS_OC_DEVTYPE_TCP DeviceName:ip Enabled:EPOS_OC_TRUE Interval:EPOS_OC_PARAM_DEFAULT];
    printer_ = printer;
    
}

+(void)printText:(EposPrint *)printer
{
    //create builder
    EposBuilder *builder = [[EposBuilder alloc] initWithPrinterModel:@"TM-T81II" Lang:EPOS_OC_MODEL_CHINESE];
    
    // send builder data
    unsigned long status = 0;
    unsigned long battery = 0;
    int result = [printer sendData:builder Timeout:SEND_TIMEOUT Status:&status Battery:&battery];
}

@end
