//
//  DABillViewController.h
//  DiandianIOS
//
//  Created by kita on 13-11-9.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartSDK.h"
@class DAService;
@interface DABillViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblTotal;
@property (weak, nonatomic) IBOutlet UILabel *lblOff;
@property (weak, nonatomic) IBOutlet UILabel *lblReduce;
@property (weak, nonatomic) IBOutlet UILabel *lblPay;
- (IBAction)onDetailTaped:(id)sender;
- (IBAction)onBackTouched:(id)sender;

@property (nonatomic, retain) DAService *curService;

@property (weak, nonatomic) IBOutlet UIView *viewTopmenu;
@property (weak, nonatomic) IBOutlet UILabel *viewTopmenuLabel;

@end
