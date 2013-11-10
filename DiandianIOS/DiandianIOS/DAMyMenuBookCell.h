//
//  DAMyMenuBookCell.h
//  DiandianIOS
//
//  Created by Antony on 13-11-7.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/TribeSDKHeader.h>

@interface DAMyMenuBookCell : UICollectionViewCell

- (DAMyMenuBookCell *)initWithObj:(DAMyMenu *)menu collectionView:(UICollectionView *)collectionView  cellIdentifier: (NSString *)cellIdentifier indexPath:(NSIndexPath *)indexPath row:(NSNumber *)row column:(NSNumber *)column;

@property (nonatomic, strong) DAMyMenu *menuData;

- (IBAction)addMenu:(id)sender;

@end
