//
//  DADetailOrderViewController.h
//  DiandianIOS
//
//  Created by Antony on 13-11-7.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/TribeSDKHeader.h>
@protocol DADetailOrderDelegate;
@interface DADetailOrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPopoverControllerDelegate>


@property (weak, nonatomic) IBOutlet UILabel *amountPriceLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) DAMyMenuList *orderList;
@property (retain, nonatomic) NSString *tableNO;


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