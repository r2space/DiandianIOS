//
//  MSBookMenu.m
//  DiandianIOS
//
//  Created by Antony on 13-11-6.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "MSBookMenu.h"

@implementation MSBookMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView  *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
        [imageView setImage:[UIImage imageNamed:@"stain.png"]];
        [self addSubview:imageView];
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

@end
