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


@property (weak, nonatomic) IBOutlet UIView *imageCategoryView;

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIView *viewTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

@property (weak, nonatomic) IBOutlet UIView *topmenuView;
@property (weak, nonatomic) IBOutlet UIButton *btnDrink;
@property (weak, nonatomic) IBOutlet UIButton *btnFood;
@property (weak, nonatomic) IBOutlet UIButton *btnItem;

- (IBAction)backTopMenuTouched:(id)sender;

@end
