//
//  DAProcessionViewController.h
//  DiandianIOS
//
//  Created by Xu Yang on 11/15/13.
//  Copyright (c) 2013 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DAProcessionViewDelegate;

@interface DAProcessionViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (assign, nonatomic) id <DAProcessionViewDelegate>delegate;

+ (void) show:(UIViewController *) parentView;
@end

@protocol DAProcessionViewDelegate<NSObject>

- (void)cancelButtonClicked:(DAProcessionViewController*)controller;
- (void)processionOrderFool:(NSString*)processionId;
- (void)processionIntoTable:(NSString*)processionId;
@end