//
//  DASaledViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-12-23.
//  Copyright (c) 2013年 DAC. All rights reserved.
//
#import "SmartSDK.h"
#import "DASaledViewController.h"
#import "DAMenuProxy.h"
#import "TMCache.h"
#import "DASoldButton.h"
#import "DASaledSeachViewController.h"
#import "DAItemListViewController.h"
#import "ProgressHUD.h"

@interface DASaledViewController ()
{
    DAItemList *dataList;
}
@end

@implementation DASaledViewController

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
    dataList = [[DAItemList alloc]init];
    dataList.items = [[NSArray alloc]init];
    [self initSeachView];
    [self initItemsView];
    
}
-(void)initSeachView
{
    DASaledSeachViewController *vct = [[DASaledSeachViewController alloc]initWithNibName:@"DASaledSeachViewController" bundle:nil];
    vct.view.frame = self.viewSearchPanel.frame;
    [self addChildViewController:vct];
    [self.view addSubview:vct.view];
    self.viewSearchPanel.backgroundColor = [UIColor clearColor];
}

-(void)initItemsView
{
    DAItemListViewController *vc = [[DAItemListViewController alloc]initWithNibName:@"DAItemListViewController" bundle:nil];
    vc.view.frame = self.viewItemList.frame;
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    self.viewItemList.backgroundColor = [UIColor clearColor];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
    

- (IBAction)onBackTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onRemoveAllSoldoutTouched:(id)sender {
    [[DAItemModule alloc ] removeAllSoldout:^(NSError *err, NSDictionary *sold) {
        [ProgressHUD showSuccess:@"已经全部清楚"];
        NSNotification *addOrderNotification = [NSNotification notificationWithName:@"DAItemListReload" object:nil];
        
        [[NSNotificationCenter defaultCenter] postNotification:addOrderNotification];
    }];
}
    

@end
