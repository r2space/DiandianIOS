//
//  DAQueueDrinkTableViewController.h
//  DiandianIOS
//
//  Created by Antony on 13-11-15.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartSDK.h"

typedef void(^DeskClickCallback)(NSString *deskId , NSString *serviceId);

@interface DAQueueDrinkTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, copy) DeskClickCallback deskClickCallback;


- (void)loadFromFile;
-(void)loadWithData:(DAMyOrderList *) data;
-(void) disableSocketIO;
@end
