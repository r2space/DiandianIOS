//
//  DAPrintProxy.m
//  DiandianIOS
//
//  Created by Antony on 13-11-29.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAPrintProxy.h"

#define SEND_TIMEOUT    10 * 1000
#define PRINT_NAME      @"TM-T88V"

enum PrintErrorStatus
{
	PRINT_ERROR = -1,
	PRINT_SUCCESS = 0
};

@implementation DAPrintProxy
{
    NSMutableArray *lines;
}

+(void) addOrderPrintWithOrderList:(DAMyOrderList *)orderList deskName:(NSString *)deskName orderNum:(NSString * )orderNum now:(NSString *)now takeout:(NSString *) takeout tips:(NSString *)tips
{
    
    DAPrintProxy *print = [[DAPrintProxy alloc] init];
    
    if (takeout.length > 0) {
        [print addLine:[NSString stringWithFormat:@"单号:%@ 外卖的手机号：%@ 下单时间：%@",orderNum,takeout,now]];
    } else {
        [print addLine:[NSString stringWithFormat:@"单号:%@ 包： %@ 下单时间：%@",orderNum,deskName,now]];
    }
    
    if (tips.length > 0) {
        [print addLine:[NSString stringWithFormat:@"备注:%@  ",tips]];
    }
    
    [print addSplit];
    for (DAOrder *order in orderList.items) {
        
        NSString *line;
        if ([order.type  integerValue] == 0) {
            line = [NSString stringWithFormat:@"%@ 1份 " ,order.item.itemName];
        } else {
            line = [NSString stringWithFormat:@"%@ （小份） 1份 " ,order.item.itemName];
        }
        
        
        [print addLine:line];
    }
    
    [print addSplit];
    
    [print printText:@"10.2.3.149"];

    
}


- (id)init {
    self = [super init];
    if (self != nil) {
        lines = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addLine:(NSString *)text {
    [lines addObject:text];
}

- (void)addLineBreak {
    [lines addObject:@"\n"];
}

- (void)addSplit
{
    [self addSplit:48];
}

- (void)addSplit:(int)length
{
    NSString *split = [@"" stringByPaddingToLength:length withString:@"_" startingAtIndex:0];
    [lines addObject:split];
}

- (EposPrint *)getPrinter:(NSString *)ip
{
    EposPrint *printer = [[EposPrint alloc] init];
    
    // open
    int result = [printer openPrinter:EPOS_OC_DEVTYPE_TCP DeviceName:ip];
    if (result != EPOS_OC_SUCCESS) {
        return nil;
    }
    
    return printer;
}

- (int)printText:(NSString *)ip
{
    // create builder
    EposBuilder *builder = [[EposBuilder alloc] initWithPrinterModel:PRINT_NAME Lang:EPOS_OC_MODEL_CHINESE];
    if(builder == nil){
        return PRINT_ERROR;
    }


    //add command
    int result = [builder addTextLang:EPOS_OC_LANG_ZH_CN];
    if(result != EPOS_OC_SUCCESS){
        
        return PRINT_ERROR;
    }
    result = [builder addTextFont:EPOS_OC_FONT_A];
    if(result != EPOS_OC_SUCCESS){
        
        return PRINT_ERROR;
    }
    
    result = [builder addTextSize:2 Height:2];
    if(result != EPOS_OC_SUCCESS){
        return PRINT_ERROR;
    }
    
    // print text
    for (NSString *line in lines) {
        result = [builder addText:[line stringByAppendingString:@"\n" ]];
        if(result != EPOS_OC_SUCCESS){
            return PRINT_ERROR;
        }
    }
   
    
    // set language
//    result = [builder addTextLang:EPOS_OC_LANG_ZH_CN];
//    if(result != EPOS_OC_SUCCESS){
//        return PRINT_ERROR;
//    }
    //add command
    
    
    // feed
    result = [builder addFeedUnit:30];
    if(result != EPOS_OC_SUCCESS){
        return PRINT_ERROR;
    }
    
    
    // cut
    result = [builder addCut:EPOS_OC_CUT_FEED];
    if (result != EPOS_OC_SUCCESS) {
        return PRINT_ERROR;
    }
    
    
    // open printer
    EposPrint *printer = [self getPrinter:ip];
    
    // send builder data
    unsigned long status = 0;
    unsigned long battery = 0;
    result = [printer sendData:builder Timeout:SEND_TIMEOUT Status:&status Battery:&battery];
    if (result != EPOS_OC_SUCCESS) {
        return PRINT_ERROR;
    }
    
    // clear data & close print
    [lines removeAllObjects];
    [printer closePrinter];
    
    // remove builder
    [builder clearCommandBuffer];
    
    return PRINT_SUCCESS;
}

// convert EposPrint result to text
- (NSString*)getEposResultText:(int)result
{
    switch(result){
        case EPOS_OC_SUCCESS:
            return @"SUCCESS";
        case EPOS_OC_ERR_PARAM:
            return @"ERR_PARAM";
        case EPOS_OC_ERR_OPEN:
            return @"ERR_OPEN";
        case EPOS_OC_ERR_CONNECT:
            return @"ERR_CONNECT";
        case EPOS_OC_ERR_TIMEOUT:
            return @"ERR_TIMEOUT";
        case EPOS_OC_ERR_MEMORY:
            return @"ERR_MEMORY";
        case EPOS_OC_ERR_ILLEGAL:
            return @"ERR_ILLEGAL";
        case EPOS_OC_ERR_PROCESSING:
            return @"ERR_PROCESSING";
        case EPOS_OC_ERR_UNSUPPORTED:
            return @"ERR_UNSUPPORTED";
        case EPOS_OC_ERR_OFF_LINE:
            return @"ERR_OFF_LINE";
        case EPOS_OC_ERR_FAILURE:
            return @"ERR_FAILURE";
        default:
            return [NSString stringWithFormat:@"%d", result];
    }
}

// covnert EposPrint status to text
- (NSString*)getEposStatusText:(unsigned long)status
{
    NSString *result = @"";
    
    for(int bit = 0; bit < 32; bit++){
        unsigned int value = 1 << bit;
        if((value & status) != 0){
            NSString *msg = @"";
            switch(value){
                case EPOS_OC_ST_NO_RESPONSE:
                    msg = @"NO_RESPONSE";
                    break;
                case EPOS_OC_ST_PRINT_SUCCESS:
                    msg = @"PRINT_SUCCESS";
                    break;
                case EPOS_OC_ST_DRAWER_KICK:
                    msg = @"DRAWER_KICK";
                    break;
                case EPOS_OC_ST_OFF_LINE:
                    msg = @"OFF_LINE";
                    break;
                case EPOS_OC_ST_COVER_OPEN:
                    msg = @"COVER_OPEN";
                    break;
                case EPOS_OC_ST_PAPER_FEED:
                    msg = @"PAPER_FEED";
                    break;
                case EPOS_OC_ST_WAIT_ON_LINE:
                    msg = @"WAIT_ON_LINE";
                    break;
                case EPOS_OC_ST_PANEL_SWITCH:
                    msg = @"PANEL_SWITCH";
                    break;
                case EPOS_OC_ST_MECHANICAL_ERR:
                    msg = @"MECHANICAL_ERR";
                    break;
                case EPOS_OC_ST_AUTOCUTTER_ERR:
                    msg = @"AUTOCUTTER_ERR";
                    break;
                case EPOS_OC_ST_UNRECOVER_ERR:
                    msg = @"UNRECOVER_ERR";
                    break;
                case EPOS_OC_ST_AUTORECOVER_ERR:
                    msg = @"AUTORECOVER_ERR";
                    break;
                case EPOS_OC_ST_RECEIPT_NEAR_END:
                    msg = @"RECEIPT_NEAR_END";
                    break;
                case EPOS_OC_ST_RECEIPT_END:
                    msg = @"RECEIPT_END";
                    break;
                case EPOS_OC_ST_BUZZER:
                    break;
                default:
                    return [NSString stringWithFormat:@"%d", value];
                    break;
            }
            if(msg.length != 0){
                if(result.length != 0){
                    result = [result stringByAppendingString:@"\n"];
                }
                result = [result stringByAppendingString:msg];
            }
        }
    }
    
    return result;
}




@end
