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
#import "DAPrintProxy.h"
#import "DDLog.h"
static const int ddLogLevel = LOG_LEVEL_VERBOSE;



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
//        dataList = [DAOrderProxy getOneDataList:list];
        dataList = list;
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
    if ([order.type integerValue ] == 0) {
        labItemName.text = order.item.itemName;
    } else {
        labItemName.text = [NSString stringWithFormat:@"%@ (小)",order.item.itemName] ;
    }
    
    UILabel *labItemCount = (UILabel *)[cell viewWithTag:11];
//    NSInteger oneCount = [order.oneItems count];
    UIButton *addBtn = (UIButton *)[cell viewWithTag:61];
    UIButton *deleteBtn = (UIButton *)[cell viewWithTag:62];
    
    NSArray  *amountArray = [order.amount componentsSeparatedByString:@"."];
    if([order.item.type intValue] == 2 || [order.item.type intValue] == 0){
        NSString *amountPrefix = [amountArray objectAtIndex:0];
        labItemCount.text = [NSString stringWithFormat:@"%@份" ,amountPrefix];
        [addBtn setHidden:NO];
        [deleteBtn setHidden:NO];
    } else {
        labItemCount.text = [NSString stringWithFormat:@"%0.2f份" ,[order.amount floatValue]];
        [addBtn setHidden:YES];
        [deleteBtn setHidden:YES];
    }
    
    cell.selectFlag = @"NO";
    cell.amountText.text = @"";
    cell.orderId = order._id;
    cell.orderAmount = order.amount;
    
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
    for (DAOrder *order in backDataList) {
        if ([orderId isEqualToString:order._id]) {
            NSLog(@"%@",order.willBackAmount);
            NSLog(@"%@",order.amount);
            if ([order.willBackAmount intValue] < [order.amount intValue] ) {
                order.willBackAmount = [NSString stringWithFormat:@"%d",[order.willBackAmount intValue] + 1];
            }

        }
    }
    
}

-(void) delBackOrder:(NSString *)orderId amount:(NSString *)amount
{
    for (DAOrder *order in backDataList) {
        if ([orderId isEqualToString:order._id]) {
            order.willBackAmount = [NSString stringWithFormat:@"%d",[order.willBackAmount intValue] - 1 ];
        }
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DAMyBackOrderViewCell *cell = (DAMyBackOrderViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    DAOrder *order = [dataList.items objectAtIndex:indexPath.row];
    cell.selectFlag = @"YES";
    

    cell.amount = [[NSNumber alloc]initWithInt:1];
    
    
    if([order.item.type intValue] == 2 || [order.item.type intValue] == 0){
        cell.amountText.text = @"1";
        order.willBackAmount = @"1";
    } else {
        cell.amountText.text = order.amount;
        order.willBackAmount = order.amount;
    }
    
    [backDataList addObject:order];
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DAMyBackOrderViewCell *cell = (DAMyBackOrderViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    DAOrder *order = [dataList.items objectAtIndex:indexPath.row];
    
    [backDataList removeObject:order];
    
    cell.selectFlag = @"NO";
    cell.amountText.text = @"";
}
- (IBAction)onPutDoneTouched:(id)sender {
    
    [ProgressHUD show:@"退菜中"];
    DDLogWarn(@"需要退的菜品:%@", [backDataList description]);
    [[DAOrderModule alloc]setBackOrderWithArray:backDataList deskId:self.curService.deskId callback:^(NSError *err, DAMyOrderList *order) {
        DDLogWarn(@"退菜结束,service 信息:%@", [self.curService description]);
        [ProgressHUD show:@"退菜成功"];
        self.closeBackView();
        [self fetch];
    }];
    
    [DAPrintProxy addOrderBackPrint:backDataList];
    
}

@end
