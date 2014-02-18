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
#import "DARootViewController.h"
#import "DAMenuProxy.h"

static DAMyTableViewController *activity;

@interface DAMyTableViewController ()<DAMyLoginDelegate, DAMyTableConfirmDelegate, DAProcessionViewDelegate, DATakeoutDelegate>
{
    
    DADeskList *deskList;
    NSMutableArray *btnList ;
    NSMutableArray *dataList;
    BOOL isTableFlicker;
    BOOL isStartChangeTable;
    BOOL isProcessionIntoTable;
    NSString * changeServiceId;
}
@end

@implementation DAMyTableViewController
{
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    activity = self;
    
    dataList = [[NSMutableArray alloc] init];
    UINib *cellNib = [UINib nibWithNibName:@"DAMyTableViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"DAMyTableViewCell"];
    
    self.navigationController.navigationBarHidden = YES;
    
    isTableFlicker = false;
    isProcessionIntoTable = false;
    
    
    [self initTopmenu];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadFromFile];
    
    NSNotification *orderReloadNotification = [NSNotification notificationWithName:@"ioSocketOpen" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:orderReloadNotification];
}

-(void) viewWillDisappear:(BOOL)animated
{
    NSNotification *orderReloadNotification = [NSNotification notificationWithName:@"ioSocketClose" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:orderReloadNotification];
}
+ (void) receive:(NSString*)action data:(id)data
{
    if (activity != nil && [activity isViewLoaded]) {
        [activity receiveMessage:action data:data];
    }
}

- (void) receiveMessage:(NSString*)action data:(id)data
{
    NSDictionary *dic =  [data objectForKey:@"service"];
    NSLog(@"service  dic %@" ,dic );
//    
//    // 更新桌信息
//    if ([@"refresh_desk" isEqualToString:action]) {
//        DADesk *new = [[DADesk alloc] initWithDictionary:data];
//        for (int i=0; i < dataList.count; i++) {
//            DADesk *desk = [dataList objectAtIndex:i];
//            if ([desk._id isEqualToString:new._id]) {
//                [dataList replaceObjectAtIndex:i withObject:new];
//                [self.collectionView reloadData];
//                break;
//            }
//        }
//    }
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

    
    [[DADeskModule alloc] getDeskListWithArchiveName:nil callback:^(NSError *err, DADeskList *list) {
        dataList = [[NSMutableArray alloc]init];
        for (DADesk *d in list.items){
            [dataList addObject: d];
        }
        [self.collectionView reloadData];
    }];
    
}


- (DADesk*)getDataByTableId:(NSString*)tableId
{
    if (dataList == nil || dataList.count <= 0) {
        return nil;
    }
    
    for (DADesk *d in dataList) {
        if ([d._id isEqualToString:tableId]) {
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

    [ProgressHUD show:nil];
    [DADeskProxy initDesk:loginVC.curDesk._id userId:loginVC.curUserId type:@"1" people:loginVC.numOfPepole.text callback:^(NSError *err, DAService *service) {

        if ([service._status integerValue ] != 200) {
            [ProgressHUD showError:service._error];
            [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
            return ;
        }
        
        UIStoryboard *menubookStoryboard = [UIStoryboard storyboardWithName:@"DARootView" bundle:nil];
        DARootViewController *menubookVC = [menubookStoryboard instantiateViewControllerWithIdentifier:@"menubookVC"];
        menubookVC.curService = service;
        
        NSLog(@"debug : deskId : %@  serviceId  :   %@ " ,service.deskId, service._id);
        [ProgressHUD dismiss];
        [self.navigationController pushViewController:menubookVC animated:YES];
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    }];

    
    
    
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
    cell.curDesk = desk;
    
    
    
//    cell.imgTable.layer.backgroundColor = [UIColor clearColor].CGColor;
    cell.imgTable.layer.cornerRadius = 5.0;
    cell.imgTable.layer.masksToBounds = YES;
    //cell.imgTable.layer.mask = NO;
    
    cell.viewMask.layer.cornerRadius = 5.0;
    cell.viewMask.layer.masksToBounds = YES;

    cell.viewLabel.layer.cornerRadius = 3.0;
    cell.viewLabel.layer.masksToBounds = YES;
    
    // 设置空桌的效果
    
    // 这个好像被外面给覆盖了
    if (![desk isEmpty]) {
        [cell.btnOrderList setHidden:NO];

        cell.imgTable.image = [UIImage imageNamed:@"desk_bottonl.png"];
    } else {
        [cell.btnOrderList setHidden:YES];
        cell.imgTable.image = [UIImage imageNamed:@"desk_bottond.png"];
    }
    cell.backgroundColor = [UIColor clearColor];
    
    
    // 设置换桌的动画效果
    if (isTableFlicker && [desk isEmpty]) {
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
        if ([desk isEmpty]) {
//            DADesk *fromT = [self getDataByTableId:changeTableId];
            // TODO: 改成用 [dataList replaceObjectAtIndex:i withObject:new];
            //[fromT swap:desk];
            NSString *curWaitterId = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.diandian.curWaitterUserId"];
            
            if (curWaitterId == nil || curWaitterId.length ==0) {
                curWaitterId = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.diandian.userId"];
            }
            
            [[DAServiceModule alloc]changeService:changeServiceId deskId:desk._id userId:curWaitterId callback:^(NSError *err, DAService *service) {
                
                isStartChangeTable = NO;
                [self setTableFlicker:NO];
                [self loadFromFile];
            }];

        }
        
        return;
    } else if (isProcessionIntoTable) {
        if ([desk isEmpty])
        {

            isProcessionIntoTable = false;
            [self setTableFlicker:false];
        }
        return;
    } else {
        if (![desk isEmpty]) {
            [DAMyTableConfirmController show: desk parentView:self ];
        } else {
            DAMyLoginViewController *vc = [[DAMyLoginViewController alloc]initWithNibName:@"DAMyLoginViewController" bundle:nil];
            vc.delegate = self;
            vc.curDesk  = desk;
            [self  presentPopupViewController:vc animationType:MJPopupViewAnimationFade];
        }
    }
    
}
- (void)changeTable:(NSString *)serviceId
{
    changeServiceId = serviceId;
    isStartChangeTable = YES;
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

- (IBAction)testUpdateMenuListTouched:(id)sender {
    
}

- (IBAction)onLogoutTouched:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"jp.co.dreamarts.smart.diandian.password"];
    [[DALoginModule alloc] logout:@"diandian" callback:^(NSError *error) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"jp.co.dreamarts.smart.diandian.isLogin"];
        
        [[NSUserDefaults standardUserDefaults]  removeObjectForKey:@"jp.co.dreamarts.smart.diandian.username"];
        
        [[NSUserDefaults standardUserDefaults]  removeObjectForKey:@"jp.co.dreamarts.smart.diandian.password"];
        
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
}

- (IBAction)onRefreshTouched:(id)sender {
    [self loadFromFile];
}

@end
