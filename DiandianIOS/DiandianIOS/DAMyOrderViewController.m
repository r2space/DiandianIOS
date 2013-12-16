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
#import "UIViewController+MJPopupViewController.h"
#import "DADetailOrderViewController.h"
#import "DAOrderRecipeBtn.h"
#import "DAMyOrderLoginViewController.h"
#import "DASocketIO.h"
#import "DAOrderProxy.h"
#import "DAPrintProxy.h"
#import "ProgressHUD.h"

@interface DAMyOrderViewController ()<DADetailOrderDelegate>
{
    DAMyOrderList *oldOrderDataList;
    DAMyOrderList *backOrderDataList;
    NSString *curWaitterUserId;
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
    curWaitterUserId = [[NSUserDefaults standardUserDefaults]  objectForKey:@"jp.co.dreamarts.smart.diandian.curWaitterUserId"];
    
    
    self.dataList = [DAMyOrderList alloc];
    self.dataList.items = [[NSArray alloc] init];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addOrder:) name:@"menu_addOrder" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addSmallItem:) name:@"menu_addSmallItem" object:nil];

    //
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [imageview setImage:[UIImage imageNamed:@"menubook_sidemiddle.png"]];
    [self.tableView setBackgroundView:imageview];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationSetRecipe:) name:@"setRecipe" object:nil];
    
    UINib *cellNib = [UINib nibWithNibName:@"DAOrderCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"DAOrderCell"];
    [self tableViewReload];
   

}

- (void) loadOldItem
{

    [DAOrderProxy getOldOrderListByServiceId:self.curService._id withBack:@"0,1,2,3" callback:^(NSError *err, DAMyOrderList *list) {
        
        oldOrderDataList = list;
        [self.tableView reloadData];
        [self loadAmountPrice];
    }];
}

-(void)loadAmountPrice
{
    
    int amountPrice = 0 ;
    for (DAOrder *order in self.dataList.items) {
        if( [order.type integerValue] == 0){
            amountPrice = amountPrice + [order.item.itemPriceNormal integerValue];
        } else {
            amountPrice = amountPrice + [order.item.itemPriceHalf integerValue];
        }
        
    }
    //老菜单 总价
    for (NSArray *oldArray in oldOrderDataList.oldItems) {
        for (DAOrder *order in oldArray) {
            if (order.amount == nil || [order.amount integerValue] == 0) {
                order.amount = [NSNumber numberWithInt:1];
            }
            if( [order.type integerValue] == 0){
                amountPrice = amountPrice + [order.item.itemPriceNormal integerValue] * [order.amount integerValue];
            } else {
                amountPrice = amountPrice + [order.item.itemPriceHalf integerValue]* [order.amount integerValue];
            }
            
        }
    }
    
    self.labelAmount.text = [NSString stringWithFormat:@"总价:%d元" ,amountPrice];
    
}
-(BOOL) loadTableFromDisk
{
    NSArray*paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                        NSUserDomainMask, YES);
    if([paths count]>0){
        
        self.dataList = [[DAMyOrderList alloc]unarchiveObjectWithFileWithPath:@"orderList" withName:FILE_ORDER_LIST(self.curService._id)];
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
        BOOL fs = [self.dataList archiveRootObjectWithPath:@"orderList" withName:FILE_ORDER_LIST(self.curService._id)];
        
        if (fs) {
            NSLog(@"xieru self.curService._id %@"  , self.curService._id);
        }
    }
    [self.tableView reloadData];
    [self loadAmountPrice];
    
}

- (void)addSmallItem :(NSNotification*) notification
{
    DAItem *obj = [notification object];
    DAOrder *_order = [[DAOrder alloc]init];
    _order.item = obj;
    _order.itemId = obj._id;
    _order.itemType = obj.type;
    _order.userId = curWaitterUserId;
    _order.deskId = self.curService.deskId;
    _order.serviceId = self.curService._id;
    _order.isNew = [NSString stringWithFormat:@"YES"];
    _order.type = [NSNumber numberWithInt:1];
    
    NSMutableArray *tmpList = [[NSMutableArray alloc] init];
    [tmpList addObject:_order];
    [tmpList addObjectsFromArray:self.dataList.items];
    self.dataList.items = [[NSArray alloc] initWithArray:tmpList];
    [self tableViewReload];
    
}

- (void)addOrder :(NSNotification*) notification
{

    DAItem *obj = [notification object];
    DAOrder *_order = [[DAOrder alloc]init];
    _order.item = obj;
    _order.itemId = obj._id;
    _order.itemType = obj.type;
    _order.userId = curWaitterUserId;
    _order.deskId = self.curService.deskId;
    _order.serviceId = self.curService._id;
    _order.isNew = [NSString stringWithFormat:@"YES"];
    _order.type = [NSNumber numberWithInt:0];
    
    NSMutableArray *tmpList = [[NSMutableArray alloc] init];
    [tmpList addObject:_order];
    [tmpList addObjectsFromArray:self.dataList.items];
    self.dataList.items = [[NSArray alloc] initWithArray:tmpList];
    [self tableViewReload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    DAOrder *orderdata;
    if (indexPath.section == 0) {
        orderdata = [self.dataList.items objectAtIndex:row];
    } else {
        NSArray *curOrderItemList = [oldOrderDataList.oldItems objectAtIndex:(indexPath.section - 1)];
        orderdata = [curOrderItemList objectAtIndex:indexPath.row];
    }
    DAItem *item = orderdata.item;
    static NSString *CellWithIdentifier = @"DAOrderCell";
    DAOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier forIndexPath:indexPath];
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:11];
    UILabel *amountLabel = (UILabel *)[cell viewWithTag:12];
    
    if ([orderdata.back integerValue] == 2) {
        titleLabel.text = [NSString stringWithFormat:@"(已退)%@",item.itemName];
    } else {
        titleLabel.text = item.itemName;
    }
    
    if ([orderdata.type integerValue] == 0) {
        titleLabel.text = item.itemName;
    
    } else {
        titleLabel.text = [NSString stringWithFormat:@"%@(小)",item.itemName];
    }
    
    amountLabel.text = [NSString stringWithFormat:@"%@份", item.amount];
    

    DAOrderAddAmountBtn *deleteBtn = (DAOrderAddAmountBtn *) [cell viewWithTag:123];
    DAOrderRecipeBtn *recipeBtn = (DAOrderRecipeBtn *)[cell viewWithTag:31];

    deleteBtn.name = item.itemName;
    deleteBtn._id = item._id;
    
    recipeBtn.name = item.itemName;
    recipeBtn.orderId = item._id;

//    [deleteBtn addTarget:self
//               action:@selector(deleteAmount:) forControlEvents:UIControlEventTouchUpInside];
//    [recipeBtn addTarget:self action:@selector(updateRecipe: ) forControlEvents:UIControlEventTouchUpInside];
    if (indexPath.section == 0) {

//        cell.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor blackColor];
    } else {
//        cell.backgroundColor = [UIColor lightGrayColor];
        titleLabel.textColor = [UIColor darkGrayColor];
    }
    cell.backgroundColor = [UIColor clearColor];
    

    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int num = 1;
    if (oldOrderDataList.oldItems.count > 0) {
        num += oldOrderDataList.oldItems.count;
    }
    return num;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *image= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0.0, 140, 0)];
    image.backgroundColor= [UIColor clearColor];
    
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor blackColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:12];
    headerLabel.frame = CGRectMake(10.0, 0.0, 140.0, 44.0);
    
    if (section == 0) {
        headerLabel.text = @"新订单";
    } else {
        headerLabel.text = [NSString stringWithFormat:@"%d号单",section];
    }
    
    [image addSubview:headerLabel];
    
    return image;
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
        return [self.dataList.items count];
    } else {
        NSArray *curArray = [oldOrderDataList.oldItems objectAtIndex:(section - 1)];
        if (curArray!=nil && [curArray count] > 0) {
            return [curArray count];
        } else {
            return 0;
        }
        
    }
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

    if (indexPath.section == 0) {
        
        DAOrder *_order = [self.dataList.items objectAtIndex:indexPath.row];
        
        NSNotification *orderReloadNotification = [NSNotification notificationWithName:@"popupDetailMenu" object:_order.item];
        
        [[NSNotificationCenter defaultCenter] postNotification:orderReloadNotification];
        
    } else {
        
        NSArray *curArray = [oldOrderDataList.oldItems objectAtIndex:(indexPath.section - 1)];
        DAOrder *_order  = [curArray objectAtIndex:indexPath.row];
        
        NSNotification *orderReloadNotification = [NSNotification notificationWithName:@"popupDetailMenu" object:_order.item];
        
        [[NSNotificationCenter defaultCenter] postNotification:orderReloadNotification];
        
    }
    
    
}


- (IBAction)backTopMenu:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)putDone:(id)sender {

    DADetailOrderViewController *detailOrderVC = [[DADetailOrderViewController alloc] initWithNibName:@"DADetailOrderViewController" bundle:nil];
    detailOrderVC.delegate = self;
    detailOrderVC.oldOrderDataList = oldOrderDataList;
    detailOrderVC.curService = self.curService;
    detailOrderVC.confirmCallback = ^(NSString *tips){
        [self loadTableFromDisk];
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
        
        
        //改为接口提交订单

        [ProgressHUD show:nil];
        NSString *deskId = [NSString stringWithFormat:@""];
        
        if ([self.curService.type integerValue] != 3) {
            deskId = [NSString stringWithFormat:@"%@" ,self.curService.deskId];
        }
        
        
        [[DAOrderModule alloc] addOrder:[self.dataList toArray] serviceId:self.curService._id deskId:deskId callback:^(NSError *err, DAMyOrderList *list) {
            
            if ([self.curService.type integerValue] == 3) {
                [DAPrintProxy addOrderPrintWithOrderList:self.dataList deskName:list.deskName orderNum:list.orderNum now:list.now takeout:self.curService.phone tips:@""];
            } else {
                [DAPrintProxy addOrderPrintWithOrderList:self.dataList deskName:list.deskName orderNum:list.orderNum now:list.now takeout:@"" tips:tips];
            }
            
            [ProgressHUD dismiss];
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        
        
    };
    detailOrderVC.cancelCallback = ^(){
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    
    [self presentPopupViewController:detailOrderVC animationType:MJPopupViewAnimationFade];
    
}

-(void)updateRecipe:(id)sender 
{
    
    DADetailOrderViewController *secondDetailViewController = [[DADetailOrderViewController alloc] initWithNibName:@"DADetailOrderViewController" bundle:nil];
    secondDetailViewController.delegate = self;
    [self presentPopupViewController:secondDetailViewController animationType:MJPopupViewAnimationFade];
}


-(void)backButtonClicked:(DADetailOrderViewController*)secondDetailViewController{
    [self loadTableFromDisk];
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    //SOCKETIO提交订单
    DASocketIO *socket = [DASocketIO sharedClient:self];
    [socket conn];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:[self.dataList toArray] forKey:@"orderList"];
    [dic setValue:self.curService.deskId forKey:@"deskId"];
//    [socket sendJSONwithAction:@"addOrder" data:[[NSDictionary alloc]initWithDictionary:dic]];
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)confirmButtonClicked:(DADetailOrderViewController*)secondDetailViewController{
    
    [self loadTableFromDisk];
    for (DAMenu *menu in self.dataList.items) {
        menu.status = [NSString stringWithFormat:@"doing"];
        
    }
    
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    [self tableViewReload];
    
    
}


- (void)cancelButtonClicked:(DADetailOrderViewController*)secondDetailViewController{
    [self loadTableFromDisk];
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    [self tableViewReload];
    
}



-(void) notificationSetRecipe :(NSNotification *)notification
{
    DADetailOrderViewController *secondDetailViewController = [[DADetailOrderViewController alloc] initWithNibName:@"DADetailOrderViewController" bundle:nil];
    secondDetailViewController.delegate = self;
    [self presentPopupViewController:secondDetailViewController animationType:MJPopupViewAnimationFade];
}

-(void) deleteAmount :(id)sender {
    DAOrderAddAmountBtn *btn = (DAOrderAddAmountBtn *)sender;

    
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    for (DAMenu *mymenu in self.dataList.items) {
        if (![mymenu._id isEqualToString:btn._id]) {
            [tmpArray addObject:mymenu];
        }
    }
    self.dataList.items = [[NSArray alloc]initWithArray:tmpArray];
    [self tableViewReload];
}

-(void) addAmount :(id)sender {
    DAOrderAddAmountBtn *btn = (DAOrderAddAmountBtn *)sender;
    
    for (DAMenu *menu in self.dataList.items) {
        if ([menu._id isEqualToString: btn._id]) {
            int amount = [menu.amount integerValue] + 1;
            menu.amount = [NSString stringWithFormat:@"%d", amount];
            [self tableViewReload];
            return;
        }
    }
    
}

- (void)backmenuButtonClicked:(DAMyOrderLoginViewController*)loginViewViewController
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

- (void)cancelOrderButtonClicked:(DAMyOrderLoginViewController*)loginViewViewController;
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)confirmOrderButtonClicked:(DAMyOrderLoginViewController*)loginViewViewController;
{
    
    
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)loadOrderList
{
    if ( self.curService !=nil && self.curService._id.length >0 ) {
        
        [[DAOrderModule alloc]getOrderListByServiceId:self.curService._id withBack:@"0,1,2,3" callback:^(NSError *err, DAMyOrderList *list) {
            
            [list archiveRootObjectWithPath:@"orderList" withName:FILE_ORDER_LIST(self.curService._id)];
            [self loadTableFromDisk];
            
        }];
        
    }
    
}


@end
