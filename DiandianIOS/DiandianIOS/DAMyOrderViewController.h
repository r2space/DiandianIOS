//
//  DAMyOrderViewController.h
//  MenuBook
//
//  Created by Antony on 13-11-5.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DAOrderCell.h"
#import "DAOrderAddAmountBtn.h"
#import "SmartSDK.h"
#import "DASocketIO.h"

@interface DAMyOrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,SocketIODelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *labelAmount;

@property (nonatomic, retain) DAMyOrderList *dataList;

@property (nonatomic, retain) DAService *curService;

- (IBAction)backTopMenu:(id)sender;

- (IBAction)putDone:(id)sender;

- (void) loadOldItem;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

@end
