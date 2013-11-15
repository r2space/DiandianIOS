//
//  DAProcessionViewController.h
//  DiandianIOS
//
//  Created by Xu Yang on 11/15/13.
//  Copyright (c) 2013 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DAProcessionDelegate;

@interface DAProcessionViewController : UIViewController
@property (assign, nonatomic) id <DAProcessionDelegate>delegate;

+ (void) show:(UIViewController *) parentView;
@end

@protocol DAProcessionDelegate<NSObject>

- (void)cancelButtonClicked:(DAProcessionViewController*)controller;
- (void)changeTable:(NSString*)tableId;
@end