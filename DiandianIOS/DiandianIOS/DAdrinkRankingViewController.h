//
//  DAdrinkRankingViewController.h
//  DiandianIOS
//
//  Created by 罗浩 on 14-3-26.
//  Copyright (c) 2014年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^PrintProc)(NSString *day);
@interface DAdrinkRankingViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (copy)PrintProc printProc;
@end
