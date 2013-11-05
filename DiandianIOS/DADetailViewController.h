//
//  DADetailViewController.h
//  MenuBook
//
//  Created by Antony on 13-11-4.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DADetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

- (IBAction)firstAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
