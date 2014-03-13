//
//  DAOrderPopoverViewController.h
//  DiandianIOS
//
//  Created by 罗浩 on 14-3-12.
//  Copyright (c) 2014年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAOrderPopoverViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segControl;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil serviceId:(NSString *)sid;

@end
