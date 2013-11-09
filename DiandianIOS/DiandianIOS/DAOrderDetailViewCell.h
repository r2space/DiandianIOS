//
//  DAOrderDetailViewCell.h
//  DiandianIOS
//
//  Created by LI LIN on 2013/11/09.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAOrderDetailViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgItem;
@property (weak, nonatomic) IBOutlet UILabel *lblItemName;
@property (weak, nonatomic) IBOutlet UILabel *lblTable;
@property (weak, nonatomic) IBOutlet UILabel *lblTicket;
@property (weak, nonatomic) IBOutlet UILabel *lblWaitingTime;
@property (weak, nonatomic) IBOutlet UIButton *btnFinish;

@end
