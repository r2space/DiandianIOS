//
//  DABillViewController.m
//  DiandianIOS
//
//  Created by kita on 13-11-9.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DABillViewController.h"
#import "DABillDetailViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "DAPreferentialViewController.h"
#import "DAPrintProxy.h"
#import "ProgressHUD.h"
#import "MBProgressHUD.h"

#define kMaxNumber                       100000

@interface DABillViewController ()
{
    NSMutableArray *btnList;
    DABill *billData;
    NSInteger *payType;
    float offAmount;
    BOOL hasLoad;
    BOOL hasPrint;
    MBProgressHUD       *progress;  // 消息框
}
@end

@implementation DABillViewController
{
    NSMutableArray *finishList;
    NSMutableArray *cancelList;
}

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
    // Do any additional setup after loading the view from its nib.
    hasLoad = NO;
    hasPrint = NO;
    finishList = [[NSMutableArray alloc] init];
    cancelList = [[NSMutableArray alloc] init];
    payType = 0;
    offAmount = 1.0;
//    self.textOff.text = @"1";
    self.textReduce.text = @"0";
    
    

    [self initTopmenu];
    self.keyboardView = [[ZenKeyboard alloc] initWithFrame:self.viewKeyboard.frame];
    [self.view addSubview:self.keyboardView];
    self.keyboardView.textField = self.textPay;
    
    self.textPay.inputView=[[UIView alloc]initWithFrame:CGRectZero];
//    self.textOff.inputView=[[UIView alloc]initWithFrame:CGRectZero];
    self.textReduce.inputView=[[UIView alloc]initWithFrame:CGRectZero];
    NSNumber *hasCash = [[NSUserDefaults standardUserDefaults]objectForKey:@"jp.co.dreamarts.smart.diandian.curWaitterHasCash"];
    if (hasCash!=nil && [hasCash boolValue]) {
        [self.btnBill setHidden:NO];
    } else {
        [self.btnBill setHidden:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self reload];

}


- (void) initTopmenu
{
    self.viewTopmenuLabel.layer.cornerRadius = 15.0;
    self.viewTopmenuLabel.layer.masksToBounds = YES;
    
    
    self.viewTopmenu.layer.shadowColor = UIColor.blackColor.CGColor;
    self.viewTopmenu.layer.shadowRadius = 2;
    self.viewTopmenu.layer.shadowOpacity = 0.6;
    self.viewTopmenu.layer.shadowOffset = CGSizeMake(0, 1);
    
    btnList =  [[NSMutableArray alloc] init];
    [btnList addObject:[self.view viewWithTag:100]];
    
    [btnList addObject:[self.view viewWithTag:203]];
    
    for (UIButton *btn in btnList) {
        btn.layer.shadowColor = UIColor.blackColor.CGColor;
        btn.layer.shadowRadius = 2;
        btn.layer.shadowOpacity = 0.6;
        btn.layer.shadowOffset = CGSizeMake(0, 1);
    }
    
}

-(void)reload
{
    [[DAServiceModule alloc]getBillByServiceId:self.curService._id callback:^(NSError *err, DABill *bill) {
        billData = bill;
        self.lblTotal.text = [NSString stringWithFormat:@"%.02f元",[bill.amount floatValue]];
        //判断是否是  外卖
        if ([self.curService.type integerValue] == 3) {
            self.lblDeskName.text = [NSString stringWithFormat:@"外卖"];
        } else {
            self.lblDeskName.text = [NSString stringWithFormat:@"桌号：%@",bill.desk.name];
        }

        float tmpTotalAmount = 0.0f;
        float tmpDisCountAmount = 0.0f;
        float tmpunDisCountAmount = 0.0f;
        for (DAOrder *order in billData.items) {
            if ([order.back intValue] == 3) {
                
                
            } else if ([order.back intValue] == 2){
                if ([order.discount intValue] == 1) {
                    NSLog(@"打折");
                    tmpDisCountAmount = tmpDisCountAmount - [order.amountPrice floatValue];
                } else {
                    tmpunDisCountAmount = tmpunDisCountAmount - [order.amountPrice floatValue];
                    NSLog(@"不打折");
                }
                tmpTotalAmount = tmpTotalAmount - [order.amountPrice floatValue];
            } else {
                if ([order.discount intValue] == 1) {
                    tmpDisCountAmount = tmpDisCountAmount + [order.amountPrice floatValue];
                    NSLog(@"打折");
                } else {
                    tmpunDisCountAmount = tmpunDisCountAmount + [order.amountPrice floatValue];
                    NSLog(@"不打折");
                }
            }
            
        }

        tmpTotalAmount = tmpDisCountAmount * offAmount + tmpunDisCountAmount - [self.textReduce.text floatValue];
        
        self.lblPay.text = [NSString stringWithFormat:@"%.02f元 ",[self parseFloatValue:tmpTotalAmount]];
        self.textPay.text = [NSString stringWithFormat:@"%.02f", [self parseFloatValue:tmpTotalAmount]];
        hasLoad = YES;
    }];
    
}

-(float) parseFloatValue:(float)value
{
    int tmp = (int)value;
    if (tmp < value) {
        tmp = tmp + 1;
    }
    NSString *tmpSting = [NSString stringWithFormat:@"%d",tmp];
    NSString *result = [NSString stringWithFormat:@"%@.00",tmpSting];
    NSLog(@"%@",result);
    return [result floatValue];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)onDetailTaped:(id)sender {
    DABillDetailViewController *c = [[DABillDetailViewController alloc] initWithNibName:nil bundle:nil];
    c.curService = self.curService;
    c.offAmount = [NSString stringWithFormat:@"%f",offAmount];
    c.payAmount = self.lblPay.text;
    c.userPayAmount = self.textPay.text;
    c.reduceAmount = self.textReduce.text;
    c.parentReloadBlock = ^(){
        [self reload];
    };
    
    c.chanelBlock = ^() {
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    };

    [self presentPopupViewController:c animationType:MJPopupViewAnimationFade dismissed:^{
        [self reload];
    }];
}
- (IBAction)onPreferentialTouched:(id)sender {

    DAPreferentialViewController *c = [[DAPreferentialViewController alloc] initWithNibName:@"DAPreferentialViewController" bundle:nil];
    c.chanelBlock = ^() {
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    };
    
    [self presentPopupViewController:c animationType:MJPopupViewAnimationFade dismissed:^{
        [self reload];
    }];
}

- (IBAction)onBeginEditing:(id)sender {
    UITextField *text = (UITextField *)sender;
    self.keyboardView.num = [[NSMutableString alloc] init];
    self.keyboardView.textField  = text;
}
- (IBAction)onStopBillTouched:(id)sender {

    if(!hasLoad) {
        [ProgressHUD showError:@"等待加载。"];
        return;
    }
    
    if (!hasPrint) {
        [ProgressHUD showError:@"请打印订单"];
        return;
    }
    
    NSNumber *hasCash = [[NSUserDefaults standardUserDefaults]objectForKey:@"jp.co.dreamarts.smart.diandian.curWaitterHasCash"];

    if (!(hasCash != nil && [hasCash boolValue])) {
        [ProgressHUD showError:@"只有后厨才能上菜"];
        return;
    }
    
    [[DAServiceModule alloc]stopService:self.curService._id
                                 amount:[billData.amount stringValue]
                                 profit:self.lblPay.text
                                   agio:[NSString stringWithFormat:@"%f",offAmount]
                                userPay:self.textPay.text
                           preferential:self.textReduce.text
                                payType:[NSString stringWithFormat:@"%d" ,(int)payType]
                               callback:^(NSError *err, DAService *service)
                                    {
                                        
                                        NSLog(@"billNum: %@",service.billNum);
                                        if (err!=nil || service == nil || service.billNum == nil) {
                                            [ProgressHUD showError:@"网络连接失败，请重新打印。"];
                                            return;
                                        }                                        [self showIndicator:@"等待打印"];
                                        [DAPrintProxy printBill:self.curService._id off:[NSString stringWithFormat:@"%f",offAmount] pay:self.lblPay.text userPay:self.textPay.text type:payType reduce:self.textReduce.text seq:service.billNum progress:progress];
                                        
                                        [self.navigationController popViewControllerAnimated:YES];
                                    }];
}

- (IBAction)onChangeOff:(id)sender {

    float off = [billData.amount floatValue] * offAmount - [self.textReduce.text floatValue];
    self.lblPay.text = [NSString stringWithFormat:@"%.02f元 ",off];
    self.textPay.text = [NSString stringWithFormat:@"%d", (int)off];
    
}


- (IBAction)onPayTypeTouched:(UISegmentedControl *)sender {
    NSInteger *Index = (NSInteger *)sender.selectedSegmentIndex;
    payType = Index;
    
}

- (IBAction)onBackTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onChangeOffTouched:(UISegmentedControl *)sender {
    int index = (int)sender.selectedSegmentIndex;
    
    if (index == 0) {
        offAmount = 1.0;
    }
    
    if (index == 1) {
        offAmount = 0.88;
    }
    
    if (index == 2) {
        offAmount = 0.8;
    }
    
    if (index == 3) {
        offAmount = 0.5;
    }
    float tmpTotalAmount = 0.0f;
    float tmpDisCountAmount = 0.0f;
    float tmpunDisCountAmount = 0.0f;
    for (DAOrder *order in billData.items) {
        if ([order.back intValue] == 3) {
            
            
        } else if ([order.back intValue] == 2){
            if ([order.discount intValue] == 1) {
                NSLog(@"打折");
                tmpDisCountAmount = tmpDisCountAmount - [order.amountPrice floatValue];
            } else {
                tmpunDisCountAmount = tmpunDisCountAmount - [order.amountPrice floatValue];
                NSLog(@"不打折");
            }
            tmpTotalAmount = tmpTotalAmount - [order.amountPrice floatValue];
        } else {
            if ([order.discount intValue] == 1) {
                tmpDisCountAmount = tmpDisCountAmount + [order.amountPrice floatValue];
                NSLog(@"打折");
            } else {
                tmpunDisCountAmount = tmpunDisCountAmount + [order.amountPrice floatValue];
                NSLog(@"不打折");
            }
        }
        
    }
    
    tmpTotalAmount = tmpDisCountAmount * offAmount + tmpunDisCountAmount - [self.textReduce.text floatValue];
    
    self.lblPay.text = [NSString stringWithFormat:@"%.02f元 ",[self parseFloatValue:tmpTotalAmount]];
    self.textPay.text = [NSString stringWithFormat:@"%.02f", [self parseFloatValue:tmpTotalAmount]];
}

- (IBAction)onPrintTouched:(id)sender {
    
    NSString *offAmountStr = [NSString stringWithFormat:@"%f",offAmount];
    NSString *payAmount = self.lblPay.text;
    NSString *userPayAmount = self.textPay.text;
    NSString *reduceAmount = self.textReduce.text;
    [self showIndicator:@"等待打印"];
    
    [DAPrintProxy printBill:self.curService._id off:offAmountStr pay:payAmount userPay:userPayAmount  type:0 reduce:reduceAmount seq:@"-1" progress:progress];
    hasPrint = YES;
}

- (void)showIndicator:(NSString *)message
{
    progress = [MBProgressHUD showHUDAddedTo:self.view.window.rootViewController.view animated:YES];
    progress.mode = MBProgressHUDModeIndeterminate;
    progress.labelText = message;
    progress.color = [UIColor colorWithRed:102.0f/255.0f green:0.0f/255.0f blue:204.0f/255.0f alpha:1.0f];
    [progress show:YES];
}

@end
