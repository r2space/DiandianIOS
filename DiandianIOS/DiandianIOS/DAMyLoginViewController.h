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

@protocol DAMyLoginDelegate;
@interface DAMyLoginViewController : UIViewController<DAPopTableViewDelegate, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *tableName;
@property (strong, nonatomic) IBOutlet UITextField *numOfPepole;

@property (strong, nonatomic) IBOutlet UITextField *waitterId;


@property (strong, nonatomic) IBOutlet UITextField *waitterPassword;
@property (weak, nonatomic) IBOutlet UILabel *labelLock;

@property (strong, nonatomic) IBOutlet UIPopoverController *popover;

@property (retain, nonatomic) DADesk *curDesk;

@property (retain, nonatomic) NSString *curUserId;

@property (retain, nonatomic) DAService *curService;


@property (assign, nonatomic) id <DAMyLoginDelegate>delegate;
- (IBAction)closePopup:(id)sender;
- (IBAction)startTable:(id)sender;

+ (void) show:(DADesk *)thisTable parentView :(UIViewController *) parentView;

@end

@protocol DAMyLoginDelegate<NSObject>

@optional
- (void)cancelButtonClicked:(DAMyLoginViewController*)loginViewViewController;
- (void)startTableButtonClicked:(DAMyLoginViewController*)loginViewViewController;
@end

