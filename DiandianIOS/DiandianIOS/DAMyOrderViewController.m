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


@interface DAMyOrderViewController ()<DADetailOrderDelegate>
{

    
    
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
    self.tableNO = @"01";
    // Do any additional setup after loading the view from its nib.
//    NSArray *list = [NSArray arrayWithObjects:@"fd",@"sdfdf",nil];

    
    self.dataList = [DAMyOrderList alloc];
    self.dataList.items = [[NSArray alloc] init];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addOrder:) name:@"addOrder" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationSetRecipe:) name:@"setRecipe" object:nil];
    
    UINib *cellNib = [UINib nibWithNibName:@"DAOrderCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"DAOrderCell"];
    [self tableViewReload];
   

}
-(void)loadAmountPrice
{
    
    int amountPrice = 0 ;
    for (DAOrder *order in self.dataList.items) {
        amountPrice = amountPrice + [order.item.price integerValue];
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
            NSLog(@"xieru");
        }
    }
    [self.tableView reloadData];
    [self loadAmountPrice];
    
}


- (void)addOrder :(NSNotification*) notification
{

    DAItem *obj = [notification object];
    DAOrder *_order = [[DAOrder alloc]init];
    _order.item = obj;
    _order.itemId = obj._id;
    _order.deskId = self.curService.deskId;
    _order.serviceId = self.curService._id;
    _order.isNew = @"YES";
    
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
    DAOrder *orderdata = [self.dataList.items objectAtIndex:row];
    DAItem *item = orderdata.item;
    static NSString *CellWithIdentifier = @"DAOrderCell";
    DAOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier forIndexPath:indexPath];
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:11];
    UILabel *amountLabel = (UILabel *)[cell viewWithTag:12];
    titleLabel.text = item.name;
    amountLabel.text = [NSString stringWithFormat:@"%@份", item.amount];
//    if (item.status!=nil && [item.status isEqualToString:@"doing"]) {
//        
//        return cell;
//    }

    DAOrderAddAmountBtn *deleteBtn = (DAOrderAddAmountBtn *) [cell viewWithTag:123];
    DAOrderRecipeBtn *recipeBtn = (DAOrderRecipeBtn *)[cell viewWithTag:31];

    deleteBtn.name = item.name;
    deleteBtn._id = item._id;
    
    recipeBtn.name = item.name;
    recipeBtn.orderId = item._id;

    [deleteBtn addTarget:self
               action:@selector(deleteAmount:) forControlEvents:UIControlEventTouchUpInside];
    [recipeBtn addTarget:self action:@selector(updateRecipe: ) forControlEvents:UIControlEventTouchUpInside];


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
    
    return [self.dataList.items count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 73;
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
    NSNotification *orderReloadNotification = [NSNotification notificationWithName:@"popupDetailMenu" object:[self.dataList.items objectAtIndex:indexPath.row]];
    
    [[NSNotificationCenter defaultCenter] postNotification:orderReloadNotification];
    
//    NSString *msg = [[NSString alloc] initWithFormat:@"你选择的是:%@",[self.dataList.items objectAtIndex:[indexPath row]]];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    
//    [alert show];
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"执行删除操作");
//}


- (IBAction)backTopMenu:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)putDone:(id)sender {

    DADetailOrderViewController *secondDetailViewController = [[DADetailOrderViewController alloc] initWithNibName:@"DADetailOrderViewController" bundle:nil];
    secondDetailViewController.delegate = self;
    secondDetailViewController.tableNO = self.tableNO;
    
    secondDetailViewController.curService = self.curService;
    
    [self presentPopupViewController:secondDetailViewController animationType:MJPopupViewAnimationFade];
    
}
-(void)updateRecipe:(id)sender 
{
    DAOrderRecipeBtn *btn = (DAOrderRecipeBtn *)sender;
    
    NSLog(@"%s  %@  %@",   __FUNCTION__  ,btn.name,btn.orderId);
    DADetailOrderViewController *secondDetailViewController = [[DADetailOrderViewController alloc] initWithNibName:@"DADetailOrderViewController" bundle:nil];
    secondDetailViewController.delegate = self;
    [self presentPopupViewController:secondDetailViewController animationType:MJPopupViewAnimationFade];
}


-(void)backButtonClicked:(DADetailOrderViewController*)secondDetailViewController{
    [self loadTableFromDisk];
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    [self tableViewReload];
    
    
    //提交订单
    DASocketIO *socket = [DASocketIO sharedClient:self];
    [socket conn];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:[self.dataList toArray] forKey:@"orderList"];
    [socket sendJSONwithAction:@"addOrder" data:[[NSDictionary alloc]initWithDictionary:dic]];
    
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


- (IBAction)overOrder:(id)sender {
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
    if ( self.serviceId !=nil && self.serviceId.length >0 ) {
        
        [[DAOrderModule alloc]getOrderListByServiceId:self.serviceId callback:^(NSError *err, DAMyOrderList *list) {
            
            [list archiveRootObjectWithPath:@"orderList" withName:FILE_ORDER_LIST(self.serviceId )];
            [self loadTableFromDisk];
            
        }];
        
    }
    
}


@end
