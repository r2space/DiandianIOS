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



@interface DARootViewController ()
{
    
    
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
	// Do any additional setup after loading the view.

    
//    DAMyBookViewController *my = [[DAMyBookViewController alloc] initWithNibName:@"DAMyBookViewController" bundle:nil];
//    [self addChildViewController:my];
//
//    [self.MenuGird addSubview:my.view];//添加到self.view
    
    DAMyMenuBookViewController *book = [[DAMyMenuBookViewController alloc] initWithNibName:@"DAMyMenuBookViewController" bundle:nil];
    [self addChildViewController:book];
    [self.MenuGird addSubview:book.view];//添加到self.view
    
    
    DAMyFilterViewController *filter = [[DAMyFilterViewController alloc] initWithNibName:@"DAMyFilterViewController" bundle:nil];
    [self addChildViewController:filter];
    [self.filerListView addSubview:filter.view];
    
    DAMyOrderViewController *orderView = [[DAMyOrderViewController alloc] initWithNibName:@"DAMyOrderViewController" bundle:nil];
    [self addChildViewController:orderView];
    [self.orderListView addSubview:orderView.view];
}

- (void)fadeInWorkstationMenu{
    
    //    CGPoint menuCenter = menuScrollView.center;
    
    [UIView animateWithDuration:0.5
                     animations:^(void){
                         //                         menuScrollView.center = CGPointMake(menuCenter.x + 171 , menuCenter.y );
                         self.orderListView.center = CGPointMake(148   , 384);
                         self.orderListView.frame = CGRectMake(0, 0, 296, 768);
                     }];
    
    
}

- (void)fadeOutWorkstationMenu{
    
    //    CGPoint menuCenter = menuScrollView.center;
    
    [UIView animateWithDuration:0.5
                     animations:^(void){
                         //                         menuScrollView.center = CGPointMake(menuCenter.x - 171 , menuCenter.y );
                         self.orderListView.center = CGPointMake(148   , 384);
                         self.orderListView.frame = CGRectMake(0, 0, 60, 768);
                     }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)fadeIn:(id)sender {
    [self fadeInWorkstationMenu];
}

- (IBAction)fadeOut:(id)sender {
    [self fadeOutWorkstationMenu];
}
@end
