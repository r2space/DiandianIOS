//
//  DAMyBackOrderViewCell.h
//  DiandianIOS
//
//  Created by Antony on 13-11-19.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^AddBackBlock)(NSString *orderId , NSString *amount);
typedef void (^DelBackBlock)(NSString *orderId , NSString *amount);

@interface DAMyBackOrderViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *amountText;

@property (nonatomic, copy) AddBackBlock addBackBlock;
@property (nonatomic, copy) DelBackBlock delBackBlock;

@property (nonatomic, strong) NSString *selectFlag;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSNumber *amount;
@property (nonatomic, strong) NSNumber *orderCount;

@end
