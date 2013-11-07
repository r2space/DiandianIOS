//
//  DAMyTableViewCell.m
//  DiandianIOS
//
//  Created by Xu Yang on 11/7/13.
//  Copyright (c) 2013 DAC. All rights reserved.
//

#import "DAMyTableViewCell.h"

@implementation DAMyTableViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setData:(NSString*)title setState:(NSString*)state
{
    // Set title
    self.tableTitle.text = title;
    // Set state
    self.tableState.text = @"";    // clear state
    if ([@"empty" isEqualToString:state]) {
        [self.tableState setTextColor:[UIColor blackColor]];
        self.tableState.text = @"";
    } else if ([@"eating" isEqualToString:state]) {
        [self.tableState setTextColor:[UIColor redColor]];
        self.tableState.text = @"就餐中";
    }
    
}
@end
