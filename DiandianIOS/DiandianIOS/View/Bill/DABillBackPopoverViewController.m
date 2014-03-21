//
//  DABillBackPopoverViewController.m
//  DiandianIOS
//
//  Created by Antony on 14-1-14.
//  Copyright (c) 2014年 DAC. All rights reserved.
//

#import "DABillBackPopoverViewController.h"
#import "SmartSDK.h"
#import "ProgressHUD.h"
#import "DAPrintProxy.h"
#import "UIViewController+MJPopupViewController.h"


@interface DABillBackPopoverViewController ()
{
    DAOrder *order;
    NSMutableArray *dataList;
}
@end

@implementation DABillBackPopoverViewController

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

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    order = [self.backDataList objectAtIndex:0];
    dataList = [[NSMutableArray alloc]init];
    self.lblItemName.text = order.item.itemName;
    self.lblItemAmount.text = order.amount;
    self.lblItemBackAmount.text = [NSString stringWithFormat:@"%@",order.totalBackAmount];
    
    NSLog(@"%@",order.totalBackAmount);
    if ([order.totalBackAmount intValue] >= [order.amount intValue]) {
        self.textWillBackAmount.text = @"0";
        order.willBackAmount = @"0";
    } else {
        self.textWillBackAmount.text = @"0";
        order.willBackAmount = @"0";
    }
    [dataList addObject:order];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    DDLogWarn(@"didReceiveMemoryWarning  :  %@" ,[self class]);
}

- (IBAction)deleteTouched:(id)sender {
    NSString *tmpWillBackAmount = self.textWillBackAmount.text;
    
    NSString *tmpValue = [NSString stringWithFormat:@"%d",[tmpWillBackAmount intValue] - 1];
    int value = [tmpValue intValue];
    
    if (value < 0 ) {
        return;
    }
    
    self.textWillBackAmount.text = [NSString stringWithFormat:@"%d",value];
    order.willBackAmount = self.textWillBackAmount.text;
    dataList = [[NSMutableArray alloc]init];
    [dataList addObject:order];
}

- (IBAction)addTouched:(id)sender {
    NSString *tmpWillBackAmount = self.textWillBackAmount.text;
    NSString *tmpValue = [NSString stringWithFormat:@"%d",[tmpWillBackAmount intValue] + 1];
    int value = [tmpValue intValue];
    
    if (value - 1 >= [self.lblItemAmount.text intValue] - [self.lblItemBackAmount.text intValue] ) {
        return;
    }
    
    self.textWillBackAmount.text = [NSString stringWithFormat:@"%d",value];
    order.willBackAmount = self.textWillBackAmount.text;
    dataList = [[NSMutableArray alloc]init];
    [dataList addObject:order];
    
}

- (IBAction)confirmTouched:(id)sender {

    
    NSString *tmpWillBackAmount = self.textWillBackAmount.text;
    if ([tmpWillBackAmount intValue] <= 0) {
        [ProgressHUD showError:@"退菜数量不能是零"];
        return;
    }
    NSString *tmpValue = [NSString stringWithFormat:@"%d",[tmpWillBackAmount intValue]];
    int value = [tmpValue intValue];
    NSLog(@"valud: %d",value);
    NSLog(@"[self.lblItemAmount.text intValue] : %d",[self.lblItemAmount.text intValue]);


    if (value > [self.lblItemAmount.text intValue] - [self.lblItemBackAmount.text intValue] ) {
        [ProgressHUD showError:@"没有可以退的"];
        return;
    }

    self.backBlock([self.backDataList objectAtIndex:0]);

//    [ProgressHUD show:@"退菜中"];
//
//    [[DAOrderModule alloc]setBackOrderWithArray:dataList deskId:self.curService.deskId callback:^(NSError *err, DAMyOrderList *order) {
//
//        [ProgressHUD show:@"退菜成功"];
//        self.closeBackView();
//
//    }];
}

- (IBAction)cancelTouched:(id)sender {
    self.cancelBlock();
}

@end
