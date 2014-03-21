//
//  DAQueueItemTableViewController.h
//  DiandianIOS
//
//  Created by Antony on 13-11-15.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartSDK.h"


typedef void (^SelectDeskBlock)(DAMyOrderList *list);
typedef void (^BeforeSelectDeskBlock)();
@interface DAQueueItemTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) SelectDeskBlock selectDeskBlock;
@property (nonatomic, copy) BeforeSelectDeskBlock beforeSelectDeskBlock;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(retain, nonatomic) NSString* curOrderId;

- (void)filterTable:(NSArray *)orderIds deskId:(NSString *)deskId;


@end
