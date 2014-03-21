//
//  DADrinkQueueViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-15.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DADrinkQueueViewController.h"
#import "DAQueueDrinkListViewController.h"
#import "DAQueueDrinkTableViewController.h"

static DAQueueDrinkListViewController  *vc;
static DAQueueDrinkTableViewController *vct;

@interface DADrinkQueueViewController ()
{

}
@end

@implementation DADrinkQueueViewController

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
    [self initItemList];
    [self initTableList];

    
    
    
}

-(void)initItemList
{
    
    vc = [[DAQueueDrinkListViewController alloc] initWithNibName:@"DAQueueDrinkListViewController" bundle:nil];
    vc.itemClickCallback = ^(){
        [vct loadFromFile];
    };
    vc.view.frame = CGRectMake(0, 0, 814, 684);
    
    [self addChildViewController:vc];
    [self.viewItemlist addSubview:vc.view];
}


-(void)initTableList
{
    
    vct = [[DAQueueDrinkTableViewController alloc] initWithNibName:@"DAQueueItemTableViewController" bundle:nil];
    vct.deskClickCallback = ^(NSString *serviceId,NSString *deskId){
        [vc getQueueListWithServiceId:serviceId deskId:deskId];
    };
    vct.view.frame = CGRectMake(0, 0, 160.0, 668.0);
    [self addChildViewController:vct];
    [self.viewTablelist addSubview:vct.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    DDLogWarn(@"didReceiveMemoryWarning  :  %@" ,[self class]);
}

@end
