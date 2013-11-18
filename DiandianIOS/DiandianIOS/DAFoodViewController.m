//
//  DAFoodViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-15.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAFoodViewController.h"

@interface DAFoodViewController ()

@end

@implementation DAFoodViewController

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
    self.viewItemlist.layer.shadowColor = UIColor.blackColor.CGColor;
    self.viewItemlist.layer.shadowRadius = 2;
    self.viewItemlist.layer.shadowOpacity = 0.6;
    self.viewItemlist.layer.shadowOffset = CGSizeMake(0, 1);
    
    self.viewTablelist.layer.shadowColor = UIColor.blackColor.CGColor;
    self.viewTablelist.layer.shadowRadius = 2;
    self.viewTablelist.layer.shadowOpacity = 0.6;
    self.viewTablelist.layer.shadowOffset = CGSizeMake(0, 1);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
