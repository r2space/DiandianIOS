//
//  DAOrderDetailViewController.m
//  DiandianIOS
//
//  Created by LI LIN on 2013/11/09.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAOrderDetailViewController.h"
#import "DAOrderDetailViewCell.h"

@interface DAOrderDetailViewController ()
{
    NSMutableArray *dataList;
}

@end

@implementation DAOrderDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [self loadFromFile];

    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    DDLogWarn(@"didReceiveMemoryWarning  :  %@" ,[self class]);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DAOrderDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DAOrderDetailViewCell"];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"DAOrderDetailViewCell" owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }

    NSDictionary *row = [dataList objectAtIndex:indexPath.row];
    
    cell.imgItem.image = [UIImage imageNamed:[row objectForKey:@"image"]];
    
    cell.lblItemName.text = [row objectForKey:@"name"];
    cell.lblTable.text = [row objectForKey:@"table"];
    cell.lblTicket.text = [row objectForKey:@"ticket"];
    cell.lblWaitingTime.text = [row objectForKey:@"waitingtime"];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];

    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
 
 */

- (void)loadFromFile {
    NSString *pathString = [[NSBundle mainBundle] pathForResource:@"queue_detail" ofType:@"json"];
    NSData *elementsData = [NSData dataWithContentsOfFile:pathString];
    
    NSError *anError = nil;
    NSArray *items = [NSJSONSerialization JSONObjectWithData:elementsData
                                                     options:NSJSONReadingAllowFragments
                                                       error:&anError];
    
    dataList = [[NSMutableArray alloc] init];
    for (NSDictionary *d in items){
        [dataList addObject:d];
    }
}

@end
