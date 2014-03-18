//
//  DAAllOrderCell.h
//  DiandianIOS
//
//  Created by 罗浩 on 14-3-13.
//  Copyright (c) 2014年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartSDK.h"

@interface DAAllOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UILabel *doneIcon;
@property (weak, nonatomic) IBOutlet UILabel *undoneIcon;
@property (weak, nonatomic) IBOutlet UILabel *backIcon;
@property (weak, nonatomic) IBOutlet UILabel *freeIcon;


-(void)setData:(DAOrder *) order;
@end
