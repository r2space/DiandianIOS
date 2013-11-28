//
//  DAQueueItemListViewController.h
//  DiandianIOS
//
//  Created by Antony on 13-11-15.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartSDK.h"

typedef void (^SelectItemBlock)(NSArray *orderIds , NSString *deskId);
typedef double NSTimeInterval;

@interface DAQueueItemListViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, copy) SelectItemBlock selectItemBlock;

- (void)filterItem:(NSString *)itemId tableNO:(NSString *)tableNo;

@end
