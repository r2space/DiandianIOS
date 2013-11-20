//
//  DAMyTableViewCell.h
//  DiandianIOS
//
//  Created by Xu Yang on 11/7/13.
//  Copyright (c) 2013 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAMyTable.h"

@interface DAMyTableViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *tableTitle;
@property (strong, nonatomic) IBOutlet UILabel *tableState;
@property (strong, nonatomic) IBOutlet UIButton *unfinishedCount;
@property (weak, nonatomic) IBOutlet UIImageView *imgTable;
@property (weak, nonatomic) IBOutlet UIView *viewMask;
@property (weak, nonatomic) IBOutlet UIView *viewLabel;

- (void)setData:(DAMyTable*)mytable;
@end
