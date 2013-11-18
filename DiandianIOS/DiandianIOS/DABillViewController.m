//
//  DABillViewController.m
//  DiandianIOS
//
//  Created by kita on 13-11-9.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DABillViewController.h"
#import "DABillDetailViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "DAPreferentialViewController.h"

@interface DABillViewController ()

@end

@implementation DABillViewController
{
    NSMutableArray *finishList;
    NSMutableArray *cancelList;
}

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
    
    finishList = [[NSMutableArray alloc] init];
    cancelList = [[NSMutableArray alloc] init];
    
    NSString *pathString = [[NSBundle mainBundle] pathForResource:@"bill" ofType:@"json"];
    NSData *elementsData = [NSData dataWithContentsOfFile:pathString];
    
    NSError *anError = nil;
    NSArray *items = [NSJSONSerialization JSONObjectWithData:elementsData
                                                     options:NSJSONReadingAllowFragments
                                                       error:&anError];

    
    for (NSDictionary *d in items){
        [finishList addObject:d];
    }

    [self reload];
    
}

-(void)reload
{
    float total = 0;
    float pay = 0.0;
    float off = 0.0;
    float reduce = 0.0;
    
    for (NSDictionary *d in finishList){
        float price = [[d objectForKey:@"price"] floatValue];
        int amount = [[d objectForKey:@"amount"] floatValue];
        total += price*amount;
        off -= (1-[[d objectForKey:@"off"] floatValue]) * price * amount;
    }
    
    reduce = -50;
    
    pay = total + off +reduce;
    
    //TODO 小数抹除的方式
    self.lblTotal.text = [NSString stringWithFormat:@"%.02f元",total];
    self.lblOff.text = [NSString stringWithFormat:@"%.02f元",off];
    self.lblReduce.text = [NSString stringWithFormat:@"%.02f元",reduce];
    self.lblPay.text = [NSString stringWithFormat:@"%.02f元",pay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onDetailTaped:(id)sender {
    DABillDetailViewController *c = [[DABillDetailViewController alloc] initWithNibName:nil bundle:nil];
    c.finfishList = finishList;
    c.cancelList = cancelList;
    c.chanelBlock = ^() {
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    };

    [self presentPopupViewController:c animationType:MJPopupViewAnimationFade dismissed:^{
        [self reload];
    }];
}
- (IBAction)onPreferentialTouched:(id)sender {

    DAPreferentialViewController *c = [[DAPreferentialViewController alloc] initWithNibName:@"DAPreferentialViewController" bundle:nil];
    c.chanelBlock = ^() {
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    };
    
    [self presentPopupViewController:c animationType:MJPopupViewAnimationFade dismissed:^{
        [self reload];
    }];
}

- (IBAction)onBackTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
