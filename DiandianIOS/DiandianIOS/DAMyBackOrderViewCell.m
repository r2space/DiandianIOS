//
//  DAMyBackOrderViewCell.m
//  DiandianIOS
//
//  Created by Antony on 13-11-19.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAMyBackOrderViewCell.h"

@implementation DAMyBackOrderViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)deleteTouched:(id)sender {
    if ([self.selectFlag isEqualToString:@"YES"]) {
        int count = [self.amount intValue];
        if (count == 1) {
            return;
        }
        count = count - 1;
        self.amountText.text = [NSString stringWithFormat:@"%d",count];
        self.amount = [[NSNumber alloc]initWithInt:count];
    }
    
}

- (IBAction)addTouched:(id)sender {
    if ([self.selectFlag isEqualToString:@"YES"]) {
        int count = [self.amount intValue];
        count = count + 1;
        self.amountText.text = [NSString stringWithFormat:@"%d",count];
        self.amount = [[NSNumber alloc]initWithInt:count];
    }
    
}

@end
