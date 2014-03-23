//
//  DARecentBillTableViewCell.m
//  DiandianIOS
//
//  Created by 罗浩 on 14-3-23.
//  Copyright (c) 2014年 DAC. All rights reserved.
//

#import "DARecentBillTableViewCell.h"

@implementation DARecentBillTableViewCell{
    DAService *service;
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
- (IBAction)printTouched:(id)sender {
    if(self.printCallback!= nil){
        self.printCallback(service);
    }
}
-(void)setData:(DAService *) s
{
    service = s;
    self.lblDesk.text = service.deskName;
    self.lblProfit.text = service.profit;
    self.lblUserpay.text = service.userPay;


    //NSString *dateString = @"2013-04-18T08:49:58.157+0000";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    // Always use this locale when parsing fixed format date strings
    NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [formatter setLocale:posix];
    NSDate *date = [formatter dateFromString:service.editat];
    NSDateFormatter* formatter2 = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [formatter2 setDateFormat:@"HH:mm"];
    self.lblTime.text = [formatter2 stringFromDate:date];
}
@end
