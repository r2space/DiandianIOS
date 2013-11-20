//
//  DAOrderThumbViewController.h
//  DiandianIOS
//
//  Created by Antony on 13-11-11.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartSDK.h"

@interface DAOrderThumbViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) DAMenuList *dataList;
@property (nonatomic, retain) NSString *tableNO;
@property (weak, nonatomic) IBOutlet UILabel *labelTableName;
@property (weak, nonatomic) IBOutlet UILabel *labelAmount;

- (IBAction)popupOrderDetail:(id)sender;

@end
