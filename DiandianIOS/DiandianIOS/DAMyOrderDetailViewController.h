//
//  DAMyOrderDetailViewController.h
//  DiandianIOS
//
//  Created by Antony on 13-11-6.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DAMyOrderDetailDelegate;
@interface DAMyOrderDetailViewController : UIViewController

@property (assign, nonatomic) id <DAMyOrderDetailDelegate>delegate;
@end


@protocol DAMyOrderDetailDelegate<NSObject>

@optional
- (void)cancelButtonClicked:(DAMyOrderDetailViewController*)secondDetailViewController;
@end