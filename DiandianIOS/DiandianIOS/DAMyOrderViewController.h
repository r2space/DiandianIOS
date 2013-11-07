//
//  DAMyOrderViewController.h
//  MenuBook
//
//  Created by Antony on 13-11-5.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAOrderCell.h"

@interface DAMyOrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *orderList;

- (IBAction)putDone:(id)sender;
- (IBAction)overOrder:(id)sender;
@end