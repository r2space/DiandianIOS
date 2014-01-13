//
//  DAOrderAddAmountBtn.h
//  DiandianIOS
//
//  Created by Antony on 13-11-7.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAOrderAddAmountBtn : UIButton

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *_id;
@property (nonatomic, strong) UITableViewCell *cell;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end
