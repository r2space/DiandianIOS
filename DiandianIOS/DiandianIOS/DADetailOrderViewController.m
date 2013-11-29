//
//  DADetailOrderViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-7.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DADetailOrderViewController.h"
#import "DAOrderAddAmountBtn.h"
#import "DAMyOrderLoginViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "DAMenuModule.h"
#import "DAMenuProxy.h"
#import "ProgressHUD.h"


#define AMOUNT_LABEL_TAG 101


@interface DADetailOrderViewController ()<DAMyOrderLoginDelegate>
@property (nonatomic, strong) UIPopoverController *remarkViewPopover;
@end

@implementation DADetailOrderViewController
- (IBAction)closePopup:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
    }
}


- (IBAction)confirmOrder:(id)sender
{

//    if (self.delegate && [self.delegate respondsToSelector:@selector(confirmButtonClicked:)]) {
//        [self.delegate confirmButtonClicked:self];
//    }
    
    DAMyOrderLoginViewController * loginVC =[[DAMyOrderLoginViewController alloc]initWithNibName:@"DAMyOrderLoginViewController" bundle:nil];
    loginVC.delegate = self;
    [self presentPopupViewController:loginVC animationType:MJPopupViewAnimationFade];
}

- (IBAction)backTableClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(backButtonClicked:)]) {
        [self.delegate backButtonClicked:self];
    }
}

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
    
    UINib *cellNib = [UINib nibWithNibName:@"DADetailOrderCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"DADetailOrderCell"];
    [self loadTableFromDisk];
    [self loadAmountPrice];
    
}

-(void) viewDidAppear:(BOOL)animated
{
    
}

-(BOOL) loadTableFromDisk
{
    NSArray*paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                        NSUserDomainMask, YES);
    if([paths count]>0){
        
        self.orderList = [[DAMyOrderList alloc]unarchiveObjectWithFileWithPath:@"orderList" withName:FILE_ORDER_LIST(self.curService._id)];
        [self.tableView reloadData];
        return YES;
    }
    
    
    return NO;
}

-(void) tableViewReload
{
    NSArray*paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                        NSUserDomainMask, YES);
    if([paths count]>0){
        
//        BOOL fs = [self.orderList archiveRootObjectWithPath:@"orderList" withName:FILE_ORDER_LIST(self.curService._id)];
//        if (fs) {
//            NSLog(@"xieru");
//        }
    }
    [self.tableView reloadData];
    [self loadAmountPrice];
    
}

-(void)loadAmountPrice
{
    int amountPrice = 0 ;
    
    
    //新菜单 总价
    for (DAOrder *order in self.orderList.items) {
        if (order.amount == nil || [order.amount integerValue] == 0) {
            order.amount = [NSNumber numberWithInt:1];
        }
        if( [order.type integerValue] == 0){
            amountPrice = amountPrice + [order.item.itemPriceNormal integerValue];
        } else {
            amountPrice = amountPrice + [order.item.itemPriceHalf integerValue];
        }
    }
    
    
    //老菜单 总价
    for (NSArray *oldArray in self.oldOrderDataList.oldItems) {
        for (DAOrder *order in oldArray) {
            if (order.amount == nil || [order.amount integerValue] == 0) {
                order.amount = [NSNumber numberWithInt:1];
            }
            if( [order.type integerValue] == 0){
                amountPrice = amountPrice + [order.item.itemPriceNormal integerValue] * [order.amount integerValue];
            } else {
                amountPrice = amountPrice + [order.item.itemPriceHalf integerValue] * [order.amount integerValue];
            }
            
        }
    }
    
    self.amountPriceLabel.text = [NSString stringWithFormat:@"总价 : %d 元" ,amountPrice];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"DADetailOrderCell";
    DAOrder *orderItem;
    if (indexPath.section == 0) {
        orderItem = [self.orderList.items objectAtIndex:indexPath.row];
    } else {
        NSArray *curOrderItemList = [self.oldOrderDataList.oldItems objectAtIndex:(indexPath.section - 1)];
        orderItem = [curOrderItemList objectAtIndex:indexPath.row];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier forIndexPath:indexPath];
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:9];

    imageView.image = [DAMenuProxy getImageFromDisk:orderItem.item.smallimage];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:10];
    UILabel *pirceLabel = (UILabel *)[cell viewWithTag:11];
    //TODO  半分
    if ([orderItem.type integerValue] == 0) {
        nameLabel.text = orderItem.item.itemName;
        pirceLabel.text = [NSString stringWithFormat:@"%@元/盘",orderItem.item.itemPriceNormal];
    } else {
        nameLabel.text = [NSString stringWithFormat:@"%@(小)",orderItem.item.itemName];
        pirceLabel.text = [NSString stringWithFormat:@"%@元/盘",orderItem.item.itemPriceHalf];
    }
    
    
    UILabel *amountLabel = (UILabel *)[cell viewWithTag:13];
    //TODO  两份合成一份  orderItem.item.amount
    amountLabel.text = [NSString stringWithFormat:@"%@份" , orderItem.amount];
    
    UITextField *remarkField = (UITextField * ) [cell viewWithTag:14];
    
    DAOrderAddAmountBtn *addBtn = (DAOrderAddAmountBtn *) [cell viewWithTag:20];
    DAOrderAddAmountBtn *deleteBtn = (DAOrderAddAmountBtn *) [cell viewWithTag:21];
    addBtn._id = orderItem.item._id;
    
    deleteBtn._id = orderItem.item._id;
    
    if (indexPath.section == 0) {
        [addBtn addTarget:self
                   action:@selector(addAmount:) forControlEvents:UIControlEventTouchUpInside];
        
        [deleteBtn addTarget:self
                      action:@selector(deleteAmount:) forControlEvents:UIControlEventTouchUpInside];
        [addBtn setHidden:NO];
        [deleteBtn setHidden:NO];
        [remarkField setEnabled:YES];
        cell.backgroundColor = [UIColor clearColor];
    } else {
        [addBtn setHidden:YES];
        [deleteBtn setHidden:YES];
        [remarkField setEnabled:NO];
        cell.backgroundColor = [UIColor lightGrayColor];
    }
    [addBtn setHidden:YES];
    [deleteBtn setHidden:YES];
    return cell;

    
}

-(void) deleteAmount :(id)sender {
    DAOrderAddAmountBtn *btn = (DAOrderAddAmountBtn *)sender;
    
    for (DAMenu *menu in self.orderList.items) {
        if (menu._id == btn._id) {
            if (![menu.amount isEqualToString:@"1"]) {
                int amount = [menu.amount integerValue] - 1;
                menu.amount = [NSString stringWithFormat:@"%d", amount];
                [self tableViewReload];
                return;
            }
            
        }
    }
}
-(void) addAmount :(id)sender {
    DAOrderAddAmountBtn *btn = (DAOrderAddAmountBtn *)sender;
    
    for (DAMenu *menu in self.orderList.items) {
        if (menu._id == btn._id) {
            int amount = [menu.amount integerValue] + 1;
            menu.amount = [NSString stringWithFormat:@"%d", amount];
            [self tableViewReload];
            return;
        }
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int num = 1;
    if (self.oldOrderDataList.oldItems.count > 0) {
        num += self.oldOrderDataList.oldItems.count;
    }
    return num;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        return @"新订单";
    }
    return [NSString stringWithFormat:@"%d号单",section];
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [indexPath row];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.orderList.items count];
    } else {
        NSArray *curArray = [self.oldOrderDataList.oldItems objectAtIndex:(section - 1)];
        if (curArray!=nil && [curArray count] > 0) {
            return [curArray count];
        } else {
            return 0;
        }

    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
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
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        NSLog(@"执行删除操作");
        DAMenu *menu = [self.orderList.items objectAtIndex:indexPath.row];
        NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
        for (DAMenu *mymenu in self.orderList.items) {
            if (menu._id != mymenu._id) {
                [tmpArray addObject:mymenu];
            }
        }
        self.orderList.items = [[NSArray alloc]initWithArray:tmpArray];
        [self tableViewReload];
    } else {
        [ProgressHUD showError:@"已经点的菜就不能删了啊,嘻嘻嘻"];
    }
    
}

- (void)confirmOrderButtonClicked:(DAMyOrderLoginViewController*)loginViewViewController
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    if (self.delegate && [self.delegate respondsToSelector:@selector(backButtonClicked:)]) {
        [self.delegate backButtonClicked:self];
    }

}
- (void)cancelOrderButtonClicked:(DAMyOrderLoginViewController*)loginViewViewController
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    if (self.delegate && [self.delegate respondsToSelector:@selector(backButtonClicked:)]) {
        [self.delegate backButtonClicked:self];
    }
}
- (void)backmenuButtonClicked:(DAMyOrderLoginViewController*)loginViewViewController
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}


@end
