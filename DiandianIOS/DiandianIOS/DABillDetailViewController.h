//
//  DABillDetailViewController.h
//  DiandianIOS
//
//  Created by kita on 13-11-9.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartSDK.h"

typedef void (^ChanelBlock)();
typedef void(^ParentReloadBlock)();

@interface DABillDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (retain,nonatomic) NSMutableArray *finfishList;
@property (retain,nonatomic) NSMutableArray *cancelList;
@property (nonatomic, copy) ChanelBlock chanelBlock;
@property (nonatomic, copy) ParentReloadBlock parentReloadBlock;

@property (nonatomic, retain) DAService *curService;
@property (nonatomic, retain) NSString *offAmount;
@property (nonatomic, retain) NSString *payAmount;
@property (nonatomic, retain) NSString *reduceAmount;



@end
