//
//  DAQueueItemTableViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-15.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAQueueItemTableViewController.h"
#import "ProgressHUD.h"

@interface DAQueueItemTableViewController ()
{
    DAMyOrderList *dataList;
    DAMenuList *menuList;
}
@end

@implementation DAQueueItemTableViewController


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
    // Do any additional setup after loading the view from its nib.
    dataList =  [[DAMyOrderList alloc ]init];
    dataList.items = [[NSArray alloc]init];
    menuList = [[DAMenuList alloc]unarchiveObjectWithFileWithName:FILE_MENU_LIST];
    // Do any additional setup after loading the view from its nib.
    UINib *cellNib = [UINib nibWithNibName:@"DAQueueTableCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"DAQueueTableCell"];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataList.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DAOrder *order = [dataList.items objectAtIndex:indexPath.row];
    DADesk *desk = order.desk;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DAQueueTableCell"];

    UILabel *lblName = (UILabel *)[cell viewWithTag:10];
    lblName.text = desk.name;
    
    UIImageView *imgItem = (UIImageView *)[cell viewWithTag:11];
    imgItem.image = [UIImage imageNamed:@"sample-table.jpg"];
    
//    UILabel *lblProcess = (UILabel *)[cell viewWithTag:12];
//    lblProcess.text = [row objectForKey:@"process"];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DAOrder *order = [dataList.items objectAtIndex:indexPath.row];
    DADesk *desk = order.desk;

    [ProgressHUD show:nil];
    [[DAOrderModule alloc] setDoneOrder:order._id callback:^(NSError *err, DAOrder *list) {
        [ProgressHUD dismiss];
        self.selectDeskBlock(order._id , desk._id);
    }];
    NSMutableArray *tempList = [[NSMutableArray alloc]init];
    for (DAOrder *tmpOrder in dataList.items) {
        if (![tmpOrder._id isEqualToString:order._id]) {
            [tempList addObject:tmpOrder];
        }
    }
    dataList.items = [[NSArray alloc] initWithArray:tempList];
    [self.tableView reloadData];
}

- (void)filterTable:(NSArray *)orderIds deskId:(NSString *)deskId
{
    dataList.items = [[NSArray alloc]init];
    
    [[DAOrderModule alloc] getDeskListByOrderIds:orderIds callback:^(NSError *err, DAMyOrderList *list) {
        NSMutableArray *tmpDeskList = [[NSMutableArray alloc]init];

        for (DAOrder *order in list.items) {
            [tmpDeskList addObject:order];
        }
        NSLog(@"debug filterTable  %@", list);
        dataList.items = [[NSArray alloc] initWithArray:tmpDeskList];
        [self.tableView reloadData];
        
    }];
    
    
}



@end
