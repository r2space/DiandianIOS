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
- (IBAction)onReturnTouched:(id)sender;

@end
