//
//  DAFinishedOrderCell.h
//  DiandianIOS
//
//  Created by 罗浩 on 14-3-13.
//  Copyright (c) 2014年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartSDK.h"
typedef void (^FreeCallback)(NSString *orderId);
typedef void (^BackCallback)(DAOrder *orderId);
@interface DAFinishedOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
-(void)setData:(DAOrder *) order;
@property (copy) FreeCallback freeCallback;
@property (copy) BackCallback backCallback;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@end
