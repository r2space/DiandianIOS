//
//  DAAllOrderCell.m
//  DiandianIOS
//
//  Created by 罗浩 on 14-3-13.
//  Copyright (c) 2014年 DAC. All rights reserved.
//

#import "DAAllOrderCell.h"

@implementation DAAllOrderCell{
    DAOrder* orderData;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setData:(DAOrder *) order{
    //名称
    self.nameLabel.text = order.item.itemName;
    
    //类型
    if([order.itemType integerValue] == 0){
        self.typeLabel.text = @"主食";
    }else if([order.itemType integerValue] == 1){
        self.typeLabel.text = @"菜品";
    }else if([order.itemType integerValue] == 2){
        self.typeLabel.text = @"酒水";
    }else if([order.itemType integerValue] == 3){
        self.typeLabel.text = @"海鲜";
    }else if([order.itemType integerValue] == 10){
        self.typeLabel.text = @"广告";
    }
    
    //单价
    if ([order.type integerValue ] == 0) {
        self.priceLabel.text =[NSString stringWithFormat:@"%@元",order.item.itemPriceNormal];
    } else {
        self.priceLabel.text =[NSString stringWithFormat:@"%@元",order.item.itemPriceHalf];
    }
    
    //数量
    self.amountLabel.text = [NSString stringWithFormat:@"%0.2f",[order.amount floatValue]];
    
    //总价
    self.totalLabel.text = [NSString stringWithFormat:@"%0.2f",[order.amountPrice floatValue]];
    
    //可否打折
    if ([order.discount intValue] == 1) {
        self.discountLabel.text = @"可折";
    } else {
        self.discountLabel.text = @"无折";
    }

    [self hideAllIcon];

    if ([order.back integerValue] == 3) {
        self.freeIcon.hidden = NO;
    } else if  ([order.back integerValue] == 2) {
        self.backIcon.hidden = NO;
    } else if  ([order.back integerValue] == 1){
       self.doneIcon.hidden = NO;
    } else {
        self.undoneIcon.hidden = NO;
    }
    
    orderData = order;
}
-(void)hideAllIcon{
    self.doneIcon.hidden = YES;
    self.undoneIcon.hidden = YES;
    self.freeIcon.hidden = YES;
    self.backIcon.hidden = YES;
}
@end
