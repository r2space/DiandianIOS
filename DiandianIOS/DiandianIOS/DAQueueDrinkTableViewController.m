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
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadFromFile];
    NSNotification *orderReloadNotification = [NSNotification notificationWithName:@"ioSocketOpen" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:orderReloadNotification];

}
-(void) viewWillDisappear:(BOOL)animated
{
    NSNotification *orderReloadNotification = [NSNotification notificationWithName:@"ioSocketClose" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:orderReloadNotification];
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

    if (row.desk != nil && row.desk.name.length > 0) {
        lblName.text = row.desk.name;
    } else {
        lblName.text = @"外卖";
    }
    
    UIImageView *imgItem = (UIImageView *)[cell viewWithTag:11];
    
    UILabel *lblProcess = (UILabel *)[cell viewWithTag:12];
    lblProcess.hidden = NO;
    lblProcess.text = [NSString stringWithFormat:@"%d个" ,[row.oneItems count]];
    
    UILabel *lblAmount = (UILabel *)[cell viewWithTag:22];
    [lblAmount setHidden:YES];
    
    imgItem.image = [UIImage imageNamed:@"desk_bottonl.png"];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 142;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DAOrder *order = [dataList.items objectAtIndex:indexPath.row];
    DADesk *desk = order.desk;
    
    self.deskClickCallback(order.serviceId,desk._id);
}



- (void)loadFromFile {

    [[DAOrderModule alloc] getDeskListOfNeItemOrder:^(NSError *err, DAMyOrderList *list) {
        dataList = [DAOrderProxy getOneDeskDataList:list];
        [self.tableView reloadData];

        
    }];
    
}


@end
