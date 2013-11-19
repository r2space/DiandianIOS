//
//  DAMyBackOrderViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-19.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAMyBackOrderViewController.h"
#import "DAMyBackOrderViewCell.H"


@interface DAMyBackOrderViewController ()
{
    NSMutableArray *dataList;
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
    [super viewDidLoad];
    UINib *cellNib = [UINib nibWithNibName:@"DAMyBackOrderViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"DAMyBackOrderViewCell"];

    // Do any additional setup after loading the view from its nib.
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
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DAMyBackOrderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DAMyBackOrderViewCell"];
    cell.selectFlag = @"NO";
    cell.amountText.text = @"";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DAMyBackOrderViewCell *cell = (DAMyBackOrderViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selectFlag = @"YES";
    cell.amountText.text = @"1";
    cell.amount = [[NSNumber alloc]initWithInt:1];
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DAMyBackOrderViewCell *cell = (DAMyBackOrderViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.selectFlag = @"NO";
    cell.amountText.text = @"";
}

@end
