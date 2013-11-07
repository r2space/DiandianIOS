//
//  DAOrderCell.m
//  DiandianIOS
//
//  Created by Antony on 13-11-7.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAOrderCell.h"

@implementation DAOrderCell
//int amount = 0;

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

- (IBAction)addAmount:(id)sender {
//    amount = amount + 1;
//    self.amountLabel.text = [NSString stringWithFormat:@"%d份" ,amount];
}

- (IBAction)delAmount:(id)sender {
//    amount = amount - 1;
//    self.amountLabel.text = [NSString stringWithFormat:@"%d份" ,amount];
}
@end
