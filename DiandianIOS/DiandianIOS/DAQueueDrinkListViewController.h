//
//  DAQueueDrinkListViewController.h
//  DiandianIOS
//
//  Created by Antony on 13-11-15.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartSDK.h"

typedef void(^ItemClickCallback)();

@interface DAQueueDrinkListViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@property (nonatomic, copy) ItemClickCallback itemClickCallback;

-(void ) getQueueListWithServiceId:(NSString *)serviceId deskId:(NSString *)deskId;

@end
