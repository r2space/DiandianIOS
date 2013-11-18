//
//  DABillDetailViewController.h
//  DiandianIOS
//
//  Created by kita on 13-11-9.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ChanelBlock)();

@interface DABillDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (retain,nonatomic) NSMutableArray *finfishList;
@property (retain,nonatomic) NSMutableArray *cancelList;
@property (nonatomic, copy) ChanelBlock chanelBlock;
@end
