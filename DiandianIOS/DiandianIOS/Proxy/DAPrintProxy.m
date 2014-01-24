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
#import "MBProgressHUD.h"

#define SEND_TIMEOUT    30 * 1000
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

-(NSMutableArray *) getLines
{
    return lines;
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
            
            [print addSplit];
            
            int result = [print printText:printSet.printerIP addTextSize:2 TextHeight:1];
            NSLog(@"testPrinter判断打印机状态   判断是否 :%d",result);
            
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

+(void) withOrderPrintLine:(DAOrder *)order print:(DAPrintProxy *)print{
    NSString *line;
    NSString *amount = [NSString stringWithFormat:@"%@",order.amount];
    NSString *name;
    int price = 0;
    
    
    if ([order.type intValue] == 0) {
        price = [order.item.itemPriceNormal intValue];
        name = order.item.itemName;
    } else {
        price = [order.item.itemPriceHalf intValue];
        name = [NSString stringWithFormat:@"%@(小份)",order.item.itemName];
        
    }
    
    line = [NSString stringWithFormat:@"%@ %0.2f    %@份  %@元" ,[Tool stringWithPad:name length:10] ,(float)price ,amount,order.amountPrice];
    
    [print addLine:line];
}

+(void) printBill: (NSString *) serviceId
              off:(NSString *)off
              pay:(NSString *)pay
          userPay:(NSString *)userPay
             type:(NSInteger * )type
          reduce :(NSString *)reduce
              seq:(NSString *)seq
         progress:(MBProgressHUD *)progress
{
    DAPrintProxy *print = [[DAPrintProxy alloc] init];
    [[DAServiceModule alloc]getBillByServiceId:serviceId callback:^(NSError *err, DABill *bill) {

        


        [print addLine:@""];
        if (seq.length > 0) {
            [print addLine:[NSString stringWithFormat:@"                 滋味厨房  收银联"]];
        } else {
            [print addLine:[NSString stringWithFormat:@"                 滋味厨房  客户联"]];
        }
        [print addLine:[NSString stringWithFormat:@"序号：%@",seq]];
        if ([bill.service.type intValue] == 3) {
            [print addLine:[NSString stringWithFormat:@"手机号:%@",bill.service.phone]];
        } else {
            [print addLine:[NSString stringWithFormat:@"台位:%@",bill.desk.name]];
        }


        
        
        
        [[DAOrderModule alloc] getOrderListByServiceId:serviceId withBack:@"0,1,2,3" callback:^(NSError *err, DAMyOrderList *list) {
            
            NSMutableArray *freeOrderList = [[NSMutableArray alloc]init];
            NSMutableArray *backOrderList = [[NSMutableArray alloc]init];
            NSMutableArray *doneOrderList = [[NSMutableArray alloc]init];
            NSMutableArray *undoneOrderList = [[NSMutableArray alloc]init];
            
            
            
            NSDate *now = [[NSDate alloc] init];
            [print addLine:[NSString stringWithFormat:@"时间:%@", [Tool stringFromISODateForBill:now]]];
            [print addLine:[NSString stringWithFormat:@"点菜员:%@", bill.waiter]];
            [print addLine:@""];
            [print addLine:[NSString stringWithFormat:@"品名                单价    份数   总价" ]];
            [print addSplit];
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

                
            }
            
            for (DAOrder *order in doneOrderList) {
                [DAPrintProxy withOrderPrintLine:order print:print];
            }
            //免单菜单和菜单 和在一起
            for (DAOrder *order in freeOrderList) {
                [DAPrintProxy withOrderPrintLine:order print:print];
                
            }
            
            if ([undoneOrderList count] > 0) {
                [print addLine:@""];
            }
            
            for (DAOrder *order in undoneOrderList) {
                [DAPrintProxy withOrderPrintLine:order print:print];
                
            }
            
            
            if ([backOrderList count] > 0) {
                [print addLine:@""];
                [print addLine:@"退菜菜单"];
            }
            for (DAOrder *order in backOrderList) {
                [DAPrintProxy withOrderPrintLine:order print:print];
            }
            
            if ([freeOrderList count] > 0) {
                [print addLine:@""];
                [print addLine:@"免单菜单"];

            }
            
            for (DAOrder *order in freeOrderList) {
                [DAPrintProxy withOrderPrintLine:order print:print];
                
            }
            
            [print addSplit];

            [print addLine:[NSString stringWithFormat:@"总金额:%.02f元", [bill.amount floatValue]]];
            if ([off intValue] == 1) {
                [print addLine:[NSString stringWithFormat:@"折扣:无 "]];
            } else {
                float tmpOff = [off floatValue] * 10;
                NSString *tmpOffStr = [NSString stringWithFormat:@"%.01f",tmpOff];
                
                [print addLine:[NSString stringWithFormat:@"折扣:%@折",tmpOffStr]];
            }

            [print addLine:[NSString stringWithFormat:@"应支付金额:%.02f元", [pay floatValue]]];
            [print addLine:[NSString stringWithFormat:@"优惠:%.02f元", [reduce floatValue]]];
            
            [print addLine:[NSString stringWithFormat:@"实际金额:%.02f元", [userPay floatValue]]];
            [print addLine:@""];
            [print addLine:@""];
            [print addLine:@"促销活动酒水、主食、个别菜不打折"];

                
            DAPrinter *billprint = [[DAPrinter alloc] unarchiveObjectWithFileWithPath:@"printer" withName:@"billprinter"];
            if (billprint != nil && billprint.printerIP!=nil && billprint.printerIP.length > 0 ) {
                int status = -1;
                int times = 0;
                do{
                    status = [print printText:billprint.printerIP addTextSize:1 TextHeight:1];
                    NSLog(@"打印  times %d",times++);
                    if (times > 100) {
                        break;
                    } else {
                        [NSThread sleepForTimeInterval:0.5f];
                    }
                }while(status == -1);
                

                NSLog(@"打印机状态 判断是否成功   : %d",status);
            } else {
                
                NSLog(@"没有链接订单打印机");
                [ProgressHUD showError:@"没有链接订单打印机"];
                
            }
            if (progress!=nil) {
                [progress hide:YES];
            }

            
            
            
        }];
        
        
        
        
        
        
        
    }];
}

+(NSArray *) reOrderPrintWithOrderList:(DAMyOrderList *)orderList deskName:(NSString *)deskName orderNum:(NSString * )orderNum now:(NSString *)now takeout:(NSString *) takeout tips:(NSString *)tips
{
    NSMutableArray *tmpResultPrinter = [[NSMutableArray alloc] init];
    return tmpResultPrinter;
}

+(NSArray *) resetOrderPrinterWithLeave :(NSArray *) resetList
{
    NSMutableArray *tmpResultPrinter = [[NSMutableArray alloc] init];
    for (DAPrinterLine *line in  resetList) {
        DAPrintProxy *print = [[DAPrintProxy alloc] init];
        int status = -1;
        if ([line.printerStatus intValue] != 0) {
            if ([line.printerType isEqualToString:@"bill"]) {
                for (NSString *str in line.printerLines) {
                    [print addLine:str];
                }
                
                [print printText:line.printerIp addTextSize:[line.printerTextSize intValue]TextHeight:[line.printerTextHeight intValue]];
            } else {
                status = [print printOrderText:line.printerIp linesList:line.printerLines addTextSize:[line.printerTextSize intValue]TextHeight:[line.printerTextHeight intValue]];
            }
            line.printerStatus = [NSString stringWithFormat:@"%d",status];
            [tmpResultPrinter addObject:line];
        }
        
    }

    return tmpResultPrinter;
}

+(NSArray *) addOrderPrintWithOrderList:(DAMyOrderList *)orderList deskName:(NSString *)deskName orderNum:(NSString * )orderNum now:(NSString *)now takeout:(NSString *) takeout tips:(NSString *)tips
{
    

    DAPrinter *defaultPrinter = nil;
    NSMutableArray *tmpResultPrinter = [[NSMutableArray alloc] init];
    DAPrinterList *printtList = [[DAPrinterList alloc]unarchiveObjectWithFileWithPath:@"printer" withName:@"printer"];
    
    if (printtList == nil || [printtList.items count] == 0) {
        [ProgressHUD showError:@"请设置打印机"];
        return tmpResultPrinter;
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
    
    //START  打印流水单
    DAPrintProxy *print1 = [[DAPrintProxy alloc] init];
    [print1 addLine:[NSString stringWithFormat:@"流水单"]];

    if (takeout.length > 0) {
        [print1 addLine:[NSString stringWithFormat:@" 外卖  单号:%@ 时间：%@",orderNum,[Tool stringFromISODateString:now]]];
    } else {
        [print1 addLine:[NSString stringWithFormat:@"桌台:%@    ",deskName]];
        [print1 addLine:[NSString stringWithFormat:@"单号:%@    ",orderNum]];
        [print1 addLine:[NSString stringWithFormat:@"单时间：%@",[Tool stringFromISODateString:now]]];
    }
    
    if (tips.length > 0) {
        [print1 addLine:[NSString stringWithFormat:@"备注:%@  ",tips]];
    }
    [print1 addLine:[NSString stringWithFormat:@" "]];
    
    for (DAOrder *willOrder in orderList.items) {
        NSString *line;
        NSString *tmpAmount = [NSString stringWithFormat:@"%@",willOrder.amount];
        if ([willOrder.type  integerValue] == 0) {
            line = [NSString stringWithFormat:@"%@  %@份  %@元" ,willOrder.item.itemName,tmpAmount,willOrder.item.itemPriceNormal];
        } else {
            line = [NSString stringWithFormat:@"%@ （小份）  %@份  %@元" ,willOrder.item.itemName,tmpAmount,willOrder.item.itemPriceHalf];
        }
        
        [print1 addLine:line];
        
        
    }
    
    if([orderList.items count] > 0){
        int status = -1;

        DAPrinter *billprint = [[DAPrinter alloc] unarchiveObjectWithFileWithPath:@"printer" withName:@"billprinter"];
        //打印机状态
        DAPrinterLine *printerLine = [[DAPrinterLine alloc]init];
        printerLine.printerLines = [print1 getLines];
        printerLine.printerType  = @"bill";
        printerLine.printerIp    = billprint.printerIP;
        printerLine.printerTextSize = @"2";
        printerLine.printerTextHeight = @"2";
        printerLine.printerName = billprint.name;
    
    
        status = [print1 printText:billprint.printerIP addTextSize:2 TextHeight:2];
        printerLine.printerStatus    = [NSString stringWithFormat:@"%d",status];
        [tmpResultPrinter addObject:printerLine];
        
        
        
        
        NSLog(@"打印机状态 判断是否成功   : %d",status);
        
    }
    
    //END  打印流水单
    
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

            NSMutableArray *tmpOrderPrintList = [[NSMutableArray alloc]init];
            
            //START  后厨打印
            NSMutableArray *tmpOrderCheckPrintLine = [[NSMutableArray alloc]init];
            
            DAPrintProxy *print = [[DAPrintProxy alloc] init];
            [tmpOrderCheckPrintLine addObject:[NSString stringWithFormat:@"后厨核对单"]];
            
            if (takeout.length > 0) {
                [tmpOrderCheckPrintLine addObject:[NSString stringWithFormat:@" 外卖  单号:%@ 时间：%@",orderNum,[Tool stringFromISODateString:now]]];
            } else {
                [tmpOrderCheckPrintLine addObject:[NSString stringWithFormat:@"单号:%@    %@ ",orderNum,deskName]];
                [tmpOrderCheckPrintLine addObject:[NSString stringWithFormat:@"单时间：%@",[Tool stringFromISODateString:now]]];
            }
            
            if (tips.length > 0) {
                [tmpOrderCheckPrintLine addObject:[NSString stringWithFormat:@"备注:%@  ",tips]];
            }
            
            [tmpOrderCheckPrintLine addObject:[NSString stringWithFormat:@" "]];
            
            for (DAOrder *willOrderA in printerOrderList) {
                NSString *line;
                NSString *tmpAmount = [NSString stringWithFormat:@"%@",willOrderA.amount];
                if ([willOrderA.type  integerValue] == 0) {
                    line = [NSString stringWithFormat:@"%@  %@份 " ,willOrderA.item.itemName,tmpAmount];
                } else {
                    line = [NSString stringWithFormat:@"%@ （小份）  %@份 " ,willOrderA.item.itemName,tmpAmount];
                }
                
                [tmpOrderCheckPrintLine addObject:line];
            }
            [tmpOrderPrintList addObject:tmpOrderCheckPrintLine];
            
            for (DAOrder *willOrder in printerOrderList) {
                NSMutableArray *tmpOrderPrintLine = [[NSMutableArray alloc]init];

                if (takeout.length > 0) {
                    [tmpOrderPrintLine addObject:[NSString stringWithFormat:@" 外卖  单号:%@ 时间：%@",orderNum,[Tool stringFromISODateString:now]]];
                } else {
                    [tmpOrderPrintLine addObject:[NSString stringWithFormat:@"单号:%@    %@ ",orderNum,deskName]];
                    [tmpOrderPrintLine addObject:[NSString stringWithFormat:@"单时间：%@",[Tool stringFromISODateString:now]]];
                }
                
                if (tips.length > 0) {
                    [tmpOrderPrintLine addObject:[NSString stringWithFormat:@"备注:%@  ",tips]];
                }
                
                [tmpOrderPrintLine addObject:[NSString stringWithFormat:@" "]];
                
                NSString *line;
                
                if ([willOrder.type  integerValue] == 0) {
                    line = [NSString stringWithFormat:@"%@  %@份 " ,willOrder.item.itemName,willOrder.amount];
                } else {
                    line = [NSString stringWithFormat:@"%@ （小份）  %@份 " ,willOrder.item.itemName,willOrder.amount];
                }
            
                [tmpOrderPrintLine addObject:line];
                [tmpOrderPrintList addObject:tmpOrderPrintLine];
                
            }
            
            if([printerOrderList count] > 0 && [printerSet.need intValue] == 1){
                //打印机状态
                DAPrinterLine *printerLine = [[DAPrinterLine alloc]init];
                printerLine.printerLines = tmpOrderPrintList;
                printerLine.printerType  = @"cook";
                printerLine.printerIp    = printerSet.printerIP;
                printerLine.printerTextSize = @"2";
                printerLine.printerTextHeight = @"3";
                printerLine.printerName = printerSet.name;
                
                int status = [print printOrderText:printerSet.printerIP linesList:tmpOrderPrintList addTextSize:2 TextHeight:3];
                
                printerLine.printerStatus    = [NSString stringWithFormat:@"%d",status];
                [tmpResultPrinter addObject:printerLine];

                
                NSLog(@"打印机状态 判断是否成功   : %d",status);
                
            }
            //END  后厨打印
            
            
            
            
        }
        
        
    
    }
    return tmpResultPrinter;
    
    

    
}


- (id)init {
    self = [super init];
    if (self != nil) {
        lines = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)addLine:(NSString *)text {
    NSLog(@"%@", text);
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
    NSString *split = [@"" stringByPaddingToLength:length withString:@"-" startingAtIndex:0];
    [lines addObject:split];
}

- (void)onStatusChange:(NSString *)deviceName Status:(NSNumber *)status {
    
    NSLog(@"deviceName %@ status  %@",deviceName,[self getEposStatusText:(int)status]);
    
}

- (EposPrint *)getPrinter:(NSString *)ip
{
    EposPrint *printer = [[EposPrint alloc] init];
    int errorStatus = EPOS_OC_SUCCESS;
    if ( printer != nil) {
        // open
        errorStatus = [printer openPrinter:EPOS_OC_DEVTYPE_TCP DeviceName:ip];
        NSLog(@"getPrinter  result : %d  text :%@" ,errorStatus,[self getEposResultText :errorStatus]);
        return printer;
    } else {
        return nil;
    }
    
}

- (int)printOrderText:(NSString *)ip linesList:(NSArray *)linesList addTextSize:(long) addTextSize TextHeight:(long)TextHeight
{
    int result = -1;
    // create builder
    EposBuilder *builder = [[EposBuilder alloc] initWithPrinterModel:PRINT_NAME Lang:EPOS_OC_MODEL_CHINESE];
    if(builder == nil){
        return PRINT_ERROR;
    }
    
    //设置语言
    result = [builder addTextLang:EPOS_OC_LANG_ZH_CN];
    
    if(result != EPOS_OC_SUCCESS){
        return PRINT_ERROR;
    }
    
    //设置文字
    result = [builder addTextFont:EPOS_OC_FONT_A];
    if(result != EPOS_OC_SUCCESS){
        return PRINT_ERROR;
    }
    
    result = [builder addTextSize:addTextSize Height:TextHeight];
    if(result != EPOS_OC_SUCCESS){
        return PRINT_ERROR;
    }
    
    for (int i = 0 ; i <[linesList count] ;i++) {
        NSArray *tempList =  [linesList objectAtIndex:i];
        if (i == 0) {
            result = [builder addTextSize:1 Height:1];
            if(result != EPOS_OC_SUCCESS){
                return PRINT_ERROR;
            }
        } else {
            result = [builder addTextSize:addTextSize Height:TextHeight];
            if(result != EPOS_OC_SUCCESS){
                return PRINT_ERROR;
            }
        }

        // bug fix
        for (NSString *str in tempList) {
            NSLog(@"%@",str);
            result = [builder addText:[str stringByAppendingString:@"\n" ]];
            if(result != EPOS_OC_SUCCESS){
                return PRINT_ERROR;
            }
        }
    
        
        
        // cut
        result = [builder addCut:EPOS_OC_CUT_FEED];
        if (result != EPOS_OC_SUCCESS) {
            return PRINT_ERROR;
        }
        
    }
    // feed
    result = [builder addFeedUnit:30];
    if(result != EPOS_OC_SUCCESS){
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
    NSLog(@"send data  %d  Text: %@" ,result ,  [self getEposStatusText:status]);
    if (result != EPOS_OC_SUCCESS) {
        return PRINT_ERROR;
    }
    
    // remove builder
    [builder clearCommandBuffer];//状态？

    [printer closePrinter];
    //TODO
    
    
    return PRINT_SUCCESS;
    
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
    NSLog(@"builder addTextLang:EPOS_OC_LANG_ZH_CN  result : %d " ,result);
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
    NSLog(@"send data  %d  Text: %@" ,result ,  [self getEposStatusText:status]);
    if (result != EPOS_OC_SUCCESS) {
        return PRINT_ERROR;
    }
    
    // clear data & close print
    [lines removeAllObjects];

    // remove builder
    [builder clearCommandBuffer];
    
    [printer closePrinter];
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

-(int) printBackOrder:(DAPrintProxy *)print
            printList:(NSMutableDictionary *)printList
            printerId:(NSString *)printerId
             itemName:(NSString *)itemName
             deskName:(NSString *)deskName
           waiterName:(NSString *)waiterName
        willBackCount:(NSString *)willBackCount
              takeout:(NSString *)takeout
                  now:(NSString *)now
{
    NSString *ip = [printList objectForKey:printerId];
    
    [print addLine:[NSString stringWithFormat:@"  退菜 "]];
    
    [print addLine:[NSString stringWithFormat:@"单时间：%@",[Tool stringFromISODateString:now]]];
    [print addLine:[NSString stringWithFormat:@" "]];
    
    NSString *line = [NSString stringWithFormat:@"%@  %@份 " ,itemName,willBackCount];

    [print addLine:line];
    [print addLine:[NSString stringWithFormat:@" "]];    
    [print printText:ip addTextSize:2 TextHeight:3];
    return 0;
}

+(int) addOrderBackPrint:(NSArray *)backOrderList;
{
    DAPrintProxy *print = [[DAPrintProxy alloc] init];
    
    DAPrinterList *printtList = [[DAPrinterList alloc]unarchiveObjectWithFileWithPath:@"printer" withName:@"printer"];
    if (printtList == nil || [printtList.items count] == 0) {
        [ProgressHUD showError:@"请设置打印机"];
        return -1;
    }
    
    NSMutableDictionary *SystemPrintSet = [[NSMutableDictionary alloc]init];
    for (DAPrinter *printerSet in printtList.items) {

        if ([printerSet.type isEqualToString:@"1"]) {
            [SystemPrintSet setObject:printerSet.printerIP forKey:printerSet._id];
        }
        
    }
    
    for (DAOrder *order in backOrderList) {
        [print printBackOrder:print
                    printList:SystemPrintSet
                    printerId:order.item.printerId
                     itemName:order.item.itemName
                     deskName:order.desk?order.desk.name:@"外卖"
                   waiterName:order.createby
                willBackCount:order.willBackAmount
                      takeout:@""
                          now:order.createat];
        
    }
    
    return 0;
}




@end
