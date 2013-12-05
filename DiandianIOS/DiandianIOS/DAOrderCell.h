//
//  DAOrderCell.h
//  DiandianIOS
//
//  Created by Antony on 13-11-7.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+MJPopupViewController.h"
#import "SmartSDK.h"

@interface DAOrderCell : UITableViewCell

- (DAOrderCell *) initWithOrder : (DAMenu *)menu tableView:(UITableView *) tableView;


@end
