//
//  DARootViewController.h
//  MenuBook
//
//  Created by Antony on 13-11-5.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartSDK.h"

@interface DARootViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIView *MenuGird;
@property (weak, nonatomic) IBOutlet UITableView *orderListTableView;
@property (weak, nonatomic) IBOutlet UIView *filerListView;
@property (weak, nonatomic) IBOutlet UIView *orderListView;

@property (nonatomic, retain) DAService *curService;

- (IBAction)backAction:(id)sender;
- (IBAction)fadeIn:(id)sender;

- (IBAction)fadeOut:(id)sender;

@end
