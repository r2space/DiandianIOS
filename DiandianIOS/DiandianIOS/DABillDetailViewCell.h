//
//  DABillDetailViewCell.h
//  DiandianIOS
//
//  Created by kita on 13-11-9.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartSDK.h"

typedef void (^BackCallback)();
typedef void (^FreeCallback)();

@interface DABillDetailViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblOff;
@property (weak, nonatomic) IBOutlet UILabel *lblPay;
@property (weak, nonatomic) IBOutlet UILabel *lblAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblAmountPrice;
@property (weak, nonatomic) IBOutlet UIButton *btnOperation;

@property (nonatomic,retain) DAOrder *order;

@property (nonatomic ,copy) BackCallback backCallback;
@property (nonatomic ,copy) FreeCallback freeCallback;

@end
