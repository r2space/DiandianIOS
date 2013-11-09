//
//  DAOrderQueueViewController.m
//  DiandianIOS
//
//  Created by LI LIN on 2013/11/09.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAOrderQueueViewController.h"
#import "DAOrderDetailViewController.h"
#import "DAOrderGroupViewController.h"

@interface DAOrderQueueViewController ()

@end

@implementation DAOrderQueueViewController

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

    //
    DAOrderDetailViewController *orderDetailViewController = [[DAOrderDetailViewController alloc] initWithNibName:@"DAOrderDetailViewController" bundle:nil];

    [orderDetailViewController.view setFrame:self.imgDetailView.frame];

    [self addChildViewController:orderDetailViewController];
    [self.view addSubview:orderDetailViewController.view];
    [orderDetailViewController didMoveToParentViewController:self];
    
    //
    DAOrderGroupViewController *orderGroupViewController = [[DAOrderGroupViewController alloc] initWithNibName:@"DAOrderGroupViewController" bundle:nil];
    
    [orderGroupViewController.view setFrame:self.imgGroupView.frame];
    
    [self addChildViewController:orderGroupViewController];
    [self.view addSubview:orderGroupViewController.view];
    [orderGroupViewController didMoveToParentViewController:self];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
