//
//  DAScheduleViewController.h
//  DiandianIOS
//
//  Created by Antony on 13-12-6.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartSDK.h"

typedef void(^CloseCallback)();
@interface DAScheduleViewController : UIViewController

@property(nonatomic,copy) CloseCallback closeCallback;

@property (weak, nonatomic) IBOutlet UITextField *textPeople;
@property (weak, nonatomic) IBOutlet UITextField *textPhone;
@property (weak, nonatomic) IBOutlet UITextField *textDesk;

@property (weak, nonatomic) IBOutlet UITextField *textTime;

@end
