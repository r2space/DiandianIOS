//
//  DAMyTableViewCell.m
//  DiandianIOS
//
//  Created by Xu Yang on 11/7/13.
//  Copyright (c) 2013 DAC. All rights reserved.
//

#import "DAMyTableViewCell.h"
#import "NSString+Util.h"
#import "DAPopTableViewController.h"
#import "SmartSDK.h"
#import "DAOrderProxy.h"


@implementation DAMyTableViewCell
{
    UIPopoverController *popover;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setData:(DADesk *)mytable
{
    // Set title
    self.tableTitle.text = mytable.name;
    // Set state
    self.tableState.text = @"";    // clear state
    
    DAService *service = mytable.service;
    // 设置未上菜的量
    if (![mytable isHasUnfinished]) {
        [self.unfinishedCount setHidden:YES];
        [self.unfinishedCount setTitle:@"" forState:UIControlStateNormal];
    } else {
        [self.unfinishedCount setHidden:NO];
        [self.unfinishedCount setTitle:[NSString stringWithFormat:@"%@",service.unfinishedCount] forState:UIControlStateNormal];
        //NSLog(@"==== %@" , service.unfinishedCount);
    }
    
    // 这个好像被外面给覆盖了
    if (mytable.service !=nil) {
        
    } else {
        [self.tableState setTextColor:[UIColor blackColor]];
        self.tableState.text = @"";
    }
    
}
- (IBAction)showUnfinishedMenuList:(id)sender {
    DAPopTableViewController *vc = [[DAPopTableViewController alloc] initWithNibName:@"DAPopTableViewController" bundle:nil];
    NSMutableArray *wList = [NSMutableArray array];
    
    
    [[DAOrderModule alloc] getOrderListByServiceId:self.curDesk.service._id withBack:@"0" callback:^(NSError *err, DAMyOrderList *list) {
        DAMyOrderList *dataList = [DAOrderProxy getOneDataList:list];
        for (DAOrder *_order in dataList.items) {
            [wList addObject:_order];
        }
        [vc initData:@"type" list:wList];
    }];
    
    //vc.delegate = self;
    
    popover = [[UIPopoverController alloc]initWithContentViewController:vc];
    popover.popoverContentSize = CGSizeMake(200, 300);
    
    
    [popover presentPopoverFromRect:self.unfinishedCount.frame inView: self permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
@end
