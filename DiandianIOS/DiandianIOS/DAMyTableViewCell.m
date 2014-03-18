//
//  DAMyTableViewCell.m
//  DiandianIOS
//
//  Created by Xu Yang on 11/7/13.
//  Copyright (c) 2013 DAC. All rights reserved.
//

#import "DAMyTableViewCell.h"
#import "DAOrderPopoverViewController.h"


@implementation DAMyTableViewCell {
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

- (void)setData:(DADesk *)desk
{
    // Set title
    self.tableTitle.text = desk.name;
    // Set state
    self.tableState.text = @"";    // clear state
    
    DAService *service = desk.service;
    // 设置未上菜的量
    if (![desk isHasUnfinished]) {
        [self.unfinishedCount setHidden:NO];
        [self.unfinishedCount setTitle:@"0" forState:UIControlStateNormal];
    } else {
        [self.unfinishedCount setHidden:NO];
        [self.unfinishedCount setTitle:[NSString stringWithFormat:@"%@",service.unfinishedCount] forState:UIControlStateNormal];
        //NSLog(@"==== %@" , service.unfinishedCount);
    }
    if([desk isEmpty]){
        [self.unfinishedCount setHidden:YES];
    }
    
    // 这个好像被外面给覆盖了
    if (desk.service !=nil) {
        
    } else {
        [self.tableState setTextColor:[UIColor blackColor]];
        self.tableState.text = @"";
    }
    
}
- (IBAction)showUnfinishedMenuList:(id)sender {
    DAOrderPopoverViewController *vc = [[DAOrderPopoverViewController alloc] initWithNibName:@"DAOrderPopoverViewController" bundle:nil serviceId:self.curDesk.service._id];
    popover = [[UIPopoverController alloc]initWithContentViewController:vc];
    popover.popoverContentSize = CGSizeMake(270, 400);
    [popover presentPopoverFromRect:self.unfinishedCount.frame inView: self permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}


@end
