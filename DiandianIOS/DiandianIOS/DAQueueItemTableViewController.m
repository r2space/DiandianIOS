//
//  DAQueueItemTableViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-15.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAQueueItemTableViewController.h"

@interface DAQueueItemTableViewController ()
{
    NSArray *dataList;
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
    dataList =  [[NSArray alloc ]init];
    // Do any additional setup after loading the view from its nib.
    UINib *cellNib = [UINib nibWithNibName:@"DAQueueTableCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"DAQueueTableCell"];
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
    return dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DAQueueTableCell"];
    
    
    NSDictionary *row = [dataList objectAtIndex:indexPath.row];
    UILabel *lblName = (UILabel *)[cell viewWithTag:10];
    lblName.text = [row objectForKey:@"name"];
    
    UIImageView *imgItem = (UIImageView *)[cell viewWithTag:11];
    imgItem.image = [UIImage imageNamed:[row objectForKey:@"image"]];
    
    UILabel *lblProcess = (UILabel *)[cell viewWithTag:12];
    lblProcess.text = [row objectForKey:@"process"];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.curItemId.length > 0 && self.curTableNO.length > 0) {
        self.selectTableBlock(self.curItemId,self.curTableNO);
        self.curItemId = @"";
        self.curTableNO = @"";
        [self loadFromFile];
    }
    
}

- (void)filterTable
{
    [self loadFromFile];
    NSMutableArray *tmpList = [[NSMutableArray alloc] init];
    for (NSDictionary *d in dataList){
        NSString *disTableNo = [d objectForKey:@"table"];
        if ([self.curTableNO isEqualToString:disTableNo]) {
            [tmpList addObject:d];
        }
        
    }
    dataList = [[NSArray alloc] initWithArray:tmpList];
    [self.tableView reloadData];
}

- (void)loadFromFile {
    NSString *pathString = [[NSBundle mainBundle] pathForResource:@"queue_group" ofType:@"json"];
    NSData *elementsData = [NSData dataWithContentsOfFile:pathString];
    
    NSError *anError = nil;
    NSArray *items = [NSJSONSerialization JSONObjectWithData:elementsData
                                                     options:NSJSONReadingAllowFragments
                                                       error:&anError];
    
    NSMutableArray *tmpList = [[NSMutableArray alloc] init];
    for (NSDictionary *d in items){
        [tmpList addObject:d];
    }
    dataList = [[NSArray alloc] initWithArray:tmpList];
    [self.tableView reloadData];
}


@end
