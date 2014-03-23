//
//  DARecentBillTableViewCell.h
//  DiandianIOS
//
//  Created by 罗浩 on 14-3-23.
//  Copyright (c) 2014年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartSDK.h"
typedef void (^PrintCallback)(DAService *service);
@interface DARecentBillTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblDesk;
@property (weak, nonatomic) IBOutlet UILabel *lblProfit;
@property (weak, nonatomic) IBOutlet UILabel *lblUserpay;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (copy) PrintCallback printCallback;
-(void)setData:(DAService *) service;
@end
