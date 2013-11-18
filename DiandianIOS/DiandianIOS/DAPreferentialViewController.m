//
//  DAPreferentialViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-17.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAPreferentialViewController.h"

@interface DAPreferentialViewController ()

@end

@implementation DAPreferentialViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onCancelTouched:(id)sender {
    if (self.chanelBlock) {
        self.chanelBlock();
    }
}

@end
