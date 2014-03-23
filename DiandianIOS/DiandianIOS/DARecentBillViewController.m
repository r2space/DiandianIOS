//
//  DARecentBillViewController.m
//  DiandianIOS
//
//  Created by 罗浩 on 14-3-23.
//  Copyright (c) 2014年 DAC. All rights reserved.
//

#import "DARecentBillViewController.h"
#import "DARecentBillTableViewCell.h"
#import "DAPrintProxy.h"
#import "ProgressHUD.h"
@interface DARecentBillViewController (){
    DAServiceList *serviceList;
    MBProgressHUD *progress;
}

@end

@implementation DARecentBillViewController

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
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"DARecentBillTableViewCell" bundle:nil] forCellReuseIdentifier:@"DARecentBillTableViewCell"];
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.view.superview.bounds = CGRectMake(0, 0, 400, 400);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DARecentBillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DARecentBillTableViewCell" forIndexPath:indexPath];
    DAService *service = [serviceList.items objectAtIndex:indexPath.row];
    [cell setData:service];
    if(cell.printCallback == nil){
        cell.printCallback = ^(DAService *service1){
            // do print here

            [self showIndicator:@"打印中..."];
            DDLogWarn(@"最近订单打印");
            DDLogWarn(@"开始打印账单,service id : %@ ,bill num : %@",service1._id,service1.billNum);
            [DAPrintProxy printBill:service1._id
                                off:service1.agio
                                pay:service1.profit
                            userPay:service1.userPay
                               type:0
                             reduce:@"0"
                                seq:service1.billNum
                         completion:^(NSError *error){
                             DDLogWarn(@"打印账单结束");
                             [progress hide:YES];
                             if(error != nil){
                                 [ProgressHUD showError:@"打印失败,请重试."];
                             }else{
                                 [self.navigationController popViewControllerAnimated:YES];
                             }
                         }];

        };
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [serviceList.items count];
}
- (IBAction)backTouched:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)showIndicator:(NSString *)message
{
    if(progress == nil){
        progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        progress.mode = MBProgressHUDModeIndeterminate;

    }
    progress.labelText = message;
    [progress show:YES];

}
-(void)loadData
{
    [self showIndicator:@"加载中..."];
    [[DAServiceModule alloc] getRecentServiceList:^(NSError *err, DAServiceList *list) {
        [progress hide:YES];
        serviceList = list ;
        [self.tableView reloadData];
    }];
}
@end
