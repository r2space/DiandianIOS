//
//  DABillBackPopoverViewController.h
//  DiandianIOS
//
//  Created by Antony on 14-1-14.
//  Copyright (c) 2014年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartSDK.h"

typedef void (^CloseBillBackPopover)();
@interface DABillBackPopoverViewController : UIViewController

@property(nonatomic ,strong) NSMutableArray *backDataList;
@property (weak, nonatomic) IBOutlet UILabel *lblItemName;
@property (weak, nonatomic) IBOutlet UILabel *lblItemAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblItemBackAmount;
@property (retain, nonatomic) DAService *curService;

@property (weak, nonatomic) IBOutlet UITextField *textWillBackAmount;
@property (nonatomic, copy) CloseBillBackPopover closeBackView;

@end
