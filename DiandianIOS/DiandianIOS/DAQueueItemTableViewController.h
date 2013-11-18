//
//  DAQueueItemTableViewController.h
//  DiandianIOS
//
//  Created by Antony on 13-11-15.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^SelectTableBlock)(NSString *itemId , NSString *tableNO);

@interface DAQueueItemTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) SelectTableBlock selectTableBlock;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(retain, nonatomic) NSString* curItemId;
@property(retain, nonatomic) NSString* curTableNO;
- (void)filterTable;


@end
