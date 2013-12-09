//
//  DAItemViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-15.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAItemViewController.h"
#import "DAQueueItemTableViewController.h"
#import "DAQueueItemListViewController.h"
#import "DAQueueItemListViewController.h"
#import "DAOrderGroupViewController.h"
#import "ProgressHUD.h"

static DAQueueItemListViewController *vc;
static DAQueueItemTableViewController *vct;

@interface DAItemViewController ()
{
   
}

@end

@implementation DAItemViewController

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
    vct = [[DAQueueItemTableViewController alloc] initWithNibName:@"DAQueueItemTableViewController" bundle:nil];
    vc = [[DAQueueItemListViewController alloc] initWithNibName:@"DAQueueItemListViewController" bundle:nil];
    
    
    
    [self initLayer];
    [self initItemList];
    [self initTableList];

}


-(void)initItemList
{
    vc.view.frame = self.viewItemlist.frame;
    vc.selectItemBlock = ^(NSArray *orderIds,NSString *deskId){

        [vct filterTable:orderIds deskId:deskId];
    };
    [self addChildViewController:vc];
    [self.viewItemlist addSubview:vc.view];
    
}

-(void)initTableList
{
    vct.view.frame = CGRectMake(834, 10, 160.0, 668.0);
    vct.selectDeskBlock = ^(NSString *orderId,NSString *deskId){
        [vc filterItem:orderId tableNO:deskId];
    };
    [self addChildViewController:vct];
    [self.view addSubview:vct.view];
}

-(void)initLayer
{
    self.viewItemlist.layer.shadowColor = UIColor.blackColor.CGColor;
    self.viewItemlist.layer.shadowRadius = 2;
    self.viewItemlist.layer.shadowOpacity = 0.6;
    self.viewItemlist.layer.shadowOffset = CGSizeMake(0, 1);
    self.viewItemlist.backgroundColor = [UIColor clearColor];
    
    self.viewTablelist.layer.shadowColor = UIColor.blackColor.CGColor;
    self.viewTablelist.layer.shadowRadius = 2;
    self.viewTablelist.layer.shadowOpacity = 0.6;
    self.viewTablelist.layer.shadowOffset = CGSizeMake(0, 1);
    self.viewTablelist.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
