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
#import "DAPickAmountViewController.h"

#define AMOUNT_LABEL_TAG 101


@interface DADetailOrderViewController ()<DAMyOrderLoginDelegate>
{
    UIPopoverController *popover;
    DAPickAmountViewController *popoverContent;
}
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
    loginVC.curService = self.curService;
    
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
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = YES;
    // Do any additional setup after loading the view from its nib.
    self.tableView.layer.cornerRadius = 10;
    self.tableView.layer.masksToBounds = YES;
    
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
        
        BOOL fs = [self.orderList archiveRootObjectWithPath:@"orderList" withName:FILE_ORDER_LIST(self.curService._id)];
        if (fs) {
            NSLog(@"写入");
        }
    }
    [self.tableView reloadData];
    [self loadAmountPrice];
    
}

-(void)loadAmountPrice
{
    float amountPrice = 0 ;
    
    
    //新菜单 总价
    for (DAOrder *order in self.orderList.items) {
        if (order.amount == nil || [order.amount integerValue] == 0) {
            order.amount = [NSNumber numberWithInt:1];
        }
        int pirce = 0;
        if( [order.type integerValue] == 0){
            pirce = [order.item.itemPriceNormal intValue];
        } else {
            pirce = [order.item.itemPriceHalf intValue];
        }
        float amount = 1.0;
        NSString *amountNum = [NSString stringWithFormat:@"%@.%@",order.amount,order.amountNum];
        amount = [amountNum floatValue];
        amountPrice = amountPrice + pirce * amount;
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
    
    self.amountPriceLabel.text = [NSString stringWithFormat:@"总价 : %.2f 元" ,amountPrice];
    
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
    
    if ([orderItem.back integerValue] == 2) {
        nameLabel.text = [NSString stringWithFormat:@"%@(已退)", nameLabel.text];
    } else {
     
    }
    
    
    UILabel *amountLabel = (UILabel *)[cell viewWithTag:13];

    //TODO  两份合成一份  orderItem.item.amount
    amountLabel.text = [NSString stringWithFormat:@"%@." , orderItem.amount];
    
    UITextField *remarkField = (UITextField * ) [cell viewWithTag:14];
    
    
    
    if (indexPath.section == 0) {

//        [addBtn setEnabled:YES];
//        [deleteBtn setEnabled:YES];
//        [addBtn setHidden:NO];
//        [deleteBtn setHidden:NO];
        [remarkField setEnabled:YES];
        cell.backgroundColor = [UIColor clearColor];
    } else {
        
        [remarkField setEnabled:NO];
        cell.backgroundColor = [UIColor lightGrayColor];
    }
    
    
    DAOrderAddAmountBtn *addBtn = (DAOrderAddAmountBtn *) [cell viewWithTag:26];
    addBtn.amountLabel = amountLabel;
    addBtn.indexPath = indexPath;
    DAOrderAddAmountBtn *deleteBtn = (DAOrderAddAmountBtn *) [cell viewWithTag:25];
    deleteBtn.amountLabel = amountLabel;
    deleteBtn.indexPath = indexPath;
    addBtn._id = orderItem.item._id;
    
    deleteBtn._id = orderItem.item._id;
    [addBtn addTarget:self
               action:@selector(addAmount:) forControlEvents:UIControlEventTouchUpInside];
    
    [deleteBtn addTarget:self
                  action:@selector(deleteAmount:) forControlEvents:UIControlEventTouchUpInside];
    
    DAOrderAddAmountBtn *amountBtn = (DAOrderAddAmountBtn *) [cell viewWithTag:33];
    amountBtn.cell = cell;
    amountBtn.indexPath = indexPath;
    if (orderItem.amountNum.length == 0) {
        [amountBtn setTitle:@"00" forState:UIControlStateNormal];
    } else {
        [amountBtn setTitle:orderItem.amountNum forState:UIControlStateNormal];
    }

    [amountBtn addTarget:self
                  action:@selector(amountLabelListener:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    

}

-(void) amountLabelListener :(id)sender
{
    DAOrderAddAmountBtn *btn = (DAOrderAddAmountBtn *)sender;
    NSLog(@"fdfdf");
    DAPickAmountViewController *vc = [[DAPickAmountViewController alloc] initWithNibName:@"DAPickAmountViewController" bundle:nil];
    
    vc.selectedNum = ^(NSString *num1,NSString *num2){
        NSString *btnNum = [NSString stringWithFormat:@"%@%@",num1,num2];
        [btn setTitle:btnNum forState:UIControlStateNormal];
        DAOrder *orderItem = [self.orderList.items objectAtIndex:btn.indexPath.row];
        orderItem.amountNum = btnNum;
        NSLog(@"%@",self.orderList.items);
        [self tableViewReload];
    };
    popover = [[UIPopoverController alloc]initWithContentViewController:vc];
    popover.popoverContentSize = CGSizeMake(80, 240);
    
    [popover presentPopoverFromRect:CGRectMake(btn.cell.frame.origin.x+305, btn.cell.frame.origin.y+100, btn.cell.frame.size.width, btn.cell.frame.size.height) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
}

-(void) deleteAmount :(id)sender {
    DAOrderAddAmountBtn *btn = (DAOrderAddAmountBtn *)sender;
    NSLog(@"delete");
    NSString *amount =  btn.amountLabel.text;
    int value = [amount intValue];
    value = value - 1;
    btn.amountLabel.text = [NSString stringWithFormat:@"%d.",value];
    DAOrder *orderItem = [self.orderList.items objectAtIndex:btn.indexPath.row];
    orderItem.amount = [NSString stringWithFormat:@"%d",value];
    [self tableViewReload];
}
-(void) addAmount :(id)sender {
    DAOrderAddAmountBtn *btn = (DAOrderAddAmountBtn *)sender;
    
    NSLog(@"add");
    NSString *amount =  btn.amountLabel.text;
    int value = [amount intValue];
    value = value + 1;
    btn.amountLabel.text = [NSString stringWithFormat:@"%d.",value];
    DAOrder *orderItem = [self.orderList.items objectAtIndex:btn.indexPath.row];
    orderItem.amount = [NSString stringWithFormat:@"%d",value];
    [self tableViewReload];
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

        NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
        for (int i = 0 ; i < [self.orderList.items count]; i++) {
            DAOrder *myOrder = [self.orderList.items objectAtIndex:i];
            if (i != indexPath.row) {
                [tmpArray addObject:myOrder];
            }
        }
        
        self.orderList.items = [[NSArray alloc]initWithArray:tmpArray];
        [self tableViewReload];
    } else {
        [ProgressHUD showError:@"已经点的菜就不能删除"];
    }
    
}

- (void)confirmOrderButtonClicked:(DAMyOrderLoginViewController*)loginViewViewController
{
    //确认订单 并提交
    self.confirmCallback(loginViewViewController.labelTips.text);
    
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}
- (void)cancelOrderButtonClicked:(DAMyOrderLoginViewController*)loginViewViewController
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    //取消 返回桌台
    self.cancelCallback();
}
- (void)backmenuButtonClicked:(DAMyOrderLoginViewController*)loginViewViewController
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}


@end
