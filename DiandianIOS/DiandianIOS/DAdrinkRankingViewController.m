//
//  DAdrinkRankingViewController.m
//  DiandianIOS
//
//  Created by 罗浩 on 14-3-26.
//  Copyright (c) 2014年 DAC. All rights reserved.
//

#import "DAdrinkRankingViewController.h"

@interface DAdrinkRankingViewController (){
    NSMutableArray *dayList;
}

@end

@implementation DAdrinkRankingViewController

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
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"DayCell"];

    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];

    NSDate *now = [NSDate date];
    int i;
    for (i = 0; i < 30; i++) {
        if(dayList == nil){
            dayList = [[NSMutableArray alloc] init];
        }
        [dayList addObject:[formatter stringFromDate:now]];
        now = [NSDate dateWithTimeIntervalSinceNow:-(60.0f * 60.0f * 24.0f * (i + 1))];
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dayList count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DayCell" forIndexPath:indexPath];
    cell.textLabel.text =  [dayList objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.printProc != nil){
        self.printProc([dayList objectAtIndex:indexPath.row]);
    }
}
@end
