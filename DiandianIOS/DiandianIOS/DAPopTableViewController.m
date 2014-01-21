//
//  DAPopTableViewController
//  DiandianIOS
//
//  Created by Xu Yang on 11/12/13.
//  Copyright (c) 2013 DAC. All rights reserved.
//

#import "DAPopTableViewController.h"
#import "DAPopTableViewCell.h"
#import "SmartSDK.h"

@interface DAPopTableViewController ()

@end

@implementation DAPopTableViewController
{
    NSArray* listData;
    NSString* targetTag;
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)initData:(NSString*) tag list:(NSArray*) list
{
    targetTag = tag;
    listData = list;
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    listData = [[NSArray alloc]init];
    [self.tableView registerClass:[DAPopTableViewCell class] forCellReuseIdentifier:@"Cell"];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DAPopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if ([@"people" isEqualToString:targetTag]) {
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[listData objectAtIndex:indexPath.row]];
        
    }  else if ([@"user" isEqualToString:targetTag]) {
        
        DAUser *user = [listData objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",user.name];
        
    
    } else {
        
        DAOrder *order = [listData objectAtIndex:indexPath.row];
        if (order.amount !=nil) {
            if ([order.hasBack intValue]  == 1 ) {
                if ([order.type integerValue] == 0) {
                    cell.textLabel.text = [NSString stringWithFormat:@"退了-%@   X %@ ",order.item.itemName,order.amount];
                } else {
                    cell.textLabel.text = [NSString stringWithFormat:@"退了-%@(小)   X %@ ",order.item.itemName,order.amount];
                }
            } else {
                if ([order.type integerValue] == 0) {
                    cell.textLabel.text = [NSString stringWithFormat:@"%@   X %@",order.item.itemName,order.amount];
                } else {
                    cell.textLabel.text = [NSString stringWithFormat:@"(小)%@   X %@",order.item.itemName,order.amount];
                }
            }
        
            
        } else {
            cell.textLabel.text = [NSString stringWithFormat:@"%@",order.item.itemName];
        }
        
   
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate != nil) {
        if ([@"user" isEqualToString:targetTag]) {
            DAUser *user = [listData objectAtIndex:indexPath.row];
            
            [self.delegate popTableViewSelectRow:targetTag value:user];
            
        }
        if ([@"people" isEqualToString:targetTag]) {
            
            [self.delegate popTableViewSelectRow:targetTag value:[listData objectAtIndex:indexPath.row]];
        }
    }

   
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
