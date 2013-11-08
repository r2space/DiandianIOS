//
//  DAMyLoginViewController.h
//  DiandianIOS
//
//  Created by Antony on 13-11-8.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DAMyLoginDelegate;
@interface DAMyLoginViewController : UIViewController
@property (assign, nonatomic) id <DAMyLoginDelegate>delegate;
@end

@protocol DAMyLoginDelegate<NSObject>

@optional
- (void)cancelButtonClicked:(DAMyLoginViewController*)loginViewViewController;
@end

