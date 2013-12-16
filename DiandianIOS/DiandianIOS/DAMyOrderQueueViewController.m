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
#import "SMVerticalSegmentedControl.h"
#define UI_COLOR_FROM_RGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



@interface DAMyOrderQueueViewController ()

@property (nonatomic, retain) SMVerticalSegmentedControl *segmentedControl;

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
    
    [itemListViewController.view setFrame:self.imageItemblockView.frame];
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
    
    [orderGroupViewController.view setFrame:self.imageTableblockView.frame];
    [self addChildViewController:orderGroupViewController];
    [self.view addSubview:orderGroupViewController.view];
    [orderGroupViewController didMoveToParentViewController:self];
    

    self.imageCategoryView.layer.shadowColor = UIColor.blackColor.CGColor;
    self.imageCategoryView.layer.shadowRadius = 2;
    self.imageCategoryView.layer.shadowOpacity = 0.6;
    self.imageCategoryView.layer.shadowOffset = CGSizeMake(0, 1);
    
    
    
    NSArray *titles = @[@"菜类", @"凉菜", @"主食", @"酒水"];
    self.segmentedControl = [[SMVerticalSegmentedControl alloc] initWithSectionTitles:titles];
    self.segmentedControl.backgroundColor = [UIColor whiteColor];
    
    
    self.segmentedControl.selectionStyle = SMVerticalSegmentedControlSelectionStyleBox;
    self.segmentedControl.selectionIndicatorThickness = 4;
    [self.segmentedControl setFrame:CGRectMake(20, 44, 80.0f, 260.f)];

    
    self.segmentedControl.indexChangeBlock = ^(NSInteger index) {
    };
    
    self.labelTitle.layer.cornerRadius = 15.0;
    self.labelTitle.layer.masksToBounds = YES;
    
    
    self.topmenuView.layer.shadowColor = UIColor.blackColor.CGColor;
    self.topmenuView.layer.shadowRadius = 2;
    self.topmenuView.layer.shadowOpacity = 0.6;
    self.topmenuView.layer.shadowOffset = CGSizeMake(0, 1);

    
    self.btnBack.layer.shadowColor = UIColor.blackColor.CGColor;
    self.btnBack.layer.shadowRadius = 2;
    self.btnBack.layer.shadowOpacity = 0.6;
    self.btnBack.layer.shadowOffset = CGSizeMake(0, 1);
    
    self.btnDrink.layer.shadowColor = UIColor.blackColor.CGColor;
    self.btnDrink.layer.shadowRadius = 2;
    self.btnDrink.layer.shadowOpacity = 0.6;
    self.btnDrink.layer.shadowOffset = CGSizeMake(0, 1);
    
    self.btnFood.layer.shadowColor = UIColor.blackColor.CGColor;
    self.btnFood.layer.shadowRadius = 2;
    self.btnFood.layer.shadowOpacity = 0.6;
    self.btnFood.layer.shadowOffset = CGSizeMake(0, 1);
    
    self.btnItem.layer.shadowColor = UIColor.blackColor.CGColor;
    self.btnItem.layer.shadowRadius = 2;
    self.btnItem.layer.shadowOpacity = 0.6;
    self.btnItem.layer.shadowOffset = CGSizeMake(0, 1);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backTopMenuTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnBackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
