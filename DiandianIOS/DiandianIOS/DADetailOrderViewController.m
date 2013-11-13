//
//  DADetailOrderViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-7.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DADetailOrderViewController.h"
#import "DAOrderAddAmountBtn.h"
#define AMOUNT_LABEL_TAG 101
@interface DADetailOrderViewController ()
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

    if (self.delegate && [self.delegate respondsToSelector:@selector(confirmButtonClicked:)]) {
        [self.delegate confirmButtonClicked:self];
    }
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

-(BOOL) loadTableFromDisk
{
    NSArray*paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                        NSUserDomainMask, YES);
    if([paths count]>0){
        NSString *arrayPath =[[paths objectAtIndex:0]
                              stringByAppendingPathComponent:[NSString stringWithFormat:@"data_%@_orderList",self.tableNO]];
        
        self.orderList = [NSKeyedUnarchiver unarchiveObjectWithFile: arrayPath];
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
        
        BOOL f = [NSKeyedArchiver archiveRootObject:self.orderList toFile:arrayPath];
        
        if (f) {
            NSLog(@"xieru");
        }
    }
    [self.tableView reloadData];
    [self loadAmountPrice];
    
}

-(void)loadAmountPrice
{
    int amountPrice = 0 ;
    for (DAMyMenu *menu in self.orderList.items) {
        amountPrice = amountPrice + [menu.price integerValue] * [menu.amount integerValue];
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
    DAMyMenu *menu = [self.orderList.items objectAtIndex:indexPath.row];
    static NSString *CellWithIdentifier = @"DADetailOrderCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier forIndexPath:indexPath];
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:9];
    imageView.image = [UIImage imageNamed:menu.image];
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:10];
    nameLabel.text = menu.name;
    UILabel *pirceLabel = (UILabel *)[cell viewWithTag:11];
    pirceLabel.text = [NSString stringWithFormat:@"%@元/盘",menu.price];
    UILabel *amountLabel = (UILabel *)[cell viewWithTag:13];
    amountLabel.text = [NSString stringWithFormat:@"%@份" ,menu.amount];
    
    DAOrderAddAmountBtn *addBtn = (DAOrderAddAmountBtn *) [cell viewWithTag:20];
    DAOrderAddAmountBtn *deleteBtn = (DAOrderAddAmountBtn *) [cell viewWithTag:21];

    addBtn._id = menu._id;

    deleteBtn._id = menu._id;
    [addBtn addTarget:self
               action:@selector(addAmount:) forControlEvents:UIControlEventTouchUpInside];
    
    [deleteBtn addTarget:self
                  action:@selector(deleteAmount:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void) deleteAmount :(id)sender {
    DAOrderAddAmountBtn *btn = (DAOrderAddAmountBtn *)sender;
    
    for (DAMyMenu *menu in self.orderList.items) {
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
    
    for (DAMyMenu *menu in self.orderList.items) {
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
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [indexPath row];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.orderList.items count];
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"执行删除操作");
    DAMyMenu *menu = [self.orderList.items objectAtIndex:indexPath.row];
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    for (DAMyMenu *mymenu in self.orderList.items) {
        if (menu._id != mymenu._id) {
            [tmpArray addObject:mymenu];
        }
    }
    self.orderList.items = [[NSArray alloc]initWithArray:tmpArray];
    [self tableViewReload];
    
}



@end
