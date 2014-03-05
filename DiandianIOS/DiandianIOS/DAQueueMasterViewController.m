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
    
    NSTimer         *timer;         // 涮新用计时器
    BOOL            puaseTimer;
    
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
    
//    [self initPrint];
    
}

-(void)initPrint
{
    // 创建定时器
    puaseTimer = NO;
//    timer = [NSTimer scheduledTimerWithTimeInterval:1
//                                             target:self
//                                           selector:@selector(timerEvent:)
//                                           userInfo:nil
//                                            repeats:YES];
    // 启动定时器
//    [timer fire];
}

// 定时获取消息。发生滚动时，停止定时器
//- (void)timerEvent:(NSTimer *)timer
//{
//    if (puaseTimer) {
//        return;
//    }
//    
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)drinkViewTouched:(id)sender {
    [drinkChildView.view removeFromSuperview];
    [orderGroupViewController.view removeFromSuperview];
    [self initDrinkListView];

}
- (IBAction)ItemViewTouched:(id)sender {
    [drinkChildView.view removeFromSuperview];
    [orderGroupViewController.view removeFromSuperview];
    [self initItemListView];
}

-(void) initDrinkListView
{
    if(drinkChildView == nil){
        drinkChildView = [[DADrinkQueueViewController alloc] initWithNibName:@"DADrinkQueueViewController" bundle:nil];
    }
    
    [drinkChildView.view setFrame:self.viewMasterBlock.frame];
    [self addChildViewController:drinkChildView];
    [self.view addSubview:drinkChildView.view];
    

}

-(void) initItemListView
{
    if(drinkChildView == nil){
        orderGroupViewController = [[DAItemViewController alloc] initWithNibName:@"DAItemViewController" bundle:nil];
    }
    
    [orderGroupViewController.view setFrame:self.viewMasterBlock.frame];
    [self addChildViewController:orderGroupViewController];
    [self.view addSubview:orderGroupViewController.view];
    
    
}

@end
