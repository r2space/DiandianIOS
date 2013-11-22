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
#import "DATakeoutViewController.h"
#import "DATakeoutViewController.h"
#import "DAMyTable.h"
#import "NSString+Util.h"
#import "DADeskProxy.h"
#import "ProgressHUD.h"


@interface DAMyTableViewController ()<DAMyLoginDelegate, DAMyTableConfirmDelegate, DAProcessionViewDelegate, DATakeoutDelegate>
{
    
    DADeskList *deskList;
    NSMutableArray *btnList ;
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
    
    
    [self initTopmenu];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self loadFromFile];
}

- (void) initTopmenu
{
    self.topmenuLabel.layer.cornerRadius = 15.0;
    self.topmenuLabel.layer.masksToBounds = YES;
    
    
    self.topmenuView.layer.shadowColor = UIColor.blackColor.CGColor;
    self.topmenuView.layer.shadowRadius = 2;
    self.topmenuView.layer.shadowOpacity = 0.6;
    self.topmenuView.layer.shadowOffset = CGSizeMake(0, 1);
    
    btnList =  [[NSMutableArray alloc] init];
    [btnList addObject:[self.view viewWithTag:100]];
    [btnList addObject:[self.view viewWithTag:101]];
    [btnList addObject:[self.view viewWithTag:200]];
    [btnList addObject:[self.view viewWithTag:201]];
//    [btnList addObject:[self.view viewWithTag:202]];
//    
//    [btnList addObject:[self.view viewWithTag:203]];
    
    for (UIButton *btn in btnList) {
        btn.layer.shadowColor = UIColor.blackColor.CGColor;
        btn.layer.shadowRadius = 2;
        btn.layer.shadowOpacity = 0.6;
        btn.layer.shadowOffset = CGSizeMake(0, 1);
    }
    
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
    [ProgressHUD show:nil];
    
    [[DADeskModule alloc] getDeskListWithArchiveName:FILE_DESK_LIST callback:^(NSError *err, DADeskList *list) {
        dataList = [[NSMutableArray alloc]init];
        for (DADesk *d in list.items){
            [dataList addObject: d];
        }
        [self.collectionView reloadData];
        [ProgressHUD dismiss];
    }];
}


- (DADesk*)getDataByTableId:(NSString*)tableId
{
    if (dataList == nil || dataList.count <= 0) {
        return nil;
    }
    
    for (DADesk *d in dataList) {
        if ([d.tableId isEqualToString:tableId]) {
            return d;
        }
    }
    
    return nil;
}

- (void)cancelButtonClicked:(DAMyLoginViewController*)loginViewViewController{
    
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    
}

- (void)startTableButtonClicked:(DAMyLoginViewController*)loginViewViewController{
    
    DAMyLoginViewController *loginVC = loginViewViewController;

    [DADeskProxy initDesk:loginVC.myDesk._id userId:loginVC.waitterId.text type:@"0" people:loginVC.numOfPepole.text callback:^(NSError *err, DAService *service) {
        NSLog(@"DADeskProxy initDesk    %@"  ,service);
    }];

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
    
    DADesk *desk = [dataList objectAtIndex:indexPath.row];
    [cell setData:desk];
    
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
    
    // 这个好像被外面给覆盖了
    if (desk.service !=nil) {
        
        cell.viewMask.hidden = YES;
        
    } else {
        cell.viewMask.hidden = NO;

    }
    
    
    // 设置换桌的动画效果
    if (isTableFlicker && [@"empty" isEqualToString:desk.state]) {
        [DAAnimation addFlickerShadow:cell.imgTable shadowColor:[UIColor greenColor] shadowRadius:5.0];
    } else {
        [DAAnimation removeFlickerShadow:cell.imgTable];
    }

    return cell;
}


-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DADesk * desk = [dataList objectAtIndex:indexPath.row];
    
    if (isStartChangeTable) {
        if ([@"empty" isEqualToString:desk.state]) {
            DADesk *fromT = [self getDataByTableId:changeTableId];
            [fromT swap:desk];

            isStartChangeTable = false;
            [self setTableFlicker:false];
        }
        
        return;
    } else if (isProcessionIntoTable) {
        if ([@"empty" isEqualToString:desk.state])
        {
            desk.state = @"eating";

            isProcessionIntoTable = false;
            [self setTableFlicker:false];
        }
        return;
    } else {
        if (desk.service != nil) {
            [DAMyTableConfirmController show: desk parentView:self ];
        } else {
            [DAMyLoginViewController show: desk parentView:self ];
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

-(void)takeoutOrder:(DATakeout *)takeout
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    UIStoryboard *menubookStoryboard = [UIStoryboard storyboardWithName:@"DARootView" bundle:nil];
    UIViewController *menubookVC = [menubookStoryboard instantiateViewControllerWithIdentifier:@"menubookVC"];
    [self.navigationController pushViewController:menubookVC animated:YES];
}

- (void)takeoutOrderList:(DATakeout *)takeout
{
    
}
-(void)takeoutPay:(DATakeout *)takeout
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    DABillViewController *viewController = [[DABillViewController alloc] initWithNibName:@"DABillViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
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
- (IBAction)showTakeoutList:(id)sender {
    [DATakeoutViewController show:self];
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
