//
//  DAMyOrderViewController.h
//  MenuBook
//
//  Created by Antony on 13-11-5.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/TribeSDKHeader.h>
#import "DAOrderCell.h"
#import "DAOrderAddAmountBtn.h"

@interface DAMyOrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *labelAmount;
@property (nonatomic, retain) DAMyMenuList *dataList;
@property (nonatomic, retain) NSString *tableNO;
- (IBAction)backTopMenu:(id)sender;

- (IBAction)putDone:(id)sender;
- (IBAction)overOrder:(id)sender;
@end
