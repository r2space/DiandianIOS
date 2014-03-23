//
//  DARecentBillViewController.h
//  DiandianIOS
//
//  Created by 罗浩 on 14-3-23.
//  Copyright (c) 2014年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DARecentBillViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
