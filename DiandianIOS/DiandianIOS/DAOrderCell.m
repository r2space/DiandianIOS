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
        CGContextRef context =UIGraphicsGetCurrentContext();  //获取绘图上下文----画板
        CGContextBeginPath(context);  //创建一条路径
        CGContextSetLineWidth(context, 2.0);  //设置线宽
        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);  //设置线的颜色
        float lengths[] = {10,10};
        CGContextSetLineDash(context, 0, lengths,2);  //设置虚线的样式
        CGContextMoveToPoint(context, 10.0, 20.0);  //将路径绘制的起点移动到一个位置，即设置线条的起点
        CGContextAddLineToPoint(context, 310.0,20.0);  //在图形上下文移动你的笔画来指定线条的重点
        CGContextStrokePath(context);  //创建你已经设定好的路径。此过程将使用图形上下文已经设置好的颜色来绘制路径。
        CGContextClosePath(context);
        UIImage *image = [UIImage imageNamed:@"apple.jpg"];
        [image drawInRect:CGRectMake(0, 0, 20, 20)];//在坐标中画出图片
        CGContextDrawImage(context, CGRectMake(0, 0, 20, 20), image.CGImage);
        
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
