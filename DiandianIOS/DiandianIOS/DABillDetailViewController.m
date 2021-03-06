//
//  DABillDetailViewController.m
//  DiandianIOS
//
//  Created by kita on 13-11-9.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DABillDetailViewController.h"
#import "DABillDetailViewCell.h"
#import "DAPrintProxy.h"

@interface DABillDetailViewController ()
{
    DAMyOrderList *dataList;
    NSMutableArray *doneOrderList;
    NSMutableArray *undoneOrderList;
    NSMutableArray *backOrderList;
    NSMutableArray *freeOrderList;
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
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = YES;

    
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
   

        NSInteger section = indexPath.section;
    DAOrder *order;
    if (section == 0) {
        order = [doneOrderList objectAtIndex:indexPath.row];
        //        return @"已上菜单";
    } else if (section == 1) {
        order = [undoneOrderList objectAtIndex:indexPath.row];
        //        return @"未上菜单";
    } else if (section == 2) {
        order = [backOrderList objectAtIndex:indexPath.row];
        //        return @"退菜菜单";
    } else {
        order = [freeOrderList objectAtIndex:indexPath.row];
        //        return @"免单菜单";
    }


        [cell.btnOperation setTitle:@"免单" forState:UIControlStateNormal];
    
        cell.order = order;
        cell.lblName.text = order.item.itemName;
    

        if ([order.type integerValue ] == 0) {
            cell.lblPrice.text =[NSString stringWithFormat:@"%@元",order.item.itemPriceNormal];
        } else {
            cell.lblPrice.text =[NSString stringWithFormat:@"%@元",order.item.itemPriceHalf];
        }
        
        cell.lblAmount.text =[NSString stringWithFormat:@"%d",1];
        cell.backCallback = ^(){
            if (self.parentReloadBlock!=nil) {
                self.parentReloadBlock();
            }
            [self loadFromApi];
            
        };
    
        cell.freeCallback = ^(){
            if (self.parentReloadBlock!=nil) {
                self.parentReloadBlock();
            }
            [self loadFromApi];
        };
        
        UIButton *backBtn = (UIButton *)[cell viewWithTag:402];
        if ([order.back integerValue] == 0) {
            [backBtn setHidden:NO];
        } else {
            [backBtn setHidden:YES];
        }
    
        UIButton *freeBtn = (UIButton *)[cell viewWithTag:401];
    if ([order.back integerValue] == 1) {
        [freeBtn setHidden:NO];
    } else {
        [freeBtn setHidden:YES];
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
        return [doneOrderList count];
//        return @"已上菜单";
    } else if (section == 1) {
        return [undoneOrderList count];
//        return @"未上菜单";
    } else if (section == 2) {
        return [backOrderList count];
//        return @"退菜菜单";
    } else {
        return [freeOrderList count];
//        return @"免单菜单";
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"已上菜单";
    }
    if (section == 1) {
        return @"未上菜单";
    }
    if (section == 2) {
        return @"退菜菜单";
    }
    if (section == 3) {
        return @"免单菜单";
    }
    return nil;
}
- (IBAction)cancelTouched:(id)sender {
    if (self.chanelBlock) {
        self.chanelBlock();
    }
}

- (IBAction)onPrintTouched:(id)sender {
    [DAPrintProxy printBill:self.curService._id off:@"" pay:@"" type:0 reduce:@""];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}


- (void) loadFromApi
{
    doneOrderList = [[NSMutableArray alloc] init];
    freeOrderList = [[NSMutableArray alloc] init];
    undoneOrderList = [[NSMutableArray alloc] init];
    backOrderList = [[NSMutableArray alloc] init];
    
    [[DAOrderModule alloc] getOrderListByServiceId:self.curService._id withBack:@"0,1,2,3" callback:^(NSError *err, DAMyOrderList *list) {
        
        for (DAOrder *order in list.items) {
            if ([order.back integerValue] == 3) {
                [freeOrderList addObject:order];
            } else if  ([order.back integerValue] == 2) {
                [backOrderList addObject:order];
            } else if  ([order.back integerValue] == 1){
                [doneOrderList addObject:order];
            } else {
                [undoneOrderList addObject:order];
            }
            
        }
        dataList = list;
        [self.tableView reloadData];
        
    }];
    
}

@end
