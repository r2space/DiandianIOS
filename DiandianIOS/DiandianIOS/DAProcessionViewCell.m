//
//  DAProcessionViewCell.m
//  DiandianIOS
//
//  Created by Xu Yang on 11/15/13.
//  Copyright (c) 2013 DAC. All rights reserved.
//

#import "DAProcessionViewCell.h"
#import "DAProcession.h"
#import "DAProcessionViewController.h"

#import "UIViewController+MJPopupViewController.h"
#import "DAPopTableViewController.h"
#import "NSString+Util.h"

@interface DAProcessionViewCell()
@property (strong, nonatomic) IBOutlet UILabel *num;
@property (strong, nonatomic) IBOutlet UITextField *numOfPeople;
@property (strong, nonatomic) IBOutlet UIButton *order;

@property (strong, nonatomic) IBOutlet UIPopoverController *popover;

@end

@implementation DAProcessionViewCell
{
    UIViewController *parentVC;
    DAProcession* procession;
}


- (void) initData:(DAProcession*)p parentViewController:(UIViewController*)parent
{
    parentVC = parent;
    procession = p;
    
    self.delegate = (id)parentVC;

    self.numOfPeople.delegate = self;
    
    self.num.text = procession.num;
    self.numOfPeople.text = procession.numOfPeople;
    
    if ([@"true" isEqualToString:procession.order]) {
        [self.order setTitle:@"继续点餐" forState:UIControlStateNormal];
    } else {
        [self.order setTitle:@"开始点餐" forState:UIControlStateNormal];
    }
    
}
- (IBAction)openMyTable:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(processionIntoTable:)]) {
        [self.delegate processionIntoTable:procession.processionId];
    }
}
- (IBAction)processionOrderFool:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(processionOrderFool:)]) {
        [self.delegate processionOrderFool:procession.processionId];
    }
}
- (BOOL) textFieldShouldBeginEditing: (UITextField *)textField
{
    if ([textField isEqual:self.numOfPeople]) {
        DAPopTableViewController *vc = [[DAPopTableViewController alloc] initWithNibName:@"DAPopTableViewController" bundle:nil];
        
        NSMutableArray *wList = [NSMutableArray array];
        for (int i = 0; i < 50; i++) {
            [wList addObject:[NSString stringWithFormat:@"%d", i]];
        }
        [vc initData:@"pepole" list:wList];
        vc.delegate = self;
        
        self.popover = [[UIPopoverController alloc]initWithContentViewController:vc];
        self.popover.popoverContentSize = CGSizeMake(100, 400);
        [self.popover presentPopoverFromRect:textField.frame inView: self permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    }
	return NO;
}
- (void)popTableViewSelectRow:(NSString *)tag value:(id)value
{
    if ([@"pepole" isEqualToString:tag]) {
        self.numOfPeople.text = value;
    }
    
    [self.popover dismissPopoverAnimated:YES];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
