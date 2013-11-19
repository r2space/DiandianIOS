//
//  DAMyBackOrderViewCell.h
//  DiandianIOS
//
//  Created by Antony on 13-11-19.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAMyBackOrderViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *amountText;
@property (nonatomic, strong) NSString *selectFlag;
@property (nonatomic, strong) NSNumber *amount;

@end
