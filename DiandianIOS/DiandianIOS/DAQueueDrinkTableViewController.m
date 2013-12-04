//
//  DAQueueDrinkTableViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-15.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAQueueDrinkTableViewController.h"
#import "ProgressHUD.h"
#import "DAOrderProxy.h"


@interface DAQueueDrinkTableViewController ()
{
    DAMyOrderList *dataList;
}
@end

@implementation DAQueueDrinkTableViewController

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
    
    // Do any additional setup after loading the view from its nib.
    UINib *cellNib = [UINib nibWithNibName:@"DAQueueTableCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"DAQueueTableCell"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ioRefreshOrderList:) name:@"ioRefreshOrderList" object:nil];
}
- (void)ioRefreshOrderList : (NSNotification*) notification
{
    
    [self loadFromFile];
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadFromFile];
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
    return [dataList.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DAQueueTableCell"];
    
    
    DAOrder *row = [dataList.items objectAtIndex:indexPath.row];
    UILabel *lblName = (UILabel *)[cell viewWithTag:10];
    lblName.text = row.desk.name;
    
    UIImageView *imgItem = (UIImageView *)[cell viewWithTag:11];
    imgItem.image = [UIImage imageNamed:@"sample-table.jpg"];
    
    UILabel *lblProcess = (UILabel *)[cell viewWithTag:12];
    lblProcess.hidden = NO;
    lblProcess.text = [NSString stringWithFormat:@"%d个" ,[row.oneItems count]];
    
    
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
    
    self.deskClickCallback(order.serviceId,desk._id);
}



- (void)loadFromFile {
    [ProgressHUD show:nil];
    [[DAOrderModule alloc] getDeskListOfNeItemOrder:^(NSError *err, DAMyOrderList *list) {
        dataList = [DAOrderProxy getOneDeskDataList:list];
        [self.tableView reloadData];
        [ProgressHUD dismiss];
        
    }];
    
}


@end
