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

    
    self.dataList = [DAMyMenuList alloc];
    self.dataList.items = [[NSArray alloc] init];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderReload:) name:@"orderReload" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationSetRecipe:) name:@"setRecipe" object:nil];
    
    UINib *cellNib = [UINib nibWithNibName:@"DAOrderCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"DAOrderCell"];
    [self tableViewReload];
   

}
-(void)loadAmountPrice
{
    int amountPrice = 0 ;
    for (DAMyMenu *menu in self.dataList.items) {
        amountPrice = amountPrice + [menu.price integerValue] * [menu.amount integerValue];
    }
    self.labelAmount.text = [NSString stringWithFormat:@"总价:%d元" ,amountPrice];
    
}
-(BOOL) loadTableFromDisk
{
    NSArray*paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                        NSUserDomainMask, YES);
    if([paths count]>0){
        NSString *arrayPath =[[paths objectAtIndex:0]
                              stringByAppendingPathComponent:[NSString stringWithFormat:@"data_%@_orderList",self.tableNO]];
        
        self.dataList = [NSKeyedUnarchiver unarchiveObjectWithFile: arrayPath];
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
        NSString *arrayPath =[[paths objectAtIndex:0]
                              stringByAppendingPathComponent:[NSString stringWithFormat:@"data_%@_orderList",self.tableNO]];
        BOOL f = [NSKeyedArchiver archiveRootObject:self.dataList toFile:arrayPath];
        
        if (f) {
            NSLog(@"xieru");
        }
    }
    [self.tableView reloadData];
    [self loadAmountPrice];
    
}


- (void)orderReload :(NSNotification*) notification
{

    DAMyMenu *obj = [notification object];
    for (DAMyMenu *menu in self.dataList.items) {
        if (menu._id == obj._id) {
            int amount = [menu.amount integerValue] + 1;
            menu.amount = [NSString stringWithFormat:@"%d", amount];
            [self tableViewReload];
            return;
        }
    }
    NSLog(@"%@",obj);
    NSMutableArray *tmpList = [[NSMutableArray alloc] init];
    obj.amount = @"1";
    [tmpList addObject:obj];
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
    DAMyMenu *menudata = [self.dataList.items objectAtIndex:row];
    static NSString *CellWithIdentifier = @"DAOrderCell";
    DAOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier forIndexPath:indexPath];
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:11];
    UILabel *amountLabel = (UILabel *)[cell viewWithTag:12];
    titleLabel.text = menudata.name;
    amountLabel.text = [NSString stringWithFormat:@"%@份", menudata.amount];
    if (menudata.status!=nil && [menudata.status isEqualToString:@"doing"]) {
        
        return cell;
    }
    DAOrderAddAmountBtn *addBtn = (DAOrderAddAmountBtn *) [cell viewWithTag:20];
    DAOrderAddAmountBtn *deleteBtn = (DAOrderAddAmountBtn *) [cell viewWithTag:21];
    DAOrderRecipeBtn *recipeBtn = (DAOrderRecipeBtn *)[cell viewWithTag:31];
    addBtn.name = menudata.name;
    addBtn._id = menudata._id;
    deleteBtn.name = menudata.name;
    deleteBtn._id = menudata._id;
    
    recipeBtn.name = menudata.name;
    recipeBtn.orderId = menudata.name;
    [addBtn addTarget:self
               action:@selector(addAmount:) forControlEvents:UIControlEventTouchUpInside];
    
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
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    [self tableViewReload];
}

-(void)confirmButtonClicked:(DADetailOrderViewController*)secondDetailViewController{
    
    [self loadTableFromDisk];
    for (DAMyMenu *menu in self.dataList.items) {
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

    for (DAMyMenu *menu in self.dataList.items) {
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
    
    for (DAMyMenu *menu in self.dataList.items) {
        if (menu._id == btn._id) {
            int amount = [menu.amount integerValue] + 1;
            menu.amount = [NSString stringWithFormat:@"%d", amount];
            [self tableViewReload];
            return;
        }
    }
    
}

@end
