//
//  DAViewController.m
//  MenuBook
//
//  Created by Antony on 13-11-5.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAViewController.h"
#import "DAOrderQueueViewController.h"
#import "DABillViewController.h"
#import "DAMyTableViewController.h"
#import "DAMenuProxy.h"

#import "DASettingViewController.h"
#import "DASaledViewController.h"
#import "DARootViewController.h"

#import "SmartSDK.h"

#import "ProgressHUD.h"
#import "DDLog.h"
static const int ddLogLevel = LOG_LEVEL_VERBOSE;

static DASettingViewController *loginViewController;
@interface DAViewController ()
{

}
@end

@implementation DAViewController

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
    [self fetch];
    loginViewController = [[DASettingViewController alloc] initWithNibName:nil bundle:nil];
    
    NSString *_username = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.diandian.username"];
    
    NSString *_password = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.diandian.password"];
    
    [[NSUserDefaults standardUserDefaults]  setObject:@"NO" forKey:@"jp.co.dreamarts.smart.diandian.isLogin"];
    
    if (_username.length == 0 || _password.length == 0) {
        [self showSettingView];
    } else {
        
        DAPrinterList *printList = [[DAPrinterList alloc] unarchiveObjectWithFileWithPath:@"printer" withName:@"printer"];
        if (printList == nil || [printList.items count] == 0) {
            return;
        }
        NSNumber *printerMaster = [[NSUserDefaults standardUserDefaults] objectForKey:@"com.diandain.printer.master"];
        if ([printerMaster boolValue]) {
            for (DAPrinter *printSet in printList.items) {
                if ([printSet.valid isEqualToNumber:[NSNumber numberWithInt:0]]) {
                    [ProgressHUD showError:[NSString stringWithFormat:@"请检查打印机 ：%@ 的状态" ,printSet.name]];
                    return;
                }
            }
        }
        
        NSString *keyStatus = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.diandian.curWaitterKeyStatus"];
        if (![@"YES" isEqualToString:keyStatus]) {
            return;
        }
        
        [[DALoginModule alloc]yukarilogin:_username password:_password code:nil callback:^(NSError *error, DAUser *user) {
            
            if (error != nil) {
                [[NSUserDefaults standardUserDefaults]  setObject:@"NO" forKey:@"jp.co.dreamarts.smart.diandian.isLogin"];
                return ;
            }
            
            [[NSUserDefaults standardUserDefaults]  setObject:@"YES" forKey:@"jp.co.dreamarts.smart.diandian.isLogin"];
            
            [[NSUserDefaults standardUserDefaults] setValue:user._id forKey:@"jp.co.dreamarts.smart.diandian.userId"];
            
            [[NSUserDefaults standardUserDefaults] setValue:user._id forKey:@"jp.co.dreamarts.smart.diandian.curWaitterUserId"];
            
            [[NSUserDefaults standardUserDefaults] setValue:user.userName forKey:@"jp.co.dreamarts.smart.diandian.curWaitterUserName"];
            
            [[NSUserDefaults standardUserDefaults] setValue:user.cash forKey:@"jp.co.dreamarts.smart.diandian.curWaitterHasCash"];
            //自动登录
            DAMyTableViewController *viewController = [[DAMyTableViewController alloc] initWithNibName:@"DAMyTableViewController" bundle:nil];
            [self.navigationController pushViewController:viewController animated:NO];
            [loginViewController dismissViewControllerAnimated:YES completion:nil];

        }];
    }
    
    
    
}

- (void) fetch
{
    [DADeskProxy initApp];
    
}
-(void) viewDidAppear:(BOOL)animated
{

    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushMenuBook:(id)sender {
    
    NSString *isLogin = [[NSUserDefaults standardUserDefaults]  objectForKey:@"jp.co.dreamarts.smart.diandian.isLogin"];
    if ([@"YES" isEqualToString: isLogin]) {
        DAMyTableViewController *viewController = [[DAMyTableViewController alloc] initWithNibName:@"DAMyTableViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:NO];
    } else {
        [ProgressHUD showError:@"请登录。"];
    }
    
}

- (IBAction)onStartTouched:(id)sender {
    [self showSettingView];
}

- (void) showSettingView
{
    // is not logged in
    loginViewController.startupBlock=^(){
        DAMyTableViewController *viewController = [[DAMyTableViewController alloc] initWithNibName:@"DAMyTableViewController" bundle:nil];

        DDLogWarn(@"进入桌台页面");

        [self.navigationController pushViewController:viewController animated:YES];

        [loginViewController dismissViewControllerAnimated:YES completion:nil];
        
    };
    loginViewController.menuViewBlock = ^(){
        UIStoryboard *menubookStoryboard = [UIStoryboard storyboardWithName:@"DARootView" bundle:nil];
        DARootViewController *menubookVC = [menubookStoryboard instantiateViewControllerWithIdentifier:@"menubookVC"];
        menubookVC.curService = nil;
        menubookVC.willAddItem = @"NO";
        [self.navigationController pushViewController:menubookVC animated:YES];
        [loginViewController dismissViewControllerAnimated:YES completion:nil];

        DDLogWarn(@"网络无法连接,直接进入桌台页面");

    };
    // init navigation ctrl
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
    
    [self presentViewController:navigationController animated:YES completion:nil];
}
    
- (IBAction)onSaledTouched:(id)sender {
    DASaledViewController *saledVC = [[DASaledViewController alloc] initWithNibName:@"DASaledViewController" bundle:nil];
    [self.navigationController pushViewController:saledVC animated:YES];
    NSLog(@"on saled touched");
}

@end
