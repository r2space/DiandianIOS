//
//  DAFinishedOrderCell.m
//  DiandianIOS
//
//  Created by 罗浩 on 14-3-13.
//  Copyright (c) 2014年 DAC. All rights reserved.
//

#import "DAFinishedOrderCell.h"
#import "DABillBackPopoverViewController.h"
#import "SmartSDK.h"

@implementation DAFinishedOrderCell{
    DAOrder* orderData;
    UIPopoverController *popover;
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
        [self.backBtn setHidden:YES];
    }else if([order.itemType integerValue] == 1){
        self.typeLabel.text = @"菜品";
        [self.backBtn setHidden:NO];
    }else if([order.itemType integerValue] == 2){
        self.typeLabel.text = @"酒水";
        [self.backBtn setHidden:YES];
    }else if([order.itemType integerValue] == 3){
        self.typeLabel.text = @"海鲜";
        [self.backBtn setHidden:NO];
    }else if([order.itemType integerValue] == 10){
        self.typeLabel.text = @"广告";
        [self.backBtn setHidden:NO];
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

    orderData = order;
}
- (IBAction)freeBtnTouched:(id)sender {
    if(self.freeCallback != nil){
        self.freeCallback(orderData._id);
    }
}
- (IBAction)backBtnTouched:(UIButton *)sender {


    DABillBackPopoverViewController* vCtrl = [[DABillBackPopoverViewController alloc] initWithNibName:@"DABillBackPopoverViewController" bundle:nil];

    NSMutableArray * backDataList = [[NSMutableArray alloc]init];
    [backDataList addObject:orderData];

    vCtrl.backDataList = backDataList;

    vCtrl.backBlock = ^(DAOrder *order){
        [popover dismissPopoverAnimated:YES];
        self.backCallback(order);
    };

    vCtrl.cancelBlock = ^(){
        [popover dismissPopoverAnimated:YES];
    };

    popover = [[UIPopoverController alloc]initWithContentViewController:vCtrl];
    popover.popoverContentSize = CGSizeMake(328, 256);

    [popover presentPopoverFromRect:sender.frame inView:self.contentView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];


}

@end
