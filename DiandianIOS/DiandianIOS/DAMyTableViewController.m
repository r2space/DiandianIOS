//
//  DAMyTableViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-6.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAMyTableViewController.h"
#import "DAMyTableViewCell.h"
#import "DAMyLoginViewController.h"
#import "DAMyTableConfirmController.h"
#import "DAAnimation.h"
#import "UIViewController+MJPopupViewController.h"
#import "DAMyOrderQueueViewController.h"
#import "DABillViewController.h"
#import "DAQueueMasterViewController.h"
#import "DAProcessionViewController.h"
#import <TribeSDK/DAMyTable.h>

@interface DAMyTableViewController ()<DAMyLoginDelegate, DAMyTableConfirmDelegate, DAProcessionViewDelegate>
{
    MSGridView *gridView;
    NSMutableArray *dataList;
    BOOL isTableFlicker;
    BOOL isStartChangeTable;
    BOOL isProcessionIntoTable;
    NSString * changeTableId;
}
@end

@implementation DAMyTableViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    dataList = [[NSMutableArray alloc] init];
    UINib *cellNib = [UINib nibWithNibName:@"DAMyTableViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"DAMyTableViewCell"];
    
    self.navigationController.navigationBarHidden = YES;
    
    isTableFlicker = false;
    isProcessionIntoTable = false;
    
    [self loadFromFile];
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[event.allTouches anyObject];
    if (![touch.view isEqual:self.collectionView]) {
        isStartChangeTable = NO;
        isProcessionIntoTable = NO;
        [self setTableFlicker:false];
        
    }
}

-(void)loadFromFile{
    NSString *pathString = [[NSBundle mainBundle] pathForResource:@"table" ofType:@"json"];
    NSData *elementsData = [NSData dataWithContentsOfFile:pathString];
    
    NSError *anError = nil;
    NSArray *items = [NSJSONSerialization JSONObjectWithData:elementsData
                                                              options:NSJSONReadingAllowFragments
                                                                error:&anError];
    
    for (NSDictionary *d in items){
        [dataList addObject: [[DAMyTable alloc]initWithDictionary:d]];
    }
}
- (DAMyTable*)getDataByTableId:(NSString*)tableId
{
    if (dataList == nil || dataList.count <= 0) {
        return nil;
    }
    
    for (DAMyTable *t in dataList) {
        if ([t.tableId isEqualToString:tableId]) {
            return t;
        }
    }
    
    return nil;
}

- (void)cancelButtonClicked:(DAMyLoginViewController*)loginViewViewController{
    
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    
}

- (void)startTableButtonClicked:(DAMyLoginViewController*)loginViewViewController{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    UIStoryboard *menubookStoryboard = [UIStoryboard storyboardWithName:@"DARootView" bundle:nil];
    UIViewController *menubookVC = [menubookStoryboard instantiateViewControllerWithIdentifier:@"menubookVC"];
    [self.navigationController pushViewController:menubookVC animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return dataList.count ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *cellIdentifier ;
    
    cellIdentifier = @"DAMyTableViewCell";
    
    DAMyTableViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    DAMyTable *t = [dataList objectAtIndex:indexPath.row];
    [cell setData:t.name setState:t.state];
    
    //NSString *imageName = [@"eating" isEqualToString:t.state] ? @"sample-table.jpg" : @"sample-table1.jpg";
    cell.imgTable.image = [UIImage imageNamed:@"sample-table.jpg"];
    
    cell.imgTable.layer.backgroundColor = [UIColor redColor].CGColor;
    cell.imgTable.layer.cornerRadius = 5.0;
    cell.imgTable.layer.masksToBounds = YES;
    //cell.imgTable.layer.mask = NO;
    
    cell.viewMask.layer.cornerRadius = 5.0;
    cell.viewMask.layer.masksToBounds = YES;

    cell.viewLabel.layer.cornerRadius = 3.0;
    cell.viewLabel.layer.masksToBounds = YES;
    
    // 设置空桌的效果
    if (![@"empty" isEqualToString:t.state])
    {
        cell.viewMask.hidden = YES;
    }else {
        cell.viewMask.hidden = NO;
    }
    // 设置换桌的动画效果
    if (isTableFlicker && [@"empty" isEqualToString:t.state]) {
        [DAAnimation addFlickerShadow:cell.imgTable shadowColor:[UIColor greenColor] shadowRadius:5.0];
    } else {
        [DAAnimation removeFlickerShadow:cell.imgTable];
    }

    return cell;
}


-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DAMyTable * t = [dataList objectAtIndex:indexPath.row];
    
    if (isStartChangeTable) {
        if ([@"empty" isEqualToString:t.state]) {
            DAMyTable *fromT = [self getDataByTableId:changeTableId];
            [fromT swap:t];

            isStartChangeTable = false;
            [self setTableFlicker:false];
        }
        
        return;
    } else if (isProcessionIntoTable) {
        if ([@"empty" isEqualToString:t.state])
        {
            t.state = @"eating";

            isProcessionIntoTable = false;
            [self setTableFlicker:false];
        }
        return;
    } else {
        if ([@"empty" isEqualToString:t.state]) {
            [DAMyLoginViewController show: t parentView:self ];
        } else {
            [DAMyTableConfirmController show: t parentView:self ];
        }
    }
    
}
- (void)changeTable:(NSString *)tableId
{
    changeTableId = tableId;
    isStartChangeTable = true;
    [self setTableFlicker:YES];
}
- (void) setTableFlicker:(BOOL)enabled
{
    isTableFlicker = enabled;
    [self.collectionView reloadItemsAtIndexPaths:self.collectionView.indexPathsForVisibleItems];
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

- (void)processionIntoTable:(NSString *)processionId
{
    isProcessionIntoTable = true;
    [self setTableFlicker:true];
}
- (void)processionOrderFool:(NSString *)processionId
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    UIStoryboard *menubookStoryboard = [UIStoryboard storyboardWithName:@"DARootView" bundle:nil];
    UIViewController *menubookVC = [menubookStoryboard instantiateViewControllerWithIdentifier:@"menubookVC"];
    [self.navigationController pushViewController:menubookVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)onReturnTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)showProcessionList:(id)sender {
    [DAProcessionViewController show:self];
}
- (IBAction)showBillTouched:(id)sender {
    DABillViewController *viewController = [[DABillViewController alloc] initWithNibName:@"DABillViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)showMenuList:(id)sender {
    UIStoryboard *menubookStoryboard = [UIStoryboard storyboardWithName:@"DARootView" bundle:nil];
    UIViewController *menubookVC = [menubookStoryboard instantiateViewControllerWithIdentifier:@"menubookVC"];
    [self.navigationController pushViewController:menubookVC animated:YES];
}

- (IBAction)showOrderQueueTouched:(id)sender {
    DAQueueMasterViewController *viewController = [[DAQueueMasterViewController alloc] initWithNibName:@"DAQueueMasterViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];

}
@end
