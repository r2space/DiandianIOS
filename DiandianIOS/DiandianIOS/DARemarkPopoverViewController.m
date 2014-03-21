//
//  DARemarkPopoverViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-12.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DARemarkPopoverViewController.h"

@interface DARemarkPopoverViewController ()

@end

@implementation DARemarkPopoverViewController

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
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    DDLogWarn(@"didReceiveMemoryWarning  :  %@" ,[self class]);
}

@end
