//
//  DAMyMenuBookViewController.h
//  DiandianIOS
//
//  Created by Antony on 13-11-6.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DABookCell.h"
#import "CustomLayout.h"
#import "RFQuiltLayout.h"

typedef enum {
    MenuBookList    = 0,
    MenuBookDetail  = 1
} MenuBookType;

@interface DAMyMenuBookViewController : UIViewController<UICollectionViewDataSource,RFQuiltLayoutDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (retain, nonatomic) NSString *tableNO;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
- (IBAction)changePage:(id)sender;

@end
