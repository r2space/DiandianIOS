//
//  DAOrderQueueViewController.h
//  DiandianIOS
//
//  Created by LI LIN on 2013/11/09.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAOrderQueueViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgGroupView;
@property (weak, nonatomic) IBOutlet UIImageView *imgDetailView;
- (IBAction)onReturnTouched:(id)sender;

@end
