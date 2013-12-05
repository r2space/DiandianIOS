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

#import "SmartSDK.h"

#import "ProgressHUD.h"

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

    loginViewController = [[DASettingViewController alloc] initWithNibName:nil bundle:nil];
    
    NSString *_username = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.diandian.username"];
    
    NSString *_password = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.diandian.password"];
    
    [[NSUserDefaults standardUserDefaults]  setObject:@"NO" forKey:@"jp.co.dreamarts.smart.diandian.isLogin"];
    
    
    if (_username.length == 0 || _password.length == 0) {
        
    } else {
        [[DALoginModule alloc]yukarilogin:_username password:_password code:nil callback:^(NSError *error, DAUser *user) {
            
            if (error != nil) {
                [[NSUserDefaults standardUserDefaults]  setObject:@"NO" forKey:@"jp.co.dreamarts.smart.diandian.isLogin"];
                return ;
            }
            NSLog(@"用户自动登录");
            
            [[NSUserDefaults standardUserDefaults]  setObject:@"YES" forKey:@"jp.co.dreamarts.smart.diandian.isLogin"];
            
            [[NSUserDefaults standardUserDefaults] setValue:user._id forKey:@"jp.co.dreamarts.smart.diandian.userId"];
            
            [[NSUserDefaults standardUserDefaults] setValue:user._id forKey:@"jp.co.dreamarts.smart.diandian.curWaitterUserId"];
            
            [[NSUserDefaults standardUserDefaults] setValue:user.userName forKey:@"jp.co.dreamarts.smart.diandian.curWaitterUserName"];
            //自动登录
            DAMyTableViewController *viewController = [[DAMyTableViewController alloc] initWithNibName:@"DAMyTableViewController" bundle:nil];
            [self.navigationController pushViewController:viewController animated:NO];

        }];
    }
    
    
    [self fetch];
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
    // is not logged in
    loginViewController.startupBlock=^(){
        DAMyTableViewController *viewController = [[DAMyTableViewController alloc] initWithNibName:@"DAMyTableViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
    };
    // init navigation ctrl
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
    
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (IBAction)toTable:(id)sender {
    DAMyTableViewController *viewController = [[DAMyTableViewController alloc] initWithNibName:@"DAMyTableViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}
- (IBAction)showBill:(id)sender {
    DABillViewController *viewController = [[DABillViewController alloc] initWithNibName:@"DABillViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)showOrderQueue:(id)sender {
    DAOrderQueueViewController *viewController = [[DAOrderQueueViewController alloc] initWithNibName:@"DAOrderQueueViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}
@end
