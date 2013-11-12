//
//  DAMyMenuBookPopupController.h
//  DiandianIOS
//
//  Created by Antony on 13-11-12.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DAMyMenuBookPopupDelegate;
@interface DAMyMenuBookPopupController : UIViewController

@property (assign, nonatomic) id <DAMyMenuBookPopupDelegate>delegate;
- (IBAction)backTouched:(id)sender;
@property (retain, nonatomic) NSString *tableNO;

@end

@protocol DAMyMenuBookPopupDelegate<NSObject>

@optional
- (void)cancelButtonClicked:(DAMyMenuBookPopupController*) popupViewController;
@end
