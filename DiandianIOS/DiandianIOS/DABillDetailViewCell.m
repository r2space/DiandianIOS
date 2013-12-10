//
//  DABillDetailViewCell.m
//  DiandianIOS
//
//  Created by kita on 13-11-9.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DABillDetailViewCell.h"
#import "ProgressHUD.h"

@implementation DABillDetailViewCell

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
- (IBAction)onMiandanTouched:(id)sender {
    NSLog(@"免单 , %@" , self.order._id);
    NSMutableArray *freeDataList = [[NSMutableArray alloc]init];
    [freeDataList addObject:self.order._id];
    [ProgressHUD show:@"退菜中"];
    
    [[DAOrderModule alloc] setFreeOrderWithArray:freeDataList deskId:@"" callback:^(NSError *err, DAMyOrderList *order) {
        if (err!=nil) {
            [ProgressHUD show:@"系统错误请联系管理员"];
        }
        if (self.freeCallback !=nil) {
            self.freeCallback();
        }
        [ProgressHUD show:@"免单成功"];        
    }];
}

- (IBAction)onBackTouched:(id)sender {

    NSMutableArray *backDataList = [[NSMutableArray alloc]init];
    [backDataList addObject:self.order._id];
    
    [ProgressHUD show:@"退菜中"];
    [[DAOrderModule alloc]setBackOrderWithArray:backDataList deskId:@"" callback:^(NSError *err, DAMyOrderList *order) {
        if (self.backCallback !=nil) {
            self.backCallback();
        }
        [ProgressHUD show:@"退菜成功"];
    }];
    
}


@end
