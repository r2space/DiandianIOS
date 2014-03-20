//
//  DADetailOrderViewController.h
//  DiandianIOS
//
//  Created by Antony on 13-11-7.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartSDK.h"


typedef void(^ConfirmBlock)(NSString *tips);
typedef void(^CancelBlock)();

@protocol DADetailOrderDelegate;
@interface DADetailOrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPopoverControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblTotal;
@property (weak, nonatomic) IBOutlet UILabel *lblOption;

//显示总价的label
@property (weak, nonatomic) IBOutlet UILabel *amountPriceLabel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
//显示总价的 新建的orderList
@property (retain, nonatomic) DAMyOrderList *orderList;
//显示总价的 已点单的orderList
@property (nonatomic, retain) DAMyOrderList *oldOrderDataList;

@property (nonatomic, copy) ConfirmBlock confirmCallback;
@property (nonatomic, copy) CancelBlock cancelCallback;

@property (retain, nonatomic) DAService *curService;
@property(nonatomic ,retain) UINavigationController *navigationController;

@property (assign, nonatomic) id <DADetailOrderDelegate>delegate;
- (IBAction)closePopup:(id)sender;
- (IBAction)confirmOrder:(id)sender;
- (IBAction)backTableClick:(id)sender;
@end


@protocol DADetailOrderDelegate<NSObject>

@optional

- (void)cancelButtonClicked:(DADetailOrderViewController*)secondDetailViewController;
- (void)confirmButtonClicked:(DADetailOrderViewController*)secondDetailViewController;
- (void)backButtonClicked:(DADetailOrderViewController*)secondDetailViewController;

@end