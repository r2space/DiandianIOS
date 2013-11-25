//
//  DAMyMenuBookCell.h
//  DiandianIOS
//
//  Created by Antony on 13-11-7.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartSDK.h"

@interface DAMyMenuBookCell : UICollectionViewCell

- (DAMyMenuBookCell *)initWithObj:(DAItem *)item collectionView:(UICollectionView *)collectionView  cellIdentifier: (NSString *)cellIdentifier indexPath:(NSIndexPath *)indexPath row:(NSNumber *)row column:(NSNumber *)column;

@property (nonatomic, strong) DAItem *itemData;

- (IBAction)addMenu:(id)sender;

@end
