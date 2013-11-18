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
    
    UINib *cellNib = [UINib nibWithNibName:@"DABillDetailViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"DABillDetailViewCell"];
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
        [cell.btnOperation setTitle:@"退菜" forState:UIControlStateNormal];
    } else {
        d = [_cancelList objectAtIndex:indexPath.row];
        [cell.btnOperation setTitle:@"取消" forState:UIControlStateNormal];
    }
    
    
    float price = [[d objectForKey:@"price"] floatValue];
    int amount = [[d objectForKey:@"amount"] floatValue];
    float off = [[d objectForKey:@"off"] floatValue];
    cell.lblName.text = [d objectForKey:@"name"];
    cell.lblPrice.text =[NSString stringWithFormat:@"%.02f元",price];
    cell.lblAmount.text =[NSString stringWithFormat:@"%d",amount];
    cell.lblOff.text =[NSString stringWithFormat:@"%.02f折",off];
    cell.lblPay.text =[NSString stringWithFormat:@"%.02f元",price*amount*off];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *d;
    if (indexPath.section == 0) {
        d = [_finfishList objectAtIndex:indexPath.row];
        [_finfishList removeObjectAtIndex:indexPath.row];
        [_cancelList addObject:d];
    } else {
        d = [_cancelList objectAtIndex:indexPath.row];
        [_cancelList removeObjectAtIndex:indexPath.row];
        [_finfishList addObject:d];
    }
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return _finfishList.count;
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
        return @"退菜";
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
@end
