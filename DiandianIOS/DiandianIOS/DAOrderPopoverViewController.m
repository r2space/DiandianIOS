//
//  DAOrderPopoverViewController.m
//  DiandianIOS
//
//  Created by 罗浩 on 14-3-12.
//  Copyright (c) 2014年 DAC. All rights reserved.
//

#import "DAOrderPopoverViewController.h"
#import "SmartSDK.h"
#import "MBProgressHUD.h"
#import "DAOrderPopoverTableViewCell.h"
#import "DAPopoverOrderTypeAllTableViewCell.h"

@interface DAOrderPopoverViewController () {
    NSMutableArray *dataList;
    MBProgressHUD *progress;
    NSString *serviceId;
}

@end

@implementation DAOrderPopoverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil serviceId:(NSString *)sid {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        serviceId = sid;
    }
    return self;
}

- (void)showIndicator:(NSString *)message {
    if (progress == nil) {
        progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        progress.mode = MBProgressHUDModeIndeterminate;
        //progress.color = [UIColor colorWithRed:102.0f/255.0f green:0.0f/255.0f blue:204.0f/255.0f alpha:1.0f];

    }
    progress.labelText = message;
    [progress show:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    DDLogWarn(@"didReceiveMemoryWarning  :  %@" ,[self class]);
}

- (IBAction)segValueChanged:(id)sender {
    [self loadData];
}

- (void)loadData {
    [self showIndicator:@"加载中..."];
    NSString *back;
    if (self.segControl.selectedSegmentIndex == 0) {
        back = @"0";
        [self.tableView registerNib:[UINib nibWithNibName:@"DAOrderPopoverTableViewCell" bundle:nil] forCellReuseIdentifier:@"DAOrderPopoverTableViewCell"];

    } else {
        back = @"0,1,2";
        [self.tableView registerNib:[UINib nibWithNibName:@"DAPopoverOrderTypeAllTableViewCell" bundle:nil] forCellReuseIdentifier:@"DAPopoverOrderTypeAllTableViewCell"];
    }
    [[DAOrderModule alloc] getOrderListByServiceId:serviceId withBack:back callback:^(NSError *err, DAMyOrderList *list) {

        dataList = [[NSMutableArray alloc] init];

        for (DAOrder *_order in list.items) {
            [dataList addObject:_order];
        };
        [self.tableView reloadData];
        [progress hide:YES];
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DAOrder *order = (DAOrder *) [dataList objectAtIndex:indexPath.row];
    if (self.segControl.selectedSegmentIndex == 0) {
        DAOrderPopoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DAOrderPopoverTableViewCell" forIndexPath:indexPath];
        cell.nameLabel.text = order.item.itemName;
        cell.amountLabel.text = order.amount;
        if ([order.type integerValue] == 0) {
            cell.typeLabel.text = @"份";
        } else {
            cell.typeLabel.text = @"小份";
        }
        return cell;
    } else {
        DAPopoverOrderTypeAllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DAPopoverOrderTypeAllTableViewCell" forIndexPath:indexPath];
        cell.nameLabel.text = order.item.itemName;
        cell.amountLabel.text = order.amount;
        if ([order.type integerValue] == 0) {
            cell.typeLabel.text = @"份";
        } else {
            cell.typeLabel.text = @"小份";
        }
        if ([order.back intValue]  == 2 ) {
            [cell.backFlagLabel setHidden:NO];
        }else{
            [cell.backFlagLabel setHidden:YES];
        }
        return cell;

    }
}

@end
