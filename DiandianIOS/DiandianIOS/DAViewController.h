//
//  DAViewController.h
//  MenuBook
//
//  Created by Antony on 13-11-5.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DADeskProxy.h"



@interface DAViewController : UIViewController

- (IBAction)pushMenuBook:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *pushTableOpen;
- (IBAction)toTable:(id)sender;

@end
