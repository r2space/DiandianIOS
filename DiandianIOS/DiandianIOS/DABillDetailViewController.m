//
//  DABillDetailViewController.m
//  DiandianIOS
//
//  Created by kita on 13-11-9.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DABillDetailViewController.h"
#import "DABillDetailViewCell.h"

@interface DABillDetailViewController ()
{
    DAMyOrderList *dataList;
}
@end

@implementation DABillDetailViewController

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
    dataList = [[DAMyOrderList alloc]init];
    dataList.items = [[NSArray alloc]init];
    UINib *cellNib = [UINib nibWithNibName:@"DABillDetailViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"DABillDetailViewCell"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadFromApi];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier ;
    
    cellIdentifier = @"DABillDetailViewCell";
    
    DABillDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    NSDictionary *d;
    if (indexPath.section == 0) {
        d = [_finfishList objectAtIndex:indexPath.row];
        [cell.btnOperation setTitle:@"免单" forState:UIControlStateNormal];
        DAOrder *order = [dataList.items objectAtIndex:indexPath.row];
        
        cell.lblName.text = order.item.itemName;
        
        if ([order.type integerValue ] == 0) {
            cell.lblPrice.text =[NSString stringWithFormat:@"%@元",order.item.itemPriceNormal];
        } else {
            cell.lblPrice.text =[NSString stringWithFormat:@"%@元",order.item.itemPriceHalf];
        }
        
        cell.lblAmount.text =[NSString stringWithFormat:@"%d",1];
        
        
    } else {
        d = [_cancelList objectAtIndex:indexPath.row];
        [cell.btnOperation setTitle:@"取消" forState:UIControlStateNormal];
    }
    

    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSDictionary *d;
//    if (indexPath.section == 0) {
//        d = [_finfishList objectAtIndex:indexPath.row];
//        [_finfishList removeObjectAtIndex:indexPath.row];
//        [_cancelList addObject:d];
//    } else {
//        d = [_cancelList objectAtIndex:indexPath.row];
//        [_cancelList removeObjectAtIndex:indexPath.row];
//        [_finfishList addObject:d];
//    }
//    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [dataList.items count];
    } else {
        return _cancelList.count;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"已点";
    }
    if (section == 1) {
        return @"免单";
    }
    
    return nil;
}
- (IBAction)cancelTouched:(id)sender {
    if (self.chanelBlock) {
        self.chanelBlock();
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (void) loadFromApi
{
    
    [[DAOrderModule alloc] getOrderListByServiceId:self.curService._id callback:^(NSError *err, DAMyOrderList *list) {
        
        dataList = list;
        [self.tableView reloadData];
        
    }];
    
}

@end
