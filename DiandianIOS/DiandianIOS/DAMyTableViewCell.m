//
//  DAMyTableViewCell.m
//  DiandianIOS
//
//  Created by Xu Yang on 11/7/13.
//  Copyright (c) 2013 DAC. All rights reserved.
//

#import "DAMyTableViewCell.h"
#import "NSString+Util.h"

@implementation DAMyTableViewCell

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
    //self.unFinishedCountMask.layer.borderWidth = 1;
    self.unFinishedCountMask.layer.cornerRadius = 5.0;
    //self.unFinishedCountMask.layer.borderColor = UIColor.blackColor.CGColor;
    
    if ([NSString isEmpty:mytable.unfinishedCount] || [@"0" isEqualToString:mytable.unfinishedCount]) {
        [self.unFinishedCountMask setHidden:YES];
        [self.unFinishedCount setHidden:YES];
        self.unFinishedCount.text = @"";
    } else {
        [self.unFinishedCountMask setHidden:NO];
        [self.unFinishedCount setHidden:NO];
        self.unFinishedCount.text = mytable.unfinishedCount;
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
@end
