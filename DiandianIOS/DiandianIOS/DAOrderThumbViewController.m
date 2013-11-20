//
//  DAOrderThumbViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-11.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAOrderThumbViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "DADetailOrderViewController.h"

@interface DAOrderThumbViewController ()<DADetailOrderDelegate>

@end

@implementation DAOrderThumbViewController

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderReload:) name:@"orderReload" object:nil];
    self.dataList = [DAMenuList alloc];
    self.dataList.items = [[NSArray alloc] init];
    UINib *cellNib = [UINib nibWithNibName:@"DAMyOrderCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"DAMyOrderCell"];
}

- (void)orderReload :(NSNotification*) notification
{
    
    DAMenu *obj = [notification object];
    for (DAMenu *menu in self.dataList.items) {
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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self tableViewReload];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    DAMenu *menudata = [self.dataList.items objectAtIndex:row];
    static NSString *CellWithIdentifier = @"DAMyOrderCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 86, 76)];
    [imageView setImage:[UIImage imageNamed:menudata.image]];
    UILabel *amountLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 66, 40, 20)];
    amountLabel.text = [NSString stringWithFormat:@"%@份",menudata.amount ];
    [cell addSubview:imageView];
    [cell addSubview:amountLabel];
    
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
    return 100;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([indexPath row] % 2 == 0) {

    } else {
        cell.backgroundColor = [UIColor lightGrayColor];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *msg = [[NSString alloc] initWithFormat:@"你选择的是:%@",[self.dataList.items objectAtIndex:[indexPath row]]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alert show];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"执行删除操作");
}


-(void)backButtonClicked:(DADetailOrderViewController*)secondDetailViewController{
    [self loadTableFromDisk];
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    [self tableViewReload];
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

- (IBAction)popupOrderDetail:(id)sender {
    DADetailOrderViewController *secondDetailViewController = [[DADetailOrderViewController alloc] initWithNibName:@"DADetailOrderViewController" bundle:nil];
    secondDetailViewController.delegate = self;
    secondDetailViewController.tableNO = self.tableNO;
    
    [self presentPopupViewController:secondDetailViewController animationType:MJPopupViewAnimationFade];
}
-(void)loadAmountPrice
{
    int amountPrice = 0 ;
    for (DAMenu *menu in self.dataList.items) {
        amountPrice = amountPrice + [menu.price integerValue] * [menu.amount integerValue];
    }
    self.labelAmount.text = [NSString stringWithFormat:@"总价:%d元" ,amountPrice];
    
}
@end
