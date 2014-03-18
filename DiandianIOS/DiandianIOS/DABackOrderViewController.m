//
//  DABackOrderViewController.m
//  DiandianIOS
//
//  Created by 罗浩 on 14-3-12.
//  Copyright (c) 2014年 DAC. All rights reserved.
//

#import "DABackOrderViewController.h"
#import "DAMyBackOrderViewCell.H"

#import "ProgressHUD.h"
#import "DAPrintProxy.h"

@interface DABackOrderViewController (){
    DAMyOrderList *dataList;
    NSMutableArray *backDataList;
    MBProgressHUD *progress;
    NSString *serviceId;
    NSString *deskid;
}

@end

@implementation DABackOrderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil  servieId:(NSString *)id deskId:(NSString *)did
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        serviceId = id;
        deskid = did;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    dataList = [[DAMyOrderList alloc] init];
    dataList.items = [[NSArray alloc]init];

    [super viewDidLoad];
    UINib *cellNib = [UINib nibWithNibName:@"DAMyBackOrderViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"DAMyBackOrderViewCell"];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self loadData];
}

-(void)loadData
{
    backDataList = [[NSMutableArray alloc]init];
    [self showIndicator:@"加载中..."];
    [[DAOrderModule alloc] getOrderListByServiceId:serviceId withBack:@"0" callback:^(NSError *err, DAMyOrderList *list) {
        dataList = list;
        [self.tableView reloadData];
        [progress hide:YES];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)showIndicator:(NSString *)message
{
    if(progress == nil){
        progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        progress.mode = MBProgressHUDModeIndeterminate;
        //progress.color = [UIColor colorWithRed:102.0f/255.0f green:0.0f/255.0f blue:204.0f/255.0f alpha:1.0f];

    }
    progress.labelText = message;
    [progress show:YES];
}


#pragma mark -
#pragma mark tableView相关

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

#pragma mark -
#pragma 退菜操作

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
#pragma mark -
- (IBAction)cancelTouched:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)doneTouched:(id)sender {

    if(backDataList == nil || [backDataList count] == 0){
        progress.mode =  MBProgressHUDModeText;
        [self showIndicator:@"没有要退的菜品"];
        [progress hide:YES afterDelay:1];
        return;
    }

    NSMutableString *msg = [[NSMutableString alloc] init];
    [msg appendString:@"\n"];
    for (DAOrder *order in backDataList) {
        [msg appendString: [NSString stringWithFormat:@"品名:%@  数量:%@ \n", order.item.itemName,order.willBackAmount]];
    }

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确定退掉以下菜品?" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        [self showIndicator:@"退菜中..."];
        DDLogWarn(@"需要退的菜品:%@", [[backDataList description] stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"]);

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [DAPrintProxy addOrderBackPrint:backDataList];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[DAOrderModule alloc]setBackOrderWithArray:backDataList deskId:deskid callback:^(NSError *err, DAMyOrderList *order) {
                    [progress hide:YES];
                    if(err!= nil){
                        DDLogWarn(@"%@", err);
                        [ProgressHUD showError:@"退菜失败"];
                    }else{
                        DDLogWarn(@"退菜结束,service 信息:%@", serviceId);
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }

                }];
            });


        });





    }
}
@end
