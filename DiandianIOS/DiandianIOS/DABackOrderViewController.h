//
//  DABackOrderViewController.h
//  DiandianIOS
//
//  Created by 罗浩 on 14-3-12.
//  Copyright (c) 2014年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartSDK.h"

@interface DABackOrderViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate>
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil  servieId:(NSString *)id deskId:(NSString *)did;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
