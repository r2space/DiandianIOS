//
//  DAMasterViewController.h
//  MenuBook
//
//  Created by Antony on 13-11-4.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DADetailViewController;

@interface DAMasterViewController : UITableViewController

@property (strong, nonatomic) DADetailViewController *detailViewController;

@end
