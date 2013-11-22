//
//  DAMyLoginViewController.h
//  DiandianIOS
//
//  Created by Antony on 13-11-8.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartSDK.h"
#import "DAPopTableViewController.h"

@protocol DAMyTableConfirmDelegate;
@interface DAMyTableConfirmController : UIViewController<DAPopTableViewDelegate, UITextFieldDelegate>
@property (assign, nonatomic) id <DAMyTableConfirmDelegate>delegate;
- (IBAction)closePopup:(id)sender;

+ (void) show:(DADesk *)thisTable parentView :(UIViewController *) parentView;

@end

@protocol DAMyTableConfirmDelegate<NSObject>

@optional
- (void)cancelButtonClicked:(DAMyTableConfirmController*)controller;
- (void)changeTable:(NSString*)tableId;
@end

