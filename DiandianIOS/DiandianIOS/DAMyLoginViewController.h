//
//  DAMyLoginViewController.h
//  DiandianIOS
//
//  Created by Antony on 13-11-8.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/DAMyTable.h>
#import "DAPopTableViewController.h"

@protocol DAMyLoginDelegate;
@interface DAMyLoginViewController : UIViewController<DAPopTableViewDelegate, UITextFieldDelegate>
@property (assign, nonatomic) id <DAMyLoginDelegate>delegate;
- (IBAction)closePopup:(id)sender;
- (IBAction)startTable:(id)sender;

+ (void) show:(DAMyTable*)thisTable parentView :(UIViewController *) parentView;

@end

@protocol DAMyLoginDelegate<NSObject>

@optional
- (void)cancelButtonClicked:(DAMyLoginViewController*)loginViewViewController;
- (void)startTableButtonClicked:(DAMyLoginViewController*)loginViewViewController;
@end

