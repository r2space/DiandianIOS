//
//  DAMyItemListViewController.h
//  DiandianIOS
//
//  Created by Antony on 13-11-14.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAMyItemListViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
