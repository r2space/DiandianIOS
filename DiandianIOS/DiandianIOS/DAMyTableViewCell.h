//
//  DAMyTableViewCell.h
//  DiandianIOS
//
//  Created by Xu Yang on 11/7/13.
//  Copyright (c) 2013 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartSDK.h"

@interface DAMyTableViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *tableTitle;
@property (weak, nonatomic) IBOutlet UILabel *tableState;
@property (weak, nonatomic) IBOutlet UIButton *unfinishedCount;
@property (weak, nonatomic) IBOutlet UIImageView *imgTable;
@property (weak, nonatomic) IBOutlet UIView *viewMask;
@property (weak, nonatomic) IBOutlet UIView *viewLabel;

@property (retain, nonatomic) DADesk *curDesk;

- (void)setData:(DADesk *)desk;
@end
