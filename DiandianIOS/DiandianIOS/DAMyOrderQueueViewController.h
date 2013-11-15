//
//  DAMyOrderQueueViewController.h
//  DiandianIOS
//
//  Created by Antony on 13-11-14.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAMyOrderQueueViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *imageItemblockView;
@property (weak, nonatomic) IBOutlet UIView *imageTableblockView;

@property (weak, nonatomic) IBOutlet UIView *imageTableListView;
@property (weak, nonatomic) IBOutlet UIView *imageTableTitleView;
@property (weak, nonatomic) IBOutlet UIView *imageItemListView;
@property (weak, nonatomic) IBOutlet UIView *imageCategoryView;
- (IBAction)backTopMenuTouched:(id)sender;

@end
