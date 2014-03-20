//
//  DAMyOrderLoginViewController.h
//  DiandianIOS
//
//  Created by Antony on 13-11-13.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAPopTableViewController.h"
#import "SmartSDK.h"

@protocol DAMyOrderLoginDelegate;

@interface DAMyOrderLoginViewController : UIViewController<DAPopTableViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *labelName;

@property (weak, nonatomic) IBOutlet UITextField *labelTips;
@property (retain, nonatomic) NSString *curUserId;
@property (nonatomic, retain) DAService *curService;
@property (retain, nonatomic) NSString *command;

@property (assign, nonatomic) id <DAMyOrderLoginDelegate>delegate;

@property(nonatomic ,retain) UINavigationController *navigationController;




@end

@protocol DAMyOrderLoginDelegate<NSObject>

@optional
- (void)backmenuButtonClicked:(DAMyOrderLoginViewController*)loginViewViewController;
- (void)cancelOrderButtonClicked:(DAMyOrderLoginViewController*)loginViewViewController;
- (void)confirmOrderButtonClicked:(DAMyOrderLoginViewController*)loginViewViewController;
@end
