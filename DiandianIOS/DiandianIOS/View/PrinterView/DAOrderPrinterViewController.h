//
//  DAOrderPrinterViewController.h
//  DiandianIOS
//
//  Created by Antony on 14-1-18.
//  Copyright (c) 2014年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartSDK.h"
#import "ePOS-Print.h"

@interface DAOrderPrinterViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    EposPrint *printer_;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
