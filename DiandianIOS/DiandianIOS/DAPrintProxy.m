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

-(void)openPrinter
{
    //open
    EposPrint *_printer = [[EposPrint alloc] init];
    if(_printer == nil){
        return ;
    }
    int result = [_printer openPrinter:EPOS_OC_DEVTYPE_TCP DeviceName:@"10.2.3.149" Enabled:[self getStatusMonitorEnabled] Interval:[self getInterval]];
    if(result != EPOS_OC_SUCCESS){
        
        return;
    }
    printer_ = _printer;
    
    [printer_ setStatusChangeEventCallback:@selector(onStatusChange:Status:) Target:self];
    [printer_ setBatteryStatusChangeEventCallback:@selector(onBatteryStatusChange:Battery:) Target:self];
    
}
- (void)onStatusChange:(NSString *)deviceName Status:(NSNumber *)status
{
    NSLog(@"onStatusChange deviceName%@",deviceName);
    NSLog(@"onStatusChange status%@",status);
}

- (void)onBatteryStatusChange:(NSString *)deviceName Battery:(NSNumber *)battery
{
    NSLog(@"onBatteryStatusChange deviceName%@",deviceName);
    NSLog(@"onBatteryStatusChange status%@",battery);
}

- (long)getInterval
{
    return 1000;
}
- (int)getStatusMonitorEnabled
{
//    if(switchStatusMonitor_.on){
        return EPOS_OC_TRUE;
//    }else{
//        return EPOS_OC_FALSE;
//    }
}

- (void)printText
{
    if(textData_.length == 0){
        NSLog(@"errmsg_notext");
        return ;
    }
    
    
    //create builder
    EposBuilder *builder = [[EposBuilder alloc] initWithPrinterModel:printername_ Lang:EPOS_OC_MODEL_CHINESE];
    if(builder == nil){
        return ;
    }
    
    //add command
    int result = [builder addTextFont:[self getBuilderFont]];
    if(result != EPOS_OC_SUCCESS){
        NSLog(@"ddTextFont");
        return ;
    }
    
    result = [builder addTextAlign:[self getBuilderAlign]];
    if(result != EPOS_OC_SUCCESS){
        NSLog(@"addTextAlign");
        return ;
    }
    
    result = [builder addTextLineSpace:[self getBuilderLineSpace]];
    if(result != EPOS_OC_SUCCESS){
        NSLog(@"addTextLineSpace");
        return ;
    }
    
    result = [builder addTextLang:[self getBuilderLanguage]];
    if(result != EPOS_OC_SUCCESS){
        NSLog(@"addTextLang");
        return ;
    }
    
    result = [builder addTextSize:[self getBuilderSizeW] Height:[self getBuilderSizeH]];
    if(result != EPOS_OC_SUCCESS){
        NSLog(@"addTextSize");
        
        return ;
    }
    
    result = [builder addTextStyle:EPOS_OC_FALSE Ul:[self getBuilderStyleUnderline] Em:[self getBuilderStyleBold] Color:EPOS_OC_COLOR_1];
    if(result != EPOS_OC_SUCCESS){
        NSLog(@"addTextStyle");
        return ;
    }
    
    result = [builder addTextPosition:[self getBuilderXPosition]];
    if(result != EPOS_OC_SUCCESS){
        NSLog(@"addTextPosition");
        return ;
    }
    
    result = [builder addText:[self getBuilderText]];
    if(result != EPOS_OC_SUCCESS){
        NSLog(@"addText");
        
        return ;
    }
    
    result = [builder addFeedUnit:[self getBuilderFeedUnit]];
    if(result != EPOS_OC_SUCCESS){
        NSLog(@"addFeedUnit");
        return ;
    }
    
    //send builder data
    unsigned long status = 0;
    unsigned long battery = 0;
    result = [printer_ sendData:builder Timeout:SEND_TIMEOUT Status:&status Battery:&battery];
    
    //remove builder
    [builder clearCommandBuffer];
}

- (int)getBuilderFont
{
//    switch(fontList_.selectIndex){
//        case 1:
//            return EPOS_OC_FONT_B;
//        case 2:
//            return EPOS_OC_FONT_C;
//        case 0:
//        default:
            return EPOS_OC_FONT_A;
//    }
}

- (int)getBuilderAlign
{
//    switch(alignList_.selectIndex){
//        case 1:
//            return EPOS_OC_ALIGN_CENTER;
//        case 2:
            return EPOS_OC_ALIGN_RIGHT;
//        case 0:
//        default:
//            return EPOS_OC_ALIGN_LEFT;
//    }
}

- (long)getBuilderLineSpace
{
    return 10;
}

- (int)getBuilderLanguage
{
    return EPOS_OC_LANG_ZH_CN;
}

- (long)getBuilderSizeW
{
    return 400;
}

- (long)getBuilderSizeH
{
    return 400;
}

- (int)getBuilderStyleBold
{
//    if(switchStyleBold_.on){
//        return EPOS_OC_TRUE;
//    }else{
        return EPOS_OC_FALSE;
//    }
}

- (int)getBuilderStyleUnderline
{
//    if(switchStyleUnderline_.on){
//        return EPOS_OC_TRUE;
//    }else{
        return EPOS_OC_FALSE;
//    }
}

- (long)getBuilderXPosition
{
    return 10;
}

- (NSString *)getBuilderText
{
    return textData_;
}

- (long)getBuilderFeedUnit
{
    return 10;
}


@end
