//
//  DAMyBackOrderViewController.h
//  DiandianIOS
//
//  Created by Antony on 13-11-19.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartSDK.h"

@interface DAMyBackOrderViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) DAService *curService;

@end
