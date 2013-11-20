//
//  DAOrderCell.h
//  DiandianIOS
//
//  Created by Antony on 13-11-7.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+MJPopupViewController.h"
#import <SmartSDKIOS/Header.h>

@interface DAOrderCell : UITableViewCell

- (DAOrderCell *) initWithOrder : (DAMyMenu *)menu tableView:(UITableView *) tableView;
- (IBAction)addAmount:(id)sender;
- (IBAction)delAmount:(id)sender;

//@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
- (IBAction)setRecipe:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *setRecipeBtn;

@end
