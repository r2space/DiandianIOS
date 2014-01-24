//
//  DAMyOrderLoginViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-13.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAMyOrderLoginViewController.h"
#import "DrawPatternLockViewController.h"
#import "ProgressHUD.h"
#import "SmartSDK.h"
#import "DAPrintProxy.h"


@interface DAMyOrderLoginViewController ()
{
    DrawPatternLockViewController *lockVC;
    UIPopoverController *popover;
    NSString *willSave;
    int errorCount;
    NSMutableArray *wDataList;
    
    NSString *curWaitterUserId;
}
@end

@implementation DAMyOrderLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = YES;
    
    
    self.labelName.delegate = self;
    
    lockVC = [[DrawPatternLockViewController alloc] init];
    willSave = [NSString stringWithFormat:@"confirm"];
    //判断输入三次返回
    errorCount = 0 ;
    self.labelName.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.diandian.curWaitterUserName"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    wDataList = [NSMutableArray array];
    
    [[DAUserModule alloc]getAllUserList:^(NSError *err, DAUserList *list) {
        for (DAUser *user in list.items) {
            [wDataList addObject:user];
        }
    }];

    [self openPrinter:@"192.168.1.122"];
}


- (void)lockEntered:(NSString*)key {
    NSString *WaitterId = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.diandian.curWaitterUserId"];
    
    [[DALoginModule alloc]checkPattern:key userId:WaitterId callback:^(NSError *error, NSDictionary *user) {
        if (error!=nil) {
            [ProgressHUD showError:@"服务器异常！"];
            [lockVC.view removeFromSuperview];
            return ;
        }
        NSNumber *isRight = [user objectForKey:@"isRight"];
        
        if (![isRight boolValue]) {
            errorCount++;
            [ProgressHUD showError:@"手势密码验证错误。"];
            if (errorCount == 3) {
                [lockVC.view removeFromSuperview];
            }

        } else {

            if ([willSave isEqualToString:@"confirm"]) {
                //验证后直接开台
                if (self.delegate && [self.delegate respondsToSelector:@selector(confirmOrderButtonClicked:)]) {
                    [self.delegate confirmOrderButtonClicked:self];
                }
                
            }
            if ([willSave isEqualToString:@"cancel"]) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(cancelOrderButtonClicked:)]) {
                    [self.delegate cancelOrderButtonClicked:self];
                }
                
            }
        }
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)confirmOrderTouched:(id)sender {
    if (self.curService != nil) {
        willSave = [NSString stringWithFormat:@"confirm"];
        errorCount = 0 ;
        [ProgressHUD showError:@"请验证手势密码"];
        [lockVC setTarget:self withAction:@selector(lockEntered:)];
        lockVC.view.frame = CGRectMake(0, 0, 556, 349);
        [self addChildViewController:lockVC];
        [self.view addSubview:lockVC.view];
    } else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(confirmOrderButtonClicked:)]) {
            [self.delegate confirmOrderButtonClicked:self];
        }
        
    }

}

- (IBAction)cancelOrderTouched:(id)sender {
    if (self.curService != nil) {
        
        willSave = [NSString stringWithFormat:@"cancel"];
        errorCount = 0;
        [ProgressHUD showError:@"请验证手势密码"];
        [lockVC setTarget:self withAction:@selector(lockEntered:)];
        lockVC.view.frame = CGRectMake(0, 0, 556, 349);
        [self addChildViewController:lockVC];
        [self.view addSubview:lockVC.view];
        
    } else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(cancelOrderButtonClicked:)]) {
            [self.delegate cancelOrderButtonClicked:self];
        }
    }
    
}

- (IBAction)backOrderTouched:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(backmenuButtonClicked:)]) {
        [self.delegate backmenuButtonClicked:self];
    }

}


- (BOOL) textFieldShouldBeginEditing: (UITextField *)textField
{
    DAPopTableViewController *vc = [[DAPopTableViewController alloc] initWithNibName:@"DAPopTableViewController" bundle:nil];
    
    
        [vc initData:@"user" list:wDataList];
        vc.delegate = self;
        
        popover = [[UIPopoverController alloc]initWithContentViewController:vc];
        popover.popoverContentSize = CGSizeMake(120, 400);
        [popover presentPopoverFromRect:textField.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

        
    
    return NO;
}

- (void)popTableViewSelectRow:(NSString *)tag value:(id)value
{
    DAUser *user  = value;
    self.labelName.text = user.name;
    self.curUserId = user._id;
    curWaitterUserId = user._id;
    
    [[NSUserDefaults standardUserDefaults] setValue:user._id forKey:@"jp.co.dreamarts.smart.diandian.curWaitterUserId"];
    
    [[NSUserDefaults standardUserDefaults] setValue:user.name forKey:@"jp.co.dreamarts.smart.diandian.curWaitterUserName"];
    
    
    
    [popover dismissPopoverAnimated:YES];
}
//打开打印机

- (void)openPrinter:(NSString *)ip
{
    //get open parameter
    if(ip.length == 0){
        return ;
    }
    
    //open
    EposPrint *printer = [[EposPrint alloc] init];
    if(printer == nil){
        return ;
    }
    delegate_ = self;
    int result = [printer openPrinter:EPOS_OC_DEVTYPE_TCP DeviceName:ip Enabled:EPOS_OC_TRUE Interval:2000];
    if(result != EPOS_OC_SUCCESS){
        printer = nil;
        return;
    }
    
    //return settings
    if(delegate_ != nil){
        
        [delegate_ onOpenPrinter:printer
                       ipaddress:ip
                     printername:@"TM-T81II"
                        language:EPOS_OC_MODEL_CHINESE];
        
    }
    
    
    
}

//called OpenView
- (void)onOpenPrinter:(EposPrint*)prn
            ipaddress:(NSString*)ipaddress
          printername:(NSString*)printername
             language:(int)language
{
    if(self.printer != nil){
            self.lblPrinter.text = @"self.printer != nil";
        [self.printer closePrinter];
    }
    self.printer = prn;
            self.lblPrinter.text = @"opened";
    [self.printer setStatusChangeEventCallback:@selector(onStatusChange:Status:) Target:self];
    [self.printer setBatteryStatusChangeEventCallback:@selector(onBatteryStatusChange:Battery:) Target:self];
}


- (void)onStatusChange:(NSString *)deviceName Status:(NSNumber *)status
{
    NSLog(@"onStatusChange :%@",[self getEposStatusText:(int)[status unsignedLongValue]]);
    self.lblPrinter.text = [self getEposStatusText:(int)[status unsignedLongValue]];
}

- (void)onBatteryStatusChange:(NSString *)deviceName Battery:(NSNumber *)battery
{
    NSLog(@"onBatteryStatusChange :%@",[self getEposStatusText:(int)[battery unsignedLongValue]]);
}


- (IBAction)onTestPrinter:(id)sender {
    [self showTextPrinter];
}
- (IBAction)onTestStatusPrinter:(id)sender {
    [self showPrinterStatus];
}

- (void)showTextPrinter
{
    
    EposBuilder *builder = [[EposBuilder alloc] initWithPrinterModel:@"TM-T81II" Lang:EPOS_OC_MODEL_CHINESE];
    
    int result = -1;
    //设置语言
    result = [builder addTextLang:EPOS_OC_LANG_ZH_CN];
    
    if(result != EPOS_OC_SUCCESS){
        NSLog(@"result : %@",[self getEposResultText:result]);
        return;
    }
    
    //设置文字
    result = [builder addTextFont:EPOS_OC_FONT_A];
    if(result != EPOS_OC_SUCCESS){
        NSLog(@"result : %@",[self getEposResultText:result]);
        return;
    }
    
    result = [builder addTextSize:2 Height:2];
    if(result != EPOS_OC_SUCCESS){
        NSLog(@"result : %@",[self getEposResultText:result]);
        return;
    }
    result = [builder addText:@"dfdf 123133333333333333333333333333333333333"];
    if(result != EPOS_OC_SUCCESS){
        NSLog(@"result : %@",[self getEposResultText:result]);
        return;
    }
    
    // feed
    result = [builder addFeedUnit:30];
    if(result != EPOS_OC_SUCCESS){
        NSLog(@"result : %@",[self getEposResultText:result]);
        return;
    }
    // cut
    result = [builder addCut:EPOS_OC_CUT_FEED];
    if (result != EPOS_OC_SUCCESS) {
        NSLog(@"result : %@",[self getEposResultText:result]);
        return;
    }
    
    unsigned long status = 0;
    unsigned long battery = 0;
    int errorResult = [self.printer sendData:builder Timeout:10*1000 Status:&status Battery:&battery];
    
    NSLog(@"result %@, status : %@",[self getEposResultText:errorResult],[self getEposStatusText:status]);
    self.lblPrinter.text = [self getEposResultText:errorResult];
    //remove builder
    [builder clearCommandBuffer];
}

- (void)showOrderPrinter
{
    //create builder
    EposBuilder *builder = [[EposBuilder alloc] initWithPrinterModel:@"TM-T81II" Lang:EPOS_OC_MODEL_CHINESE];
    if(builder == nil){
        return ;
    }
    
    unsigned long status = 0;
    unsigned long battery = 0;
    int result = [self.printer sendData:builder Timeout:10*1000 Status:&status Battery:&battery];
    
    NSLog(@"result %@, status : %@",[self getEposResultText:result],[self getEposStatusText:status]);
    
    self.lblPrinter.text = [self getEposResultText:result];
    //remove builder
    [builder clearCommandBuffer];
}

- (void)showPrinterStatus
{
    //create builder
    EposBuilder *builder = [[EposBuilder alloc] initWithPrinterModel:@"TM-T81II" Lang:EPOS_OC_MODEL_CHINESE];
    if(builder == nil){
        return ;
    }
    
    //send builder data(empty builder data)
    unsigned long status = 0;
    unsigned long battery = 0;
    int result = [self.printer sendData:builder Timeout:0 Status:&status Battery:&battery];

    NSLog(@"result %@, status : %@",[self getEposResultText:result],[self getEposStatusText:status]);

    //remove builder
    [builder clearCommandBuffer];

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
