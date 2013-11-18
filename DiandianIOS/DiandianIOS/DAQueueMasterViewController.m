//
//  DAQueueMasterViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-15.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAQueueMasterViewController.h"
#import "DAItemViewController.h"
#import "DAOrderGroupViewController.h"
#import "DADrinkQueueViewController.h"


@interface DAQueueMasterViewController ()
{
    NSMutableArray *btnList ;
    DAItemViewController *orderGroupViewController;
    DADrinkQueueViewController *drinkChildView;
    
}
@end

@implementation DAQueueMasterViewController

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
    [self initTopmenu ];
    [self initItemListView];
}

- (void) initTopmenu
{
    self.viewTopmenuLabel.layer.cornerRadius = 15.0;
    self.viewTopmenuLabel.layer.masksToBounds = YES;
    
    
    self.viewTopmenu.layer.shadowColor = UIColor.blackColor.CGColor;
    self.viewTopmenu.layer.shadowRadius = 2;
    self.viewTopmenu.layer.shadowOpacity = 0.6;
    self.viewTopmenu.layer.shadowOffset = CGSizeMake(0, 1);
    
    btnList =  [[NSMutableArray alloc] init];
    [btnList addObject:[self.view viewWithTag:100]];
    [btnList addObject:[self.view viewWithTag:201]];
    
    [btnList addObject:[self.view viewWithTag:203]];
    
    for (UIButton *btn in btnList) {
        btn.layer.shadowColor = UIColor.blackColor.CGColor;
        btn.layer.shadowRadius = 2;
        btn.layer.shadowOpacity = 0.6;
        btn.layer.shadowOffset = CGSizeMake(0, 1);
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)drinkViewTouched:(id)sender {
    
    [orderGroupViewController.view removeFromSuperview];
    [self initDrinkListView];

}
- (IBAction)ItemViewTouched:(id)sender {
    [drinkChildView.view removeFromSuperview];
    [self initItemListView];
}

-(void) initDrinkListView
{
    
    
    drinkChildView = [[DADrinkQueueViewController alloc] initWithNibName:@"DADrinkQueueViewController" bundle:nil];
    
    [drinkChildView.view setFrame:self.viewMasterBlock.frame];
    [self addChildViewController:drinkChildView];
    [self.view addSubview:drinkChildView.view];
    

}

-(void) initItemListView
{
    orderGroupViewController = [[DAItemViewController alloc] initWithNibName:@"DAItemViewController" bundle:nil];
    
    [orderGroupViewController.view setFrame:self.viewMasterBlock.frame];
    [self addChildViewController:orderGroupViewController];
    [self.view addSubview:orderGroupViewController.view];
    
    
}

@end
