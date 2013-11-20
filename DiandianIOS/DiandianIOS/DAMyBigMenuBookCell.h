//
//  DAMyBigMenuBookCell.h
//  DiandianIOS
//
//  Created by Antony on 13-11-7.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SmartSDKIOS/Header.h>

@interface DAMyBigMenuBookCell : UICollectionViewCell


@property (nonatomic, strong) DAMyMenu *menuData;
- (IBAction)addMenu:(id)sender;

@end
