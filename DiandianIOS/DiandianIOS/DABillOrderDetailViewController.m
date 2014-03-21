//
//  DABillOrderDetailViewController.m
//  DiandianIOS
//
//  Created by 罗浩 on 14-3-13.
//  Copyright (c) 2014年 DAC. All rights reserved.
//

#import "DABillOrderDetailViewController.h"
#import "MBProgressHUD.h"
#import "DAFinishedOrderCell.h"
#import "DAUnfinishedOrderCell.h"
#import "DAFreeOrderCell.h"
#import "DABackOrderCell.h"
#import "DAAllOrderCell.h"

@interface DABillOrderDetailViewController (){
    MBProgressHUD *progress;

    DAService *service;

    NSMutableArray *doneOrderList;
    NSMutableArray *undoneOrderList;
    NSMutableArray *backOrderList;
    NSMutableArray *freeOrderList;
    NSMutableArray *allOrderList;
    NSString *doneCellIdentifier;
    NSString *undoneCellIndentifier;
    NSString *backCellIdentifier;
    NSString *freeCellIndentifier;
    NSString *allCellIdentifier;

}

@end

@implementation DABillOrderDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil service: (DAService *) serviceOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        doneCellIdentifier = @"DAFinishedOrderCell";
        undoneCellIndentifier = @"DAUnfinishedOrderCell";
        backCellIdentifier = @"DABackOrderCell";
        freeCellIndentifier = @"DAFreeOrderCell";
        allCellIdentifier = @"DAAllOrderCell";
        service = serviceOrNil;
    }
    return self;
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.view.superview.bounds = CGRectMake(0, 0, 800, 600);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    DDLogWarn(@"didReceiveMemoryWarning  :  %@" ,[self class]);
}

- (IBAction)segValueChanged:(id)sender {
    [self changeTableAndReload];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    DAOrder *order;
    if(self.segControl.selectedSegmentIndex == 0) {
        order = [doneOrderList objectAtIndex:indexPath.row];
        DAFinishedOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:doneCellIdentifier forIndexPath:indexPath];

        if(cell.freeCallback == nil){
            DABillOrderDetailViewController * __weak weakSelf = self;
            cell.freeCallback = ^(NSString *orderId){
                [weakSelf freeOrderBlock:orderId];
            };
        }

        if(cell.backCallback == nil){
            DABillOrderDetailViewController * __weak weakSelf = self;
            cell.backCallback = ^(DAOrder *currOrder){
                 [weakSelf backOrderBlock:currOrder];
            };
        }

        [cell setData:order];
        return cell;
    }else if(self.segControl.selectedSegmentIndex == 1){
        order = [undoneOrderList objectAtIndex:indexPath.row];
        DAUnfinishedOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:undoneCellIndentifier forIndexPath:indexPath];

        if(cell.backCallback == nil){
            DABillOrderDetailViewController * __weak weakSelf = self;
            cell.backCallback = ^(DAOrder *currOrder){
                [weakSelf backOrderBlock:currOrder];
            };
        }

        [cell setData:order];
        return cell;
    }else if(self.segControl.selectedSegmentIndex == 2){
        order = [backOrderList objectAtIndex:indexPath.row];
        DABackOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:backCellIdentifier forIndexPath:indexPath];
        [cell setData:order];
        return cell;
    }else if(self.segControl.selectedSegmentIndex == 3){
        order = [freeOrderList objectAtIndex:indexPath.row];
        DAFreeOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:freeCellIndentifier forIndexPath:indexPath];

        [cell setData:order];
        return cell;
    }else if(self.segControl.selectedSegmentIndex == 4){
        order = [allOrderList objectAtIndex:indexPath.row];
        DAAllOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:allCellIdentifier forIndexPath:indexPath];
        [cell setData:order];
        return cell;
    }else{
        order = [allOrderList objectAtIndex:indexPath.row];
        DAAllOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:allCellIdentifier forIndexPath:indexPath];
        [cell setData:order];
        return cell;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.segControl.selectedSegmentIndex == 0) {
        return [doneOrderList count];
    }else if(self.segControl.selectedSegmentIndex == 1){
        return [undoneOrderList count];
    }else if(self.segControl.selectedSegmentIndex == 2){
        return [backOrderList count];
    }else if(self.segControl.selectedSegmentIndex == 3){
        return [freeOrderList count];
    }else if(self.segControl.selectedSegmentIndex == 4){
        return [allOrderList count];
    }else{
        return [allOrderList count];
    }

}

-(void)backOrderBlock{

}

-(void)freeOrderBlock:(NSString *)orderId{
    NSNumber *hasCash = [[NSUserDefaults standardUserDefaults]objectForKey:@"jp.co.dreamarts.smart.diandian.curWaitterHasCash"];

    if (!(hasCash != nil && [hasCash boolValue])) {
        [self showIndicator:@"没有权限..."];
        [progress hide:YES afterDelay:1000];
        return;
    }

    [self showIndicator:@"免单中..."];

    NSMutableArray *freeDataList = [[NSMutableArray alloc]init];
    [freeDataList addObject:orderId];

    [[DAOrderModule alloc] setFreeOrderWithArray:freeDataList deskId:@"" callback:^(NSError *err, DAMyOrderList *order) {
        if (err!=nil) {
            [self showIndicator:@"免单失败..."];
            [progress hide:YES afterDelay:1000];
        }else{
            [self loadData];
        }
    }];
}

-(void)backOrderBlock:(DAOrder *)order{

//    NSString *tmpWillBackAmount = self.textWillBackAmount.text;
//    if ([tmpWillBackAmount intValue] <= 0) {
//        [ProgressHUD showError:@"退菜数量不能是零"];
//        return;
//    }
//    NSString *tmpValue = [NSString stringWithFormat:@"%d",[tmpWillBackAmount intValue]];
//    int value = [tmpValue intValue];
//    NSLog(@"valud: %d",value);
//    NSLog(@"[self.lblItemAmount.text intValue] : %d",[self.lblItemAmount.text intValue]);
//
//
//    if (value > [self.lblItemAmount.text intValue] - [self.lblItemBackAmount.text intValue] ) {
//        [ProgressHUD showError:@"没有可以退的"];
//        return;
//    }
//    [ProgressHUD show:@"退菜中"];

    [self showIndicator:@"退菜中..."];
    NSMutableArray *dataList = [[NSMutableArray alloc]init];
    [dataList addObject:order];

    [[DAOrderModule alloc]setBackOrderWithArray:dataList deskId:service.deskId callback:^(NSError *err, DAMyOrderList *order) {
        if (err!=nil) {
            [self showIndicator:@"退菜失败..."];
            DDLogWarn(@"%@",@"结账页面退菜失败");
            [progress hide:YES afterDelay:1000];
        }else{
            [self loadData];
        }
    }];
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
- (void) loadData
{
    doneOrderList = [[NSMutableArray alloc] init];
    freeOrderList = [[NSMutableArray alloc] init];
    undoneOrderList = [[NSMutableArray alloc] init];
    backOrderList = [[NSMutableArray alloc] init];
    allOrderList = [[NSMutableArray alloc] init];

    [self showIndicator:@"加载中..."];
    [[DAOrderModule alloc] getOrderListByServiceId:service._id withBack:@"0,1,2,3" callback:^(NSError *err, DAMyOrderList *list) {

        for (DAOrder *order in list.items) {
            if ([order.back integerValue] == 3) {
                [freeOrderList addObject:order];
            } else if  ([order.back integerValue] == 2) {
                [backOrderList addObject:order];
            } else if  ([order.back integerValue] == 1){
                [doneOrderList addObject:order];
            } else {
                [undoneOrderList addObject:order];
            }
            [allOrderList addObject:order];
        }

        [self changeTableAndReload];

        [progress hide:YES];
    }];

}

- (void)changeTableAndReload {

    NSString *currentCellIdentifier;
    if (self.segControl.selectedSegmentIndex == 0) {
        currentCellIdentifier = doneCellIdentifier;
    } else if (self.segControl.selectedSegmentIndex == 1) {
        currentCellIdentifier = undoneCellIndentifier;
    } else if (self.segControl.selectedSegmentIndex == 2) {
        currentCellIdentifier = backCellIdentifier;
    } else if (self.segControl.selectedSegmentIndex == 3) {
        currentCellIdentifier = freeCellIndentifier;
    } else if (self.segControl.selectedSegmentIndex == 4) {
        currentCellIdentifier = allCellIdentifier;
    } else {
        currentCellIdentifier = allCellIdentifier;
    }

    [self.tableView registerNib:[UINib nibWithNibName:currentCellIdentifier bundle:nil] forCellReuseIdentifier:currentCellIdentifier];

    [self.tableView reloadData];
}

- (IBAction)backBtnTouched:(id)sender {
    self.parentReloadBlock();
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
