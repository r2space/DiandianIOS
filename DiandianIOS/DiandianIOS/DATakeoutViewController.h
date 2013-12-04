//
//  DATakeoutViewController.h
//  DiandianIOS
//
//  Created by Xu Yang on 11/19/13.
//  Copyright (c) 2013 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartSDK.h"

@protocol DATakeoutDelegate;

@interface DATakeoutViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (assign, nonatomic) id <DATakeoutDelegate>delegate;

+ (void) show:(UIViewController *) parentView;
@end

@protocol DATakeoutDelegate<NSObject>

- (void)cancelButtonClicked:(DATakeoutViewController*)controller;
- (void)takeoutOrder:(DATakeout*)takeout;
- (void)takeoutOrderList:(DATakeout*)takeout;
- (void)takeoutPay:(DATakeout*)takeout;
@end