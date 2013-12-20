//
//  DAPrintProxy.m
//  DiandianIOS
//
//  Created by Antony on 13-11-29.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAPrintProxy.h"
#import "ProgressHUD.h"
#import "Tool.h"

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
+(void) testPrinter
{
    
    [ProgressHUD show:@"正在为你测试打印机，请稍等。"];
    NSMutableArray *tmpPrinterList = [[NSMutableArray alloc] init];
    [[DAPrinterModule alloc] getPrinterList:^(NSError *err, DAPrinterList *list) {
        
        NSLog(@"%@",list);
        for (DAPrinter *printSet in list.items) {
            //初始化当作打印机失效
            printSet.valid = [NSNumber numberWithInt:0];
            DAPrintProxy *print = [[DAPrintProxy alloc] init];
            [print addLine:@"测试打印机"];
            [print addLine:[NSString stringWithFormat:@"测试名称：%@" ,printSet.name]];
            
            [print addLine:@"单号：0021 包：4 下单时间：18:30"];
            [print addSplit];
            [print addLine:@"青椒肉丝（小份） 2份"];
            [print addLine:@"红烧排骨（大份） 1份"];
            [print addLine:@"青椒肉丝（小份） 2份"];
            [print addLine:@"红烧排骨（大份） 1份"];
            [print addLine:@"青椒肉丝（小份） 2份"];
            [print addLine:@"红烧排骨（大份） 1份"];
            [print addLine:@"青椒肉丝（小份） 2份"];
            [print addLine:@"红烧排骨（大份） 1份"];
            [print addLine:@"青椒肉丝（小份） 2份"];
            [print addSplit];
            
            int result = [print printText:printSet.printerIP addTextSize:1 TextHeight:1];
            
            if (result == 0) {
                //根据返回值  设置 打印机有效
                printSet.valid = [NSNumber numberWithInt:1];
                
            }
            
            if ([printSet.type isEqualToString:@"2"]) {
                [printSet archiveRootObjectWithPath:@"printer" withName:@"billprinter"];
            }
            [tmpPrinterList addObject:printSet];
        }
        
        list.items = [[NSArray alloc] initWithArray:tmpPrinterList];
        [list archiveRootObjectWithPath:@"printer" withName:@"printer"];
        
        [ProgressHUD dismiss];
        
    }];

}

+(void) printBill: (NSString *) serviceId off:(NSString *)off pay:(NSString *)pay type:(NSInteger * )type reduce :(NSString *)reduce
{
    DAPrintProxy *print = [[DAPrintProxy alloc] init];
    [[DAServiceModule alloc]getBillByServiceId:serviceId callback:^(NSError *err, DABill *bill) {

        
        [print addLine:[NSString stringWithFormat:@"              滋味厨房"]];
        [print addSplit];
        
        
        [[DAOrderModule alloc] getOrderListByServiceId:serviceId withBack:@"0,1,2,3" callback:^(NSError *err, DAMyOrderList *list) {
            
            NSMutableArray *freeOrderList = [[NSMutableArray alloc]init];
            NSMutableArray *backOrderList = [[NSMutableArray alloc]init];
            NSMutableArray *doneOrderList = [[NSMutableArray alloc]init];
            NSMutableArray *undoneOrderList = [[NSMutableArray alloc]init];
            ;
            [print addLine:@"菜单"];
            for (DAOrder *order in list.items) {
                if ([order.back integerValue] == 3) {
                    [freeOrderList addObject:order];
                } else if  ([order.back integerValue] == 2) {
                    [backOrderList addObject:order];
                } else if  ([order.back integerValue] == 1){
                    [doneOrderList addObject:order];
                } else {
                    [undoneOrderList addObject:order];
                }
                
            }
            if ([doneOrderList count] > 0) {
                [print addLine:@"已上菜单"];
            }
            
            for (DAOrder *order in doneOrderList) {
                NSString *line;
                if ([order.type  integerValue] == 0) {
                    line = [NSString stringWithFormat:@"%@        1份    %@元" ,[Tool stringWithPad:order.item.itemName length:10] , order.item.itemPriceNormal];
                } else {
                    NSString *name = [NSString stringWithFormat:@"%@(小份)",order.item.itemName];
                    line = [NSString stringWithFormat:@"%@        1份    %@元" ,[Tool stringWithPad:name length:10] ,order.item.itemPriceHalf];
                    
                }
                [print addLine:line];
            }
            if ([undoneOrderList count] > 0) {
                [print addLine:@"未上菜单"];
            }
            
            for (DAOrder *order in undoneOrderList) {
                NSString *line;
                if ([order.type  integerValue] == 0) {
                    line = [NSString stringWithFormat:@"%@        1份    %@元" ,[Tool stringWithPad:order.item.itemName length:10] , order.item.itemPriceNormal];
                } else {
                    NSString *name = [NSString stringWithFormat:@"%@(小份)",order.item.itemName];
                    line = [NSString stringWithFormat:@"%@        1份    %@元" ,[Tool stringWithPad:name length:10] ,order.item.itemPriceHalf];
                    
                }
                [print addLine:line];
            }
            
            
            if ([backOrderList count] > 0) {
                [print addLine:@"退菜菜单"];
            }
            for (DAOrder *order in backOrderList) {
                NSString *line;
                if ([order.type  integerValue] == 0) {
                    line = [NSString stringWithFormat:@"%@        1份    %@元" ,[Tool stringWithPad:order.item.itemName length:10] , order.item.itemPriceNormal];
                } else {
                    NSString *name = [NSString stringWithFormat:@"%@(小份)",order.item.itemName];
                    line = [NSString stringWithFormat:@"%@        1份    %@元" ,[Tool stringWithPad:name length:10] ,order.item.itemPriceHalf];
                    
                }
                [print addLine:line];
            }
            
            if ([freeOrderList count] > 0) {
                [print addLine:@"免单菜单"];
            }
            
            for (DAOrder *order in freeOrderList) {
                NSString *line;
                if ([order.type  integerValue] == 0) {
                    line = [NSString stringWithFormat:@"%@        1份    %@元" ,[Tool stringWithPad:order.item.itemName length:10] , order.item.itemPriceNormal];
                } else {
                    NSString *name = [NSString stringWithFormat:@"%@(小份)",order.item.itemName];
                    line = [NSString stringWithFormat:@"%@        1份    %@元" ,[Tool stringWithPad:name length:10] ,order.item.itemPriceHalf];
                    
                }
                [print addLine:line];
            }
            
            [print addSplit];
            
            [print addLine:[NSString stringWithFormat:@"台位:%@",bill.desk.name]];
            NSDate *now = [[NSDate alloc] init];
            [print addLine:[NSString stringWithFormat:@"时间:%@", [Tool stringFromISODate:now]]];
            
            [print addLine:[NSString stringWithFormat:@"总金额:%.02f元", [bill.amount floatValue]]];
            
            [print addLine:[NSString stringWithFormat:@"折扣:%.02f ", [off floatValue]]];
            
            [print addLine:[NSString stringWithFormat:@"优惠:%.02f元", [reduce floatValue]]];
            

                
            DAPrinter *billprint = [[DAPrinter alloc] unarchiveObjectWithFileWithPath:@"printer" withName:@"billprinter"];
            if (billprint != nil && billprint.printerIP!=nil && billprint.printerIP.length > 0 ) {
                
                [print printText:billprint.printerIP addTextSize:1 TextHeight:1];
                
            } else {
                
                NSLog(@"没有链接订单打印机");
                [ProgressHUD showError:@"没有链接订单打印机"];
                
            }
            
            
            
        }];
        
        
        
        
        
        
        NSLog(@"bill %@",bill);
//        billData = bill;
//        self.lblTotal.text = [NSString stringWithFormat:@"%.02f元",[bill.amount floatValue]];
//        //判断是否是  外卖
//        if ([self.curService.type integerValue] == 3) {
//            self.lblDeskName.text = [NSString stringWithFormat:@"外卖"];
//        } else {
//            self.lblDeskName.text = [NSString stringWithFormat:@"桌号：%@",bill.desk.name];
//        }
//        
//        float off = [billData.amount floatValue] * offAmount - [self.textReduce.text floatValue];
//        self.lblPay.text = [NSString stringWithFormat:@"%.02f元 ",off];
//        self.textPay.text = [NSString stringWithFormat:@"%d", [bill.amount integerValue]];
    }];
}

+(void) addOrderPrintWithOrderList:(DAMyOrderList *)orderList deskName:(NSString *)deskName orderNum:(NSString * )orderNum now:(NSString *)now takeout:(NSString *) takeout tips:(NSString *)tips
{
    

    DAPrinter *defaultPrinter = nil;
    
    DAPrinterList *printtList = [[DAPrinterList alloc]unarchiveObjectWithFileWithPath:@"printer" withName:@"printer"];
    if (printtList == nil || [printtList.items count] == 0) {
        [ProgressHUD showError:@"请设置打印机"];
        return;
    }
    NSMutableDictionary *SystemPrintSet = [[NSMutableDictionary alloc]init];
    for (DAPrinter *printerSet in printtList.items ) {
        
        if (defaultPrinter == nil && [printerSet.type isEqualToString:@"1"]) {
            defaultPrinter = printerSet;
        }
        
        if ([printerSet.type isEqualToString:@"1"]) {
            NSMutableArray *printerOrderList = [[NSMutableArray alloc]init];
            [SystemPrintSet setObject:printerOrderList forKey:printerSet._id];
        }
        
    }
    
    
    for (DAOrder *willOrder in orderList.items) {
        if (willOrder.item.printerId !=nil && willOrder.item.printerId.length > 0) {
            NSLog(@"打印机调试 %@" , willOrder.item.printerId);
            NSMutableArray *printerOrderList = [SystemPrintSet objectForKey:willOrder.item.printerId];
            
            [printerOrderList addObject:willOrder];
            [SystemPrintSet setObject:printerOrderList forKey:willOrder.item.printerId];
        }
    }
    
    for (DAPrinter *printerSet in printtList.items ) {
        
        if ([printerSet.type isEqualToString:@"1"]) {
            NSMutableArray *printerOrderList = [SystemPrintSet objectForKey:printerSet._id];
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
            for (DAOrder *willOrder in printerOrderList) {
                
                    NSString *line;
                    if ([willOrder.type  integerValue] == 0) {
                        line = [NSString stringWithFormat:@"%@ 1份 " ,willOrder.item.itemName];
                    } else {
                        line = [NSString stringWithFormat:@"%@ （小份） 1份 " ,willOrder.item.itemName];
                    }
                
                    [print addLine:line];
                
            }
            [print addSplit];
            
            
            [print printText:printerSet.printerIP addTextSize:2 TextHeight:3];
            
        }
    
    }
    
    

    
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

- (int)printText:(NSString *)ip addTextSize:(long) addTextSize TextHeight:(long)TextHeight
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
    
    result = [builder addTextSize:addTextSize Height:TextHeight];
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
    
    if (printer == nil) {
        return -1;
    }
    
    // send builder data
    unsigned long status = 0;
    unsigned long battery = 0;
    result = [printer sendData:builder Timeout:SEND_TIMEOUT Status:&status Battery:&battery];
    NSLog(@"send data  %d" ,result);
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
