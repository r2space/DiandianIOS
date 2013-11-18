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
    DAMyTableViewController *viewController = [[DAMyTableViewController alloc] initWithNibName:@"DAMyTableViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushMenuBook:(id)sender {
    UIStoryboard *menubookStoryboard = [UIStoryboard storyboardWithName:@"DARootView" bundle:nil];
    UIViewController *menubookVC = [menubookStoryboard instantiateViewControllerWithIdentifier:@"menubookVC"];
    [self.navigationController pushViewController:menubookVC animated:YES];
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
