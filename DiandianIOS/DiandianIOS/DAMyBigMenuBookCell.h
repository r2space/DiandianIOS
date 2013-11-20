//
//  DAMyBigMenuBookCell.h
//  DiandianIOS
//
//  Created by Antony on 13-11-7.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartSDK.h"


@interface DAMyBigMenuBookCell : UICollectionViewCell


@property (nonatomic, strong) DAMenu *menuData;
- (IBAction)addMenu:(id)sender;

@end
