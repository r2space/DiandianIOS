//
//  DAMyOrderLoginViewController.h
//  DiandianIOS
//
//  Created by Antony on 13-11-13.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DAMyOrderLoginDelegate;
@interface DAMyOrderLoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *labelName;
@property (weak, nonatomic) IBOutlet UITextField *labelPassword;
@property (weak, nonatomic) IBOutlet UILabel *labelStatus;

@property (weak, nonatomic) IBOutlet UIView *drawpassword;

@property (assign, nonatomic) id <DAMyOrderLoginDelegate>delegate;






@end

@protocol DAMyOrderLoginDelegate<NSObject>

@optional
- (void)backmenuButtonClicked:(DAMyOrderLoginViewController*)loginViewViewController;
- (void)cancelOrderButtonClicked:(DAMyOrderLoginViewController*)loginViewViewController;
- (void)confirmOrderButtonClicked:(DAMyOrderLoginViewController*)loginViewViewController;
@end
