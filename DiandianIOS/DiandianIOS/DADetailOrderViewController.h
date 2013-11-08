//
//  DADetailOrderViewController.h
//  DiandianIOS
//
//  Created by Antony on 13-11-7.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DADetailOrderDelegate;
@interface DADetailOrderViewController : UIViewController



@property (assign, nonatomic) id <DADetailOrderDelegate>delegate;
@end


@protocol DADetailOrderDelegate<NSObject>

@optional
- (void)cancelButtonClicked:(DADetailOrderViewController*)secondDetailViewController;
@end