//
//  DAMyBigMenuBookCell.m
//  DiandianIOS
//
//  Created by Antony on 13-11-7.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAMyBigMenuBookCell.h"

@implementation DAMyBigMenuBookCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)addMenu:(id)sender {
    NSLog(@"dfdaf  data  %@  " ,self.menuData.name);
    NSNotification *orderReloadNotification = [NSNotification notificationWithName:@"orderReload" object:self.menuData];
    [[NSNotificationCenter defaultCenter] postNotification:orderReloadNotification];
}
@end
