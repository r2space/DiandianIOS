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


@interface DAViewController ()

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
	// Do any additional setup after loading the view.
//    DAMyTableViewController *viewController = [[DAMyTableViewController alloc] initWithNibName:@"DAMyTableViewController" bundle:nil];
//    [self.navigationController pushViewController:viewController animated:NO];
    [self fetch];
}

- (void) fetch
{
    [DADeskProxy initApp];
    
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
    DASettingViewController *loginViewController = [[DASettingViewController alloc] initWithNibName:nil bundle:nil];
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
