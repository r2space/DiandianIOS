//
//  DAMyBackOrderViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-19.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAMyBackOrderViewController.h"
#import "DAMyBackOrderViewCell.H"
#import "DAOrderProxy.h"
#import "DAOrderModule.h"

#import "ProgressHUD.h"



@interface DAMyBackOrderViewController ()
{
    DAMyOrderList *dataList;
    NSMutableArray *backDataList;
    
}
@end

@implementation DAMyBackOrderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    dataList = [[DAMyOrderList alloc] init];
    dataList.items = [[NSArray alloc]init];
    
    [super viewDidLoad];
    UINib *cellNib = [UINib nibWithNibName:@"DAMyBackOrderViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"DAMyBackOrderViewCell"];

    // Do any additional setup after loading the view from its nib.
}
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //可退菜一览接口
    [ProgressHUD show:nil];
    [self fetch];
}
-(void)fetch
{
    backDataList = [[NSMutableArray alloc]init];
    [[DAOrderModule alloc] getOrderListByServiceId:self.curService._id withBack:@"0" callback:^(NSError *err, DAMyOrderList *list) {
        dataList = [DAOrderProxy getOneDataList:list];
        [self.tableView reloadData];
        [ProgressHUD dismiss];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataList.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DAMyBackOrderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DAMyBackOrderViewCell"];
    DAOrder *order = [dataList.items objectAtIndex:indexPath.row];
    UILabel *labItemName = (UILabel *)[cell viewWithTag:10];
    labItemName.text = order.item.itemName;
    UILabel *labItemCount = (UILabel *)[cell viewWithTag:11];
    NSInteger oneCount = [order.oneItems count];
    labItemCount.text = [NSString stringWithFormat:@"已点%d份" ,oneCount];
    
    cell.orderCount = [NSNumber numberWithInteger:oneCount];
    cell.selectFlag = @"NO";
    cell.amountText.text = @"";
    cell.orderId = order._id;
    
    cell.addBackBlock =^(NSString *orderId , NSString *amount){
        [self addBackOrder:orderId amount:amount];
    };
    
    cell.delBackBlock = ^(NSString *orderId , NSString *amount){
        [self delBackOrder:orderId amount:amount];
    };
    
    return cell;
}

-(void) addBackOrder:(NSString *)orderId amount:(NSString *)amount
{
    for (DAOrder *order in dataList.items) {
        if ([orderId isEqualToString:order._id]) {
            [backDataList addObject:[order.oneItems objectAtIndex:[amount intValue] -1 ]];
        }
    }
    
}

-(void) delBackOrder:(NSString *)orderId amount:(NSString *)amount
{
    for (DAOrder *order in dataList.items) {
        if ([orderId isEqualToString:order._id]) {
            [backDataList removeObject:[order.oneItems objectAtIndex:[amount intValue]]];
        }
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DAMyBackOrderViewCell *cell = (DAMyBackOrderViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    DAOrder *order = [dataList.items objectAtIndex:indexPath.row];
    [backDataList addObject:[order.oneItems objectAtIndex:0]];
    cell.selectFlag = @"YES";
    cell.amountText.text = @"1";
    cell.amount = [[NSNumber alloc]initWithInt:1];
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DAMyBackOrderViewCell *cell = (DAMyBackOrderViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    DAOrder *order = [dataList.items objectAtIndex:indexPath.row];

    for (NSString *orderId in order.oneItems) {
        [backDataList removeObject:orderId];
    }

    
    cell.selectFlag = @"NO";
    cell.amountText.text = @"";
}
- (IBAction)onPutDoneTouched:(id)sender {
    NSLog(@"sd \n\n\n\n\n\n");
    [ProgressHUD show:@"退菜中"];
    [[DAOrderModule alloc]setBackOrderWithArray:backDataList deskId:self.curService.deskId callback:^(NSError *err, DAMyOrderList *order) {
        
        [ProgressHUD show:@"退菜成功"];
        [self fetch];
    }];
    
}

@end
