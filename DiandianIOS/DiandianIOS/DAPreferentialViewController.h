//
//  DAPreferentialViewController.h
//  DiandianIOS
//
//  Created by Antony on 13-11-17.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ChanelBlock)();
@interface DAPreferentialViewController : UIViewController
@property (nonatomic, copy) ChanelBlock chanelBlock;
@end
