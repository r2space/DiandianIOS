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
}


- (void)lockEntered:(NSString*)key {
    NSString *WaitterId = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.diandian.curWaitterUserId"];
    
    [[DALoginModule alloc]checkPattern:key userId:WaitterId callback:^(NSError *error, NSDictionary *user) {
        
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

@end
