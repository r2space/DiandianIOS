//
//  DAMyTableViewController.h
//  DiandianIOS
//
//  Created by Antony on 13-11-6.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MSGridView.h"
#import "DABookCell.h"
#import "RFQuiltLayout.h"

@protocol DATableViewDelegate;
@interface DAMyTableViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *topmenuView;
- (IBAction)onReturnTouched:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnMenuList;
@property (weak, nonatomic) IBOutlet UIButton *btnAccount;
@property (weak, nonatomic) IBOutlet UIButton *btnServing;
@property (weak, nonatomic) IBOutlet UIButton *btnRemove;
@property (weak, nonatomic) IBOutlet UILabel *viewTitle;
- (IBAction)showBillTouched:(id)sender;
- (IBAction)showMenuList:(id)sender;
- (IBAction)showOrderQueueTouched:(id)sender;

@end
