//
//  DATakeoutViewCell.h
//  DiandianIOS
//
//  Created by Xu Yang on 11/19/13.
//  Copyright (c) 2013 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAPopTableViewController.h"
#import "DATakeoutViewController.h"
#import "DATakeout.h"

@interface DATakeoutViewCell : UITableViewCell<DAPopTableViewDelegate, UITextFieldDelegate>
@property (assign, nonatomic) id <DATakeoutDelegate>delegate;

@property (strong, nonatomic) IBOutlet UILabel *num;


- (void) initData:(DAService*) service parentViewController:(UIViewController*)parent;

@end
