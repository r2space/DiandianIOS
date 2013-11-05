//
//  DAMyOrderViewController.h
//  MenuBook
//
//  Created by Antony on 13-11-5.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAMyOrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableVIew;
@property (nonatomic, retain) NSArray *orderList;
- (IBAction)putDone:(id)sender;
- (IBAction)overOrder:(id)sender;
@end
