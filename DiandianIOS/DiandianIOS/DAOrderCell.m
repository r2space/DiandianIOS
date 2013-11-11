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
- (DAOrderCell *) initWithOrder : (DAMyMenu *)menu tableView:(UITableView *) tableView
{
    NSString *identifier = @"DAOrderCell";
    DAOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
        NSArray *array = [nib instantiateWithOwner:nil options:nil];
        cell = [array objectAtIndex:0];
    }
//    [self.setRecipeBtn addTarget:cell action:@selector(update:) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}


- (void)update
{
    NSLog(@"update");
}

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

- (IBAction)setRecipe:(UIButton *)sender {
    
    NSNotification *setRecipeNotification = [NSNotification notificationWithName:@"setRecipe" object:nil];
    
    [[NSNotificationCenter defaultCenter] postNotification:setRecipeNotification];
    
}
@end
