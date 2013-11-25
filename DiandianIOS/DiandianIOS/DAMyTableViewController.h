//
//  DAMyTableViewController.h
//  DiandianIOS
//
//  Created by Antony on 13-11-6.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DABookCell.h"
#import "RFQuiltLayout.h"
#import "SmartSDK.h"


@protocol DATableViewDelegate;
@interface DAMyTableViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
    
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIView *topmenuView;
@property (weak, nonatomic) IBOutlet UILabel *topmenuLabel;

- (IBAction)onReturnTouched:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnMenuList;
@property (weak, nonatomic) IBOutlet UIButton *btnAccount;
@property (weak, nonatomic) IBOutlet UIButton *btnServing;
@property (weak, nonatomic) IBOutlet UIButton *btnRemove;
@property (weak, nonatomic) IBOutlet UILabel *viewTitle;
- (IBAction)showBillTouched:(id)sender;
- (IBAction)showMenuList:(id)sender;
- (IBAction)showOrderQueueTouched:(id)sender;

+ (void) receive:(NSString*)action data:(id)data;
- (void) receiveMessage:(NSString*)action data:(id)data;
@end
