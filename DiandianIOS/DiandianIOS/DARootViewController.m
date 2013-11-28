//
//  DARootViewController.m
//  MenuBook
//
//  Created by Antony on 13-11-5.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DARootViewController.h"
#import "DABookCell.h"
#import "DAMyBookViewController.h"
#import "DAMyFilterViewController.h"
#import "DAMyOrderViewController.h"
#import "DAMyMenuBookViewController.h"

#import "SmartSDK.h"


@interface DARootViewController ()
{
    DAMyOrderViewController *orderView;
    
    //api
    DAMenuList *dataList;
    BOOL isAddItem;
}
@end

@implementation DARootViewController

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
    isAddItem = NO;
    if ([@"YES" isEqualToString:self.willAddItem]) {
        isAddItem = YES;
    }
    
    DAMyMenuBookViewController *book = [[DAMyMenuBookViewController alloc] initWithNibName:@"DAMyMenuBookViewController" bundle:nil];
    [self addChildViewController:book];
    [self.MenuGird addSubview:book.view];//添加到self.view
    self.MenuGird.layer.shadowColor = UIColor.blackColor.CGColor;
    self.MenuGird.layer.shadowRadius = 2;
    self.MenuGird.layer.shadowOpacity = 0.6;
    self.MenuGird.layer.shadowOffset = CGSizeMake(0, 1);
    
    DAMyFilterViewController *filter = [[DAMyFilterViewController alloc] initWithNibName:@"DAMyFilterViewController" bundle:nil];
    [self addChildViewController:filter];
    [self.filerListView addSubview:filter.view];
    
    
    
    orderView = [[DAMyOrderViewController alloc] initWithNibName:@"DAMyOrderViewController" bundle:nil];
    
    orderView.curService = self.curService;
    
    [self addChildViewController:orderView];
    [self.orderListView addSubview:orderView.view];
    self.orderListView.layer.shadowColor = UIColor.blackColor.CGColor;
    self.orderListView.layer.shadowRadius = 2;
    self.orderListView.layer.shadowOpacity = 0.6;
    self.orderListView.layer.shadowOffset = CGSizeMake(0, 1);
    

}

-(void)viewDidAppear:(BOOL)animated
{
    if (isAddItem) {
        [orderView loadOldItem];
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}





@end
