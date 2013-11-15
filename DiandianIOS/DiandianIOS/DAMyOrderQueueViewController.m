//
//  DAMyOrderQueueViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-14.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAMyOrderQueueViewController.h"
#import "DAMyTableListViewController.h"
#import "DAOrderGroupViewController.h"
#import "DAMyItemListViewController.h"

@interface DAMyOrderQueueViewController ()

@end

@implementation DAMyOrderQueueViewController

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
    //
    DAMyItemListViewController *itemListViewController = [[DAMyItemListViewController alloc] initWithNibName:@"DAMyItemListViewController" bundle:nil];
    
    [itemListViewController.view setFrame:CGRectMake(100, 81, 734,651)];
    self.imageItemblockView.layer.shadowColor = UIColor.blackColor.CGColor;
    self.imageItemblockView.layer.shadowRadius = 2;
    self.imageItemblockView.layer.shadowOpacity = 0.6;
    self.imageItemblockView.layer.shadowOffset = CGSizeMake(0, 1);

    self.imageTableblockView.layer.shadowColor = UIColor.blackColor.CGColor;
    self.imageTableblockView.layer.shadowRadius = 2;
    self.imageTableblockView.layer.shadowOpacity = 0.6;
    self.imageTableblockView.layer.shadowOffset = CGSizeMake(0, 1);
    
    [self addChildViewController:itemListViewController];
    [self.view addSubview:itemListViewController.view];
    [itemListViewController didMoveToParentViewController:self];
    
    DAOrderGroupViewController *orderGroupViewController = [[DAOrderGroupViewController alloc] initWithNibName:@"DAOrderGroupViewController" bundle:nil];
    
    [orderGroupViewController.view setFrame:CGRectMake(844 , 81 , 160 , 651)];
    self.imageTableListView.layer.shadowColor = UIColor.blackColor.CGColor;
    self.imageTableListView.layer.shadowRadius = 2;
    self.imageTableListView.layer.shadowOpacity = 0.6;
    self.imageTableListView.layer.shadowOffset = CGSizeMake(0, 1);
    [self addChildViewController:orderGroupViewController];
    [self.view addSubview:orderGroupViewController.view];
    [orderGroupViewController didMoveToParentViewController:self];
    

    self.imageCategoryView.layer.shadowColor = UIColor.blackColor.CGColor;
    self.imageCategoryView.layer.shadowRadius = 2;
    self.imageCategoryView.layer.shadowOpacity = 0.6;
    self.imageCategoryView.layer.shadowOffset = CGSizeMake(0, 1);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backTopMenuTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
