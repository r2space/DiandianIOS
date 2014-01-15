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
#import "DABillBackPopoverViewController.h"
#import "DAOrderModule.h"
#import "ProgressHUD.h"

@interface DABillDetailViewController ()
{
    DAMyOrderList *dataList;
    NSMutableArray *doneOrderList;
    NSMutableArray *undoneOrderList;
    NSMutableArray *backOrderList;
    NSMutableArray *freeOrderList;
    UIPopoverController *popover;
    
    NSMutableArray *backDataList;
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
    backDataList = [[NSMutableArray alloc]init];
    
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
        cell.lblAmountPrice.text = [NSString stringWithFormat:@"%0.2f",[order.amountPrice floatValue]];

        if ([order.type integerValue ] == 0) {
            cell.lblPrice.text =[NSString stringWithFormat:@"%@元",order.item.itemPriceNormal];
        } else {
            cell.lblPrice.text =[NSString stringWithFormat:@"%@元",order.item.itemPriceHalf];
        }
        
        cell.lblAmount.text =[NSString stringWithFormat:@"%0.2f",[order.amount floatValue]];
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
            [backBtn setHidden:YES];
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
    NSLog(@"didSelectRow");
    backDataList = [[NSMutableArray alloc]init];
    if (indexPath.section == 0) {

        DAOrder *order = [doneOrderList objectAtIndex:indexPath.row];
        
            order.willBackAmount = order.amount;
            [backDataList addObject:order];
    }
    
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
    [DAPrintProxy printBill:self.curService._id off:self.offAmount pay:self.payAmount type:0 reduce:self.reduceAmount];
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
    [ProgressHUD show:@"加载。"];
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
        [ProgressHUD dismiss];
    }];
    
}
//0:主食 1:菜品 2:酒水 3:海鲜 
//0:主食 1:菜品 2:酒水 3:海鲜
- (IBAction)onBackWhenBillTouched:(UIButton *)sender {
    NSLog(@"退菜");
    
    if ([backDataList count] == 0) {
        [ProgressHUD showError:@"请选择菜品"];
        return;
    }
    
    DAOrder *order = [backDataList objectAtIndex:0];
    NSLog(@"%@",order);
    if ([order.item.type intValue] == 1 || [order.item.type intValue] == 3) {
        [ProgressHUD showError:@"请选择酒水或主食"];
        return;
    }
    
    DABillBackPopoverViewController* vCtrl = [[DABillBackPopoverViewController alloc] initWithNibName:@"DABillBackPopoverViewController" bundle:nil];
    
    vCtrl.backDataList = backDataList;
    vCtrl.curService = self.curService;
    vCtrl.closeBackView = ^(){
        [popover dismissPopoverAnimated:YES];
        backDataList = [[NSMutableArray alloc]init];
        [self loadFromApi];
        
        
    };
    popover = [[UIPopoverController alloc]initWithContentViewController:vCtrl];
    popover.popoverContentSize = CGSizeMake(328, 256);
    
    [popover presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    
}

@end
