//
//  DAMyTableViewCell.m
//  DiandianIOS
//
//  Created by Xu Yang on 11/7/13.
//  Copyright (c) 2013 DAC. All rights reserved.
//

#import "DAMyTableViewCell.h"
#import "NSString+Util.h"
#import "DAPopTableViewController.h"

@implementation DAMyTableViewCell
{
    UIPopoverController *popover;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setData:(DAMyTable*)mytable
{
    // Set title
    self.tableTitle.text = mytable.tableId;
    // Set state
    self.tableState.text = @"";    // clear state
    
    // 设置未上菜的量
    if ([NSString isEmpty:mytable.unfinishedCount] || [@"0" isEqualToString:mytable.unfinishedCount]) {
        [self.unfinishedCount setHidden:YES];
        [self.unfinishedCount setTitle:@"" forState:UIControlStateNormal];
    } else {
        [self.unfinishedCount setHidden:NO];
        [self.unfinishedCount setTitle:mytable.unfinishedCount forState:UIControlStateNormal];
    }
    
    // 这个好像被外面给覆盖了
    if ([@"empty" isEqualToString:mytable.state]) {
        [self.tableState setTextColor:[UIColor blackColor]];
        self.tableState.text = @"";
    } else if ([@"eating" isEqualToString:mytable.state]) {
        [self.tableState setTextColor:[UIColor redColor]];
        self.tableState.text = @"就餐中";
    }
    
}
- (IBAction)showUnfinishedMenuList:(id)sender {
    DAPopTableViewController *vc = [[DAPopTableViewController alloc] initWithNibName:@"DAPopTableViewController" bundle:nil];
    
    NSMutableArray *wList = [NSMutableArray array];
    [wList addObject:[NSString stringWithFormat:@"鱼香肉丝"]];
    [wList addObject:[NSString stringWithFormat:@"天外飞仙"]];
    [wList addObject:[NSString stringWithFormat:@"啤酒1瓶"]];
    
    [vc initData:@"type" list:wList];
    //vc.delegate = self;
    
    popover = [[UIPopoverController alloc]initWithContentViewController:vc];
    popover.popoverContentSize = CGSizeMake(200, 300);
    [popover presentPopoverFromRect:self.unfinishedCount.frame inView: self permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}
@end
