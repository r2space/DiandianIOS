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
#import "OpenUDID.h"
#import "DDLog.h"
static const int ddLogLevel = LOG_LEVEL_VERBOSE;

#define SEND_TIMEOUT    30 * 1000
#define PRINT_NAME      @"TM-T88V"
#define LOCK_TIMEOUT   30

enum PrintErrorStatus {
    PRINT_ERROR = -1,
    PRINT_SUCCESS = 0
};


@implementation DAPrintProxy {
    NSMutableArray *lines;
    DAPrinter *_printer;
    NSTimer *_timer;
    NSDate *_timerStart;
    BOOL requestPendding;
    NSMutableArray *_ticketLineList;
    ProxyType _type;

}
//
//-(NSMutableArray *) getLines
//{
//    return lines;
//}

- (DAPrintProxy *)initWithPrinter:(DAPrinter *)printer andType:(ProxyType)type {
    self = [super init];
    if (self) {
        _printer = printer;
        _type = type;
        lines = [[NSMutableArray alloc] init];
        [self initTimer];
    }
    return self;
}

- (DAPrintProxy *)initWithPrinter:(DAPrinter *)printer andTicketData:(NSMutableArray *)data {
    self = [super init];
    if (self) {
        _printer = printer;
        _type = TICKET_PRINT;
        _ticketLineList = data;
        lines = [[NSMutableArray alloc] init];
        [self initTimer];
    }
    return self;
}


+ (void)testPrinter {

    [ProgressHUD show:@"正在为你测试打印机，请稍等。"];
    NSMutableArray *tmpPrinterList = [[NSMutableArray alloc] init];
    [[DAPrinterModule alloc] getPrinterList:^(NSError *err, DAPrinterList *list) {

        NSLog(@"%@", list);
        for (DAPrinter *printSet in list.items) {
            //初始化当作打印机失效
            printSet.valid = [NSNumber numberWithInt:0];
            DAPrintProxy *print = [[DAPrintProxy alloc] init];
            [print addLine:@"测试打印机"];
            [print addLine:[NSString stringWithFormat:@"测试名称：%@", printSet.name]];

            [print addLine:@"单号：0021 包：4 下单时间：18:30"];
            [print addSplit];

            [print addSplit];

            int result = [print printText:printSet.printerIP addTextSize:2 TextHeight:1];
            NSLog(@"testPrinter判断打印机状态   判断是否 :%d", result);

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

+ (void)withOrderPrintLine:(DAOrder *)order print:(DAPrintProxy *)print {
    NSString *line;
    NSString *amount = [NSString stringWithFormat:@"%@", order.amount];
    NSString *name;
    int price = 0;


    if ([order.type intValue] == 0) {
        price = [order.item.itemPriceNormal intValue];
        name = order.item.itemName;
    } else {
        price = [order.item.itemPriceHalf intValue];
        name = [NSString stringWithFormat:@"%@(小份)", order.item.itemName];

    }

    line = [NSString stringWithFormat:@"%@ %0.2f    %@份  %@元", [Tool stringWithPad:name length:10], (float) price, amount, order.amountPrice];

    [print addLine:line];
}

+ (void)printBill:(NSString *)serviceId
              off:(NSString *)off
              pay:(NSString *)pay
          userPay:(NSString *)userPay
             type:(NSInteger *)type
           reduce:(NSString *)reduce
              seq:(NSString *)seq
         progress:(MBProgressHUD *)progress {
    DAPrintProxy *print = [[DAPrintProxy alloc] init];
    [[DAServiceModule alloc] getBillByServiceId:serviceId callback:^(NSError *err, DABill *bill) {


        [print addLine:@""];
        if ([seq isEqualToString:@"-1"]) {
            [print addLine:[NSString stringWithFormat:@"                 滋味厨房  客户联"]];

        } else {
            [print addLine:[NSString stringWithFormat:@"                 滋味厨房  收银联"]];
            [print addLine:[NSString stringWithFormat:@"序号：%@", seq]];
        }

        if ([bill.service.type intValue] == 3) {
            [print addLine:[NSString stringWithFormat:@"手机号:%@", bill.service.phone]];
        } else {
            [print addLine:[NSString stringWithFormat:@"台位:%@", bill.desk.name]];
        }


        [[DAOrderModule alloc] getOrderListByServiceId:serviceId withBack:@"0,1,2,3" callback:^(NSError *err, DAMyOrderList *list) {

            NSMutableArray *freeOrderList = [[NSMutableArray alloc] init];
            NSMutableArray *backOrderList = [[NSMutableArray alloc] init];
            NSMutableArray *doneOrderList = [[NSMutableArray alloc] init];
            NSMutableArray *undoneOrderList = [[NSMutableArray alloc] init];


            NSDate *now = [[NSDate alloc] init];
            [print addLine:[NSString stringWithFormat:@"时间:%@", [Tool stringFromISODateForBill:now]]];
            [print addLine:[NSString stringWithFormat:@"点菜员:%@", bill.waiter]];
            [print addLine:@""];
            [print addLine:[NSString stringWithFormat:@"品名                单价    份数   总价"]];
            [print addSplit];
            for (DAOrder *order in list.items) {
                if ([order.back integerValue] == 3) {
                    [freeOrderList addObject:order];
                } else if ([order.back integerValue] == 2) {
                    [backOrderList addObject:order];
                } else if ([order.back integerValue] == 1) {
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
                NSString *tmpOffStr = [NSString stringWithFormat:@"%.01f", tmpOff];

                [print addLine:[NSString stringWithFormat:@"折扣:%@折", tmpOffStr]];
            }

            [print addLine:[NSString stringWithFormat:@"应支付金额:%.02f元", [pay floatValue]]];
            [print addLine:[NSString stringWithFormat:@"优惠:%.02f元", [reduce floatValue]]];

            [print addLine:[NSString stringWithFormat:@"实际金额:%.02f元", [userPay floatValue]]];
            [print addLine:@""];
            [print addLine:@""];
            [print addLine:@"促销活动酒水、主食、个别菜不打折"];


            DAPrinter *billprint = [[DAPrinter alloc] unarchiveObjectWithFileWithPath:@"printer" withName:@"billprinter"];
            if (billprint != nil && billprint.printerIP != nil && billprint.printerIP.length > 0) {
                int status = -1;
                int times = 0;
                do {
                    status = [print printText:billprint.printerIP addTextSize:1 TextHeight:1];
                    NSLog(@"打印  times %d", times++);
                    if (times > 1) {
                        break;
                    } else {
                        [NSThread sleepForTimeInterval:0.5f];
                    }
                } while (status == -2);


                NSLog(@"打印机状态 判断是否成功   : %d", status);
            } else {

                NSLog(@"没有链接订单打印机");
                [ProgressHUD showError:@"没有链接订单打印机"];

            }
            if (progress != nil) {
                [progress hide:YES];
            }
        }];
    }];
}

- (void)initTimer {
    _timer = [NSTimer
            scheduledTimerWithTimeInterval:1
                                    target:self
                                  selector:@selector(timerTick:)
                                  userInfo:nil
                                   repeats:YES];
}

- (void)doPrint {
    [_timer fire];
}

- (void)distoryTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)timerTick:(NSTimer *)timer {
    if ([[[NSDate alloc] init] timeIntervalSinceDate:_timerStart] > LOCK_TIMEOUT) {
        DDLogWarn(@"加锁超时 打印机id:%@",_printer._id);
        NSLog(@"[%@]%@", _printer._id, @"lock printer timeout.");
        [self sendResult:PRINT_ERROR];
        [self distoryTimer];
    } else {
        [self tryPrint];
    }
}


- (void)sendResult:(int)result {
    NSDictionary *ntfObj = [NSDictionary
            dictionaryWithObjectsAndKeys:_printer._id, @"printerId", [NSString stringWithFormat:@"%d", result], @"result", nil];
    NSNotification *addOrderNotification = [NSNotification notificationWithName:@"print_callback" object:ntfObj];
    [[NSNotificationCenter defaultCenter] postNotification:addOrderNotification];

}

- (void)tryPrint {
    if (requestPendding) {
        return;
    }
    requestPendding = YES;
    NSString *path = [NSString stringWithFormat:API_PRINTER_LOCK, _printer._id, @"1", [OpenUDID value]];
    DDLogWarn(@"发起加锁申请[%@]",path);
    [self lockPrinterWithPath:path callback:^(BOOL result) {
        requestPendding = NO;
        if (result) {
            [self distoryTimer];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSLog(@"[%@][type:%d]%@", _printer._id, _type, @"print start");
                DDLogWarn(@"类型%d的打印机%@开始打印",_type,_printer._id);

                int result = PRINT_ERROR;
                if (_type == BILLING_PRINT) {

                    result = [self printText:_printer.printerIP
                                 addTextSize:2
                                  TextHeight:2];

                } else {

                    result = [self printOrderText:_printer.printerIP
                                        linesList:_ticketLineList
                                      addTextSize:2
                                       TextHeight:3];

                }
                NSLog(@"[%@][type:%d]%@ with result: %d", _printer._id, _type, @"print done", result);
                DDLogWarn(@"类型%d的打印机%@打印结束,结果%d",_type,_printer._id,result);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self sendResult:result];
                    [self releaseLockWithPrinter:_printer];
                });

            });

        }
    }];
}

- (void)lockPrinterWithPath:(NSString *)path callback:(void (^)(BOOL result))callback {

    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        if ([[[responseObject objectForKey:@"data"] objectForKey:@"result"] isEqualToString:@"success"]) {
            DDLogWarn(@"加锁成功[%@]",path);
            NSLog(@"[%@] path :%@", path, @"lock success");
            callback(YES);

        } else {
            DDLogWarn(@"加锁失败[%@]",path);
            NSLog(@"[%@] path :%@", @"lock failed", path);
            callback(NO);

        }
    }                              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"[%@] path :%@", @"lock request failed", path);
        NSLog(@"error:%@", error);
        DDLogWarn(@"加锁请求失败[%@]",path);

        callback(NO);
    }];
}

- (void)releaseLockWithPrinter:(DAPrinter *)printer {
    NSString *path = [NSString stringWithFormat:API_PRINTER_LOCK, printer._id, @"0", [OpenUDID value]];
    NSLog(@"[%@] path :%@", @"release lock", path);
    DDLogWarn(@"释放锁[%@]",path);
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

    }
                                   failure:^(AFHTTPRequestOperation *operation, NSError *error) {

                                   }];
}

+ (void)setBillingPrintData:(DAPrintProxy *)proxy now:(NSString *)now orderNum:(NSString *)orderNum deskName:(NSString *)deskName takeout:(NSString *)takeout tips:(NSString *)tips orderList:(DAMyOrderList *)orderList {
    [proxy addLine:[NSString stringWithFormat:@"流水单"]];

    if (takeout.length > 0) {
        [proxy addLine:[NSString stringWithFormat:@" 外卖  单号:%@ 时间：%@", orderNum, [Tool stringFromISODateString:now]]];
    } else {
        [proxy addLine:[NSString stringWithFormat:@"桌台:%@    ", deskName]];
        [proxy addLine:[NSString stringWithFormat:@"单号:%@    ", orderNum]];
        [proxy addLine:[NSString stringWithFormat:@"单时间：%@", [Tool stringFromISODateString:now]]];
    }

    if (tips.length > 0) {
        [proxy addLine:[NSString stringWithFormat:@"备注:%@  ", tips]];
    }
    [proxy addLine:[NSString stringWithFormat:@" "]];

    for (DAOrder *willOrder in orderList.items) {
        NSString *line;
        NSString *tmpAmount = [NSString stringWithFormat:@"%@", willOrder.amount];
        if ([willOrder.type integerValue] == 0) {
            line = [NSString stringWithFormat:@"%@  %@份  %@元", willOrder.item.itemName, tmpAmount, willOrder.item.itemPriceNormal];
        } else {
            line = [NSString stringWithFormat:@"%@ （小份）  %@份  %@元", willOrder.item.itemName, tmpAmount, willOrder.item.itemPriceHalf];
        }

        [proxy addLine:line];
    }
}

+ (int)addOrderPrintWithOrderList:(DAMyOrderList *)orderList deskName:(NSString *)deskName orderNum:(NSString *)orderNum now:(NSString *)now takeout:(NSString *)takeout tips:(NSString *)tips {

    int validPrinterCount = 0;

    DAPrinterList *printerList = [[DAPrinterList alloc]
            unarchiveObjectWithFileWithPath:@"printer"
                                   withName:@"printer"];
    if (printerList == nil || [printerList.items count] == 0) {
        return validPrinterCount;
    }


    //START  打印流水单
    if ([orderList.items count] > 0) {
        DAPrinter *billingPrinter = [[DAPrinter alloc]
                unarchiveObjectWithFileWithPath:@"printer"
                                       withName:@"billprinter"];

        DAPrintProxy *billingProxy = [[DAPrintProxy alloc]
                initWithPrinter:billingPrinter
                        andType:BILLING_PRINT];

        [self setBillingPrintData:billingProxy
                              now:now
                         orderNum:orderNum
                         deskName:deskName
                          takeout:takeout
                             tips:tips
                        orderList:orderList];

        validPrinterCount++;

        [billingProxy doPrint];

    }
    //END  打印流水单

    //分菜逻辑，构造每个打印机需要打印的数据
    NSMutableDictionary *SystemPrintSet = [[NSMutableDictionary alloc] init];
    for (DAPrinter *printerSet in printerList.items) {
        if ([printerSet.type isEqualToString:@"1"]) {
            NSMutableArray *printerOrderList = [[NSMutableArray alloc] init];
            [SystemPrintSet setObject:printerOrderList forKey:printerSet._id];
        }
    }

    for (DAOrder *willOrder in orderList.items) {
        if (willOrder.item.printerId != nil && willOrder.item.printerId.length > 0) {
            NSMutableArray *printerOrderList = [SystemPrintSet objectForKey:willOrder.item.printerId];
            [printerOrderList addObject:willOrder];
            [SystemPrintSet setObject:printerOrderList forKey:willOrder.item.printerId];
        }
    }
    //END分菜逻辑

    //START 后厨打印
    for (DAPrinter *printer in printerList.items) {

        //打印类型(printer.type) 1:厨房打印 2：结账打印
        if ([printer.type isEqualToString:@"1"]) {

            NSMutableArray *printerOrderList = [SystemPrintSet objectForKey:printer._id];

            if ([printerOrderList count] > 0 && [printer.need intValue] == 1) {

                NSMutableArray *printLines = [self
                        getOrderLineList:deskName
                                orderNum:orderNum
                                     now:now
                                 takeout:takeout
                                    tips:tips
                        printerOrderList:printerOrderList];

                DAPrintProxy *printProxy = [[DAPrintProxy alloc]
                        initWithPrinter:printer
                          andTicketData:printLines];

                validPrinterCount++;

                [printProxy doPrint];
            }
        }
    }
    //END  后厨打印

    return validPrinterCount;

}


+ (NSMutableArray *)getOrderLineList:(NSString *)deskName orderNum:(NSString *)orderNum now:(NSString *)now takeout:(NSString *)takeout tips:(NSString *)tips printerOrderList:(NSMutableArray *)printerOrderList {
    NSMutableArray *tmpOrderPrintList = [[NSMutableArray alloc] init];
    //START  后厨打印
    NSMutableArray *tmpOrderCheckPrintLine = [[NSMutableArray alloc] init];


    [tmpOrderCheckPrintLine addObject:[NSString stringWithFormat:@"后厨核对单"]];
    if (takeout.length > 0) {
        [tmpOrderCheckPrintLine addObject:[NSString stringWithFormat:@" 外卖  单号:%@ 时间：%@", orderNum, [Tool stringFromISODateString:now]]];
    } else {
        [tmpOrderCheckPrintLine addObject:[NSString stringWithFormat:@"单号:%@    %@ ", orderNum, deskName]];
        [tmpOrderCheckPrintLine addObject:[NSString stringWithFormat:@"单时间：%@", [Tool stringFromISODateString:now]]];
    }

    if (tips.length > 0) {
        [tmpOrderCheckPrintLine addObject:[NSString stringWithFormat:@"备注:%@  ", tips]];
    }

    [tmpOrderCheckPrintLine addObject:[NSString stringWithFormat:@" "]];

    for (DAOrder *willOrderA in printerOrderList) {
        NSString *line;
        NSString *tmpAmount = [NSString stringWithFormat:@"%@", willOrderA.amount];
        if ([willOrderA.type integerValue] == 0) {
            line = [NSString stringWithFormat:@"%@  %@份 ", willOrderA.item.itemName, tmpAmount];
        } else {
            line = [NSString stringWithFormat:@"%@ （小份）  %@份 ", willOrderA.item.itemName, tmpAmount];
        }

        [tmpOrderCheckPrintLine addObject:line];
    }
    [tmpOrderPrintList addObject:tmpOrderCheckPrintLine];

    for (DAOrder *willOrder in printerOrderList) {
        NSMutableArray *tmpOrderPrintLine = [[NSMutableArray alloc] init];

        if (takeout.length > 0) {
            [tmpOrderPrintLine addObject:[NSString stringWithFormat:@" 外卖  单号:%@ 时间：%@", orderNum, [Tool stringFromISODateString:now]]];
        } else {
            [tmpOrderPrintLine addObject:[NSString stringWithFormat:@"单号:%@    %@ ", orderNum, deskName]];
            [tmpOrderPrintLine addObject:[NSString stringWithFormat:@"单时间：%@", [Tool stringFromISODateString:now]]];
        }

        if (tips.length > 0) {
            [tmpOrderPrintLine addObject:[NSString stringWithFormat:@"备注:%@  ", tips]];
        }

        [tmpOrderPrintLine addObject:[NSString stringWithFormat:@" "]];

        NSString *line;

        if ([willOrder.type integerValue] == 0) {
            line = [NSString stringWithFormat:@"%@  %@份 ", willOrder.item.itemName, willOrder.amount];
        } else {
            line = [NSString stringWithFormat:@"%@ （小份）  %@份 ", willOrder.item.itemName, willOrder.amount];
        }

        [tmpOrderPrintLine addObject:line];
        [tmpOrderPrintList addObject:tmpOrderPrintLine];

    }
    return tmpOrderPrintList;
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

//- (void)addLineBreak {
//    [lines addObject:@"\n"];
//}

- (void)addSplit {
    [self addSplit:48];
}

- (void)addSplit:(int)length {
    NSString *split = [@"" stringByPaddingToLength:length withString:@"-" startingAtIndex:0];
    [lines addObject:split];
}

- (EposPrint *)getPrinter:(NSString *)ip {
    EposPrint *printer = [[EposPrint alloc] init];

    // open
    int result = [printer openPrinter:EPOS_OC_DEVTYPE_TCP DeviceName:ip];
    if (result != EPOS_OC_SUCCESS) {
        return nil;
    }

    return printer;
}

- (int)printOrderText:(NSString *)ip linesList:(NSArray *)linesList addTextSize:(long)addTextSize TextHeight:(long)TextHeight {
    int result = -1;
    // create builder
    EposBuilder *builder = [[EposBuilder alloc] initWithPrinterModel:PRINT_NAME Lang:EPOS_OC_MODEL_CHINESE];
    if (builder == nil) {
        return PRINT_ERROR;
    }

    //设置语言
    result = [builder addTextLang:EPOS_OC_LANG_ZH_CN];

    if (result != EPOS_OC_SUCCESS) {
        return PRINT_ERROR;
    }

    //设置文字
    result = [builder addTextFont:EPOS_OC_FONT_A];
    if (result != EPOS_OC_SUCCESS) {
        return PRINT_ERROR;
    }

    result = [builder addTextSize:addTextSize Height:TextHeight];
    if (result != EPOS_OC_SUCCESS) {
        return PRINT_ERROR;
    }

    for (int i = 0; i < [linesList count]; i++) {
        NSArray *tempList = [linesList objectAtIndex:i];
        if (i == 0) {
            result = [builder addTextSize:1 Height:1];
            if (result != EPOS_OC_SUCCESS) {
                return PRINT_ERROR;
            }
        } else {
            result = [builder addTextSize:addTextSize Height:TextHeight];
            if (result != EPOS_OC_SUCCESS) {
                return PRINT_ERROR;
            }
        }


        for (NSString *str in tempList) {
            NSLog(@"%@", str);
            result = [builder addText:[str stringByAppendingString:@"\n"]];
            if (result != EPOS_OC_SUCCESS) {
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
    NSLog(@"send data  %d", result);
    if (result != EPOS_OC_SUCCESS) {
        return PRINT_ERROR;
    }

    // remove builder
    [builder clearCommandBuffer];//状态？

    [printer closePrinter];
    //TODO


    return PRINT_SUCCESS;

}

- (int)printText:(NSString *)ip addTextSize:(long)addTextSize TextHeight:(long)TextHeight {
    // create builder
    EposBuilder *builder = [[EposBuilder alloc] initWithPrinterModel:PRINT_NAME Lang:EPOS_OC_MODEL_CHINESE];
    if (builder == nil) {
        return PRINT_ERROR;
    }


    //add command
    int result = [builder addTextLang:EPOS_OC_LANG_ZH_CN];

    if (result != EPOS_OC_SUCCESS) {
        return PRINT_ERROR;
    }

    result = [builder addTextFont:EPOS_OC_FONT_A];
    if (result != EPOS_OC_SUCCESS) {

        return PRINT_ERROR;
    }

    result = [builder addTextSize:addTextSize Height:TextHeight];
    if (result != EPOS_OC_SUCCESS) {
        return PRINT_ERROR;
    }

    // print text
    for (NSString *line in lines) {
        result = [builder addText:[line stringByAppendingString:@"\n"]];
        if (result != EPOS_OC_SUCCESS) {
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
    if (result != EPOS_OC_SUCCESS) {
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
    NSLog(@"send data  %d", result);
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

//// convert EposPrint result to text
//- (NSString*)getEposResultText:(int)result
//{
//    switch(result){
//        case EPOS_OC_SUCCESS:
//            return @"SUCCESS";
//        case EPOS_OC_ERR_PARAM:
//            return @"ERR_PARAM";
//        case EPOS_OC_ERR_OPEN:
//            return @"ERR_OPEN";
//        case EPOS_OC_ERR_CONNECT:
//            return @"ERR_CONNECT";
//        case EPOS_OC_ERR_TIMEOUT:
//            return @"ERR_TIMEOUT";
//        case EPOS_OC_ERR_MEMORY:
//            return @"ERR_MEMORY";
//        case EPOS_OC_ERR_ILLEGAL:
//            return @"ERR_ILLEGAL";
//        case EPOS_OC_ERR_PROCESSING:
//            return @"ERR_PROCESSING";
//        case EPOS_OC_ERR_UNSUPPORTED:
//            return @"ERR_UNSUPPORTED";
//        case EPOS_OC_ERR_OFF_LINE:
//            return @"ERR_OFF_LINE";
//        case EPOS_OC_ERR_FAILURE:
//            return @"ERR_FAILURE";
//        default:
//            return [NSString stringWithFormat:@"%d", result];
//    }
//}
//
//// covnert EposPrint status to text
//- (NSString*)getEposStatusText:(unsigned long)status
//{
//    NSString *result = @"";
//
//    for(int bit = 0; bit < 32; bit++){
//        unsigned int value = 1 << bit;
//        if((value & status) != 0){
//            NSString *msg = @"";
//            switch(value){
//                case EPOS_OC_ST_NO_RESPONSE:
//                    msg = @"NO_RESPONSE";
//                    break;
//                case EPOS_OC_ST_PRINT_SUCCESS:
//                    msg = @"PRINT_SUCCESS";
//                    break;
//                case EPOS_OC_ST_DRAWER_KICK:
//                    msg = @"DRAWER_KICK";
//                    break;
//                case EPOS_OC_ST_OFF_LINE:
//                    msg = @"OFF_LINE";
//                    break;
//                case EPOS_OC_ST_COVER_OPEN:
//                    msg = @"COVER_OPEN";
//                    break;
//                case EPOS_OC_ST_PAPER_FEED:
//                    msg = @"PAPER_FEED";
//                    break;
//                case EPOS_OC_ST_WAIT_ON_LINE:
//                    msg = @"WAIT_ON_LINE";
//                    break;
//                case EPOS_OC_ST_PANEL_SWITCH:
//                    msg = @"PANEL_SWITCH";
//                    break;
//                case EPOS_OC_ST_MECHANICAL_ERR:
//                    msg = @"MECHANICAL_ERR";
//                    break;
//                case EPOS_OC_ST_AUTOCUTTER_ERR:
//                    msg = @"AUTOCUTTER_ERR";
//                    break;
//                case EPOS_OC_ST_UNRECOVER_ERR:
//                    msg = @"UNRECOVER_ERR";
//                    break;
//                case EPOS_OC_ST_AUTORECOVER_ERR:
//                    msg = @"AUTORECOVER_ERR";
//                    break;
//                case EPOS_OC_ST_RECEIPT_NEAR_END:
//                    msg = @"RECEIPT_NEAR_END";
//                    break;
//                case EPOS_OC_ST_RECEIPT_END:
//                    msg = @"RECEIPT_END";
//                    break;
//                case EPOS_OC_ST_BUZZER:
//                    break;
//                default:
//                    return [NSString stringWithFormat:@"%d", value];
//                    break;
//            }
//            if(msg.length != 0){
//                if(result.length != 0){
//                    result = [result stringByAppendingString:@"\n"];
//                }
//                result = [result stringByAppendingString:msg];
//            }
//        }
//    }
//
//    return result;
//}

- (int)printBackOrder:(DAPrintProxy *)print
            printList:(NSMutableDictionary *)printList
            printerId:(NSString *)printerId
             itemName:(NSString *)itemName
             deskName:(NSString *)deskName
           waiterName:(NSString *)waiterName
        willBackCount:(NSString *)willBackCount
              takeout:(NSString *)takeout
                  now:(NSString *)now {
    NSString *ip = [printList objectForKey:printerId];

    [print addLine:[NSString stringWithFormat:@"  退菜 "]];

    [print addLine:[NSString stringWithFormat:@"单时间：%@", [Tool stringFromISODateString:now]]];
    [print addLine:[NSString stringWithFormat:@" "]];

    NSString *line = [NSString stringWithFormat:@"%@  %@份 ", itemName, willBackCount];

    [print addLine:line];
    [print addLine:[NSString stringWithFormat:@" "]];
    [print printText:ip addTextSize:2 TextHeight:3];
    return 0;
}

+ (int)addOrderBackPrint:(NSArray *)backOrderList; {
    DAPrintProxy *print = [[DAPrintProxy alloc] init];

    DAPrinterList *printtList = [[DAPrinterList alloc] unarchiveObjectWithFileWithPath:@"printer" withName:@"printer"];
    if (printtList == nil || [printtList.items count] == 0) {
        [ProgressHUD showError:@"请设置打印机"];
        return -1;
    }

    NSMutableDictionary *SystemPrintSet = [[NSMutableDictionary alloc] init];
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
                     deskName:order.desk ? order.desk.name : @"外卖"
                   waiterName:order.createby
                willBackCount:order.willBackAmount
                      takeout:@""
                          now:order.createat];

    }

    return 0;
}


@end
