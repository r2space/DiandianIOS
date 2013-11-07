//
//  DAMyOrderViewController.m
//  MenuBook
//
//  Created by Antony on 13-11-5.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAMyOrderViewController.h"
#import "DAMyOrderDetailViewController.h"
#import "UIViewController+CWPopup.h"

@interface DAMyOrderViewController ()
{
    NSMutableArray *list;
}
@end

@implementation DAMyOrderViewController

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
//    NSArray *list = [NSArray arrayWithObjects:@"fd",@"sdfdf",nil];
    list =[[NSMutableArray alloc] init];
    [list addObject:@"sfasdf1"];
    [list addObject:@"sfasdf2"];

    self.orderList = [[NSArray alloc]initWithArray:list];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderReload:)
                                                 name:@"orderReload" object:nil];
    
    UINib *cellNib = [UINib nibWithNibName:@"DAOrderCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"DAOrderCell"];

}

- (void)orderReload:(NSNotification*) notification
{

    id obj = [notification object];
    NSLog(@"%@",obj);
    [list addObject:obj];
    self.orderList = [[NSArray alloc]initWithArray:list];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"DAOrderCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier forIndexPath:indexPath];
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:11];
    NSUInteger row = [indexPath row];
    titleLabel.text = [self.orderList objectAtIndex:row];

    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [indexPath row];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.orderList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] % 2 == 0) {
//        cell.backgroundColor = [UIColor blueColor];
    } else {
//        cell.backgroundColor = [UIColor greenColor];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *msg = [[NSString alloc] initWithFormat:@"你选择的是:%@",[self.orderList objectAtIndex:[indexPath row]]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alert show];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"执行删除操作");
}


- (IBAction)putDone:(id)sender {

    UIStoryboard *OrderDetailViewStoryboard = [UIStoryboard storyboardWithName:@"DAMyOrderDetailViewStoryboard" bundle:nil];
    UIViewController *orderDetailVC = [OrderDetailViewStoryboard instantiateViewControllerWithIdentifier:@"orderDetailVC"];
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}



- (IBAction)overOrder:(id)sender {
}
@end