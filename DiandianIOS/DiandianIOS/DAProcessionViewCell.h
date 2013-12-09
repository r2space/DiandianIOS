//
//  DAProcessionViewCell.h
//  DiandianIOS
//
//  Created by Xu Yang on 11/15/13.
//  Copyright (c) 2013 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAProcession.h"
#import "DAPopTableViewController.h"
#import "DAProcessionViewController.h"
@interface DAProcessionViewCell : UITableViewCell<DAPopTableViewDelegate, UITextFieldDelegate>
@property (assign, nonatomic) id <DAProcessionViewDelegate>delegate;
- (void) initData:(DASchedule*)p parentViewController:(UIViewController*)parent row:(int)row;
@end