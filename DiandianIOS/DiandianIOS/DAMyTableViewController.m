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
#import "DARightSideMenuViewController.h"
#import "DrawPatternLockViewController.h"
#import "MBProgressHUD.h"
#import "DAMyBackOrderViewController.h"
#import "DABackOrderViewController.h"
#import "DARecentBillViewController.h"
static DAMyTableViewController *activity;

@interface DAMyTableViewController ()<DAMyLoginDelegate, DAMyTableConfirmDelegate, DAProcessionViewDelegate, DATakeoutDelegate>
{
    
    DADeskList *deskList;
    NSMutableArray *btnList ;
    NSMutableArray *dataList;
    BOOL isTableFlicker;
    BOOL isStartChangeTable;
    BOOL isShown;
    DARightSideMenuViewController *rsvc;
    DrawPatternLockViewController *lockVC;
    int passErrorCount;
    MBProgressHUD *progress;
    DADesk *selectedDesk;
    NSIndexPath *selectedIndexPath;
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

//    isTableFlicker = NO;
    
    
    [self initTopmenu];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    isShown = YES;
    selectedDesk = nil;
    selectedIndexPath = nil;
    [self loadFromFile];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    isShown = NO;
}

+ (void) receive:(NSString*)action data:(id)data
{
    if (activity != nil && [activity isViewLoaded]) {
        [activity receiveMessage:action data:data];
    }
}

- (void) receiveMessage:(NSString*)action data:(id)data
{
    if(!isShown){return;}
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
- (void)showIndicator:(NSString *)message
{
    if(progress == nil){
        progress = [MBProgressHUD showHUDAddedTo:self.view.window.rootViewController.view animated:YES];
        progress.mode = MBProgressHUDModeIndeterminate;
        //progress.color = [UIColor colorWithRed:102.0f/255.0f green:0.0f/255.0f blue:204.0f/255.0f alpha:1.0f];

    }
    progress.labelText = message;
    [progress show:YES];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[event.allTouches anyObject];
    if (![touch.view isEqual:self.collectionView]) {
        isStartChangeTable = NO;
        isTableFlicker = NO;
        [self.collectionView reloadItemsAtIndexPaths:self.collectionView.indexPathsForVisibleItems];
    }
}

-(void)loadFromFile{

    
    [[DADeskModule alloc] getDeskListWithArchiveName:nil callback:^(NSError *err, DADeskList *list) {
        dataList = [[NSMutableArray alloc]init];
        for (DADesk *d in list.items){
            [dataList addObject: d];
        }
        [self.collectionView reloadData];
        [progress hide:YES];
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
    DDLogWarn(@"开台中,桌台信息:%@", [[loginVC.curDesk description] stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"]);

    [ProgressHUD show:nil];
    [DADeskProxy initDesk:loginVC.curDesk._id userId:loginVC.curUserId type:@"1" people:loginVC.numOfPepole.text callback:^(NSError *err, DAService *service) {

        if ([service._status integerValue ] != 200) {
            [ProgressHUD showError:service._error];
            [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
            DDLogWarn(@"开台失败,错误信息:%@",service._error);
            return ;
        }
        
        UIStoryboard *menubookStoryboard = [UIStoryboard storyboardWithName:@"DARootView" bundle:nil];
        DARootViewController *menubookVC = [menubookStoryboard instantiateViewControllerWithIdentifier:@"menubookVC"];
        menubookVC.curService = service;
        
        NSLog(@"debug : deskId : %@  serviceId  :   %@ " ,service.deskId, service._id);
        DDLogWarn(@"开台成功,service :%@ " , [[service description] stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"]);

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
        cell.imgTable.image = [UIImage imageNamed:@"desk_bottonl.png"];
    } else {
        cell.imgTable.image = [UIImage imageNamed:@"desk_bottond.png"];
    }

    if (selectedDesk != nil && [selectedDesk._id isEqualToString:desk._id]) {
        [rsvc changeMode:selectedDesk.isEmpty];
        cell.backgroundColor = [UIColor orangeColor];
//        [cell setSelected:YES];
    }
    else {
        cell.backgroundColor = [UIColor clearColor];
    }


    cell.layer.cornerRadius = 10;
    
    // 设置换桌的动画效果
    if (isTableFlicker && [desk isEmpty]) {
        [DAAnimation addFlickerShadow:cell.imgTable shadowColor:[UIColor greenColor] shadowRadius:5.0];
    } else {
        [DAAnimation removeFlickerShadow:cell.imgTable];
    }

    return cell;
}

-(void) collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DAMyTableViewCell *cell = (DAMyTableViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DAMyTableViewCell *cell = (DAMyTableViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    DADesk * desk = [dataList objectAtIndex:indexPath.row];
    if(isStartChangeTable){
        if ([desk isEmpty]) {
            [self showIndicator:@"换台中..."];
            DDLogWarn(@"开始换台,将service id %@ 的桌台换为 %@",selectedDesk.service._id,desk._id);
            [[DAServiceModule alloc]changeService:selectedDesk.service._id deskId:desk._id userId:[self getWaitterId] callback:^(NSError *err, DAService *service) {
                DDLogWarn(@"换台结束");
                isStartChangeTable = NO;
                isTableFlicker = NO;

                selectedDesk = nil;
                selectedIndexPath = nil;

                //[self.collectionView reloadItemsAtIndexPaths:self.collectionView.indexPathsForVisibleItems];

                [self loadFromFile];
            }];
        }

    }else{
        cell.backgroundColor = [UIColor orangeColor];
        if(selectedIndexPath != nil && ![selectedIndexPath isEqual:indexPath]){
            ((DAMyTableViewCell *)[collectionView cellForItemAtIndexPath:selectedIndexPath]).backgroundColor = [UIColor clearColor];
        }
        selectedDesk = desk;
        selectedIndexPath = indexPath;
        [self showSideMenu];

    }

    return;

//    if (isStartChangeTable) {
//        if ([desk isEmpty]) {
////            DADesk *fromT = [self getDataByTableId:changeTableId];
//            // TODO: 改成用 [dataList replaceObjectAtIndex:i withObject:new];
//            //[fromT swap:desk];
//            NSString *curWaitterId = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.diandian.curWaitterUserId"];
//
//            if (curWaitterId == nil || curWaitterId.length ==0) {
//                curWaitterId = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.diandian.userId"];
//            }
//
//            DDLogWarn(@"开始换台,将service id %@ 的桌台换为 %@",changeServiceId,desk._id);
//
//            [[DAServiceModule alloc]changeService:changeServiceId deskId:desk._id userId:curWaitterId callback:^(NSError *err, DAService *service) {
//
//                isStartChangeTable = NO;
//                [self setTableFlicker:NO];
//                [self loadFromFile];
//            }];
//
//        }
//
//        return;
////    } else if (isProcessionIntoTable) {
////        if ([desk isEmpty])
////        {
////
////            isProcessionIntoTable = false;
////            [self setTableFlicker:false];
////        }
////        return;
//    } else {
//        if (![desk isEmpty]) {
//            [DAMyTableConfirmController show: desk parentView:self ];
//        } else {
//            DAMyLoginViewController *vc = [[DAMyLoginViewController alloc]initWithNibName:@"DAMyLoginViewController" bundle:nil];
//            vc.delegate = self;
//            vc.curDesk  = desk;
//            [self  presentPopupViewController:vc animationType:MJPopupViewAnimationFade];
//        }
//    }
    
}

- (void)showSideMenu {
    if (rsvc == nil) {
        rsvc = [[DARightSideMenuViewController alloc] initWithNibName:nil bundle:nil];
        [rsvc setTarget:self
         withHideAction:@selector(hideProc)
             openAction:@selector(openDeskProc)
              addAction:@selector(addDishProc)
             backAction:@selector(backDishProc)
            checkAction:@selector(checkOutProc)
           changeAction:@selector(changeDeskProc)];
    }
    //[self.navigationController pushViewController:rsvc animated:YES];


    if (selectedDesk != nil) {
        [rsvc.view removeFromSuperview];
        rsvc.view.frame = CGRectMake(1024, 134, 170, 500);
        [self.view addSubview:rsvc.view];
        [rsvc changeMode:selectedDesk.isEmpty];
        rsvc.deskLabel.text = selectedDesk.name;
        [UIView animateWithDuration:0.3
                         animations:^(void) {
                             rsvc.view.frame = CGRectMake(1024 - 160, 134, 170, 500);
                         }];
    }
}

//- (void)changeTable:(NSString *)serviceId
//{
//    changeServiceId = serviceId;
//    isStartChangeTable = YES;
//    [self setTableFlicker:YES];
//}


//- (void) setTableFlicker:(BOOL)enabled
//{
//    isTableFlicker = enabled;
//    [self.collectionView reloadItemsAtIndexPaths:self.collectionView.indexPathsForVisibleItems];
//    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
//}

//- (void)processionIntoTable:(NSString *)processionId
//{
//    isProcessionIntoTable = true;
//    [self setTableFlicker:true];
//}
//
//- (void)processionOrderFool:(NSString *)processionId
//{
//    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
//    UIStoryboard *menubookStoryboard = [UIStoryboard storyboardWithName:@"DARootView" bundle:nil];
//    UIViewController *menubookVC = [menubookStoryboard instantiateViewControllerWithIdentifier:@"menubookVC"];
//    [self.navigationController pushViewController:menubookVC animated:YES];
//}

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
    DDLogWarn(@"didReceiveMemoryWarning  :  %@" ,[self class]);
}
- (IBAction)onReturnTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)showProcessionList:(id)sender {
    [DAProcessionViewController show:self];
}

- (IBAction)showTakeoutList:(id)sender {
    //[DATakeoutViewController show:self];
    DARecentBillViewController *vc = [[DARecentBillViewController alloc] initWithNibName:@"DARecentBillViewController" bundle:nil];
    vc.modalPresentationStyle = UIModalTransitionStyleCrossDissolve;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
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
    [self hideProc];
    [self.navigationController pushViewController:viewController animated:YES];


}

- (IBAction)testUpdateMenuListTouched:(id)sender {
    
}

- (IBAction)onLogoutTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
//    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"jp.co.dreamarts.smart.diandian.password"];
//    [[DALoginModule alloc] logout:@"diandian" callback:^(NSError *error) {
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"jp.co.dreamarts.smart.diandian.isLogin"];
//
//        [[NSUserDefaults standardUserDefaults]  removeObjectForKey:@"jp.co.dreamarts.smart.diandian.username"];
//
//        [[NSUserDefaults standardUserDefaults]  removeObjectForKey:@"jp.co.dreamarts.smart.diandian.password"];
//
//
//        [self.navigationController popViewControllerAnimated:YES];
//
//    }];
    
}

- (IBAction)onRefreshTouched:(id)sender {
    [self loadFromFile];
}


//=======new========
//开台
-(void)openDeskProc{

    if(lockVC == nil){

        lockVC = [[DrawPatternLockViewController alloc] init];
        lockVC.modalPresentationStyle = UIModalPresentationFormSheet;
        [lockVC setTarget:self withAction:@selector(lockEntered:)];

        UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 540, 44)];
        UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:nil];
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                       style:UIBarButtonItemStyleBordered
                                                                      target:self
                                                                      action:@selector(closePassProc)];
        //设置导航栏内容
        [navigationItem setTitle:@"请验证手势密码"];
        [navigationBar pushNavigationItem:navigationItem animated:NO];

        //把左右两个按钮添加入导航栏集合中
        [navigationItem setLeftBarButtonItem:leftButton];
        [lockVC.view addSubview:navigationBar];
    }


    [self.navigationController presentViewController:lockVC animated:NO completion:nil];

}
- (void)lockEntered:(NSString*)key {

    NSString *curWaitterId= [self getWaitterId];

    [[DALoginModule alloc]checkPattern:key userId:curWaitterId callback:^(NSError *error, NSDictionary *user) {

        NSNumber *isRight = [user objectForKey:@"isRight"];

        if (![isRight boolValue]) {
            passErrorCount++ ;
            [ProgressHUD showError:@"手势密码验证错误。"];
            if (passErrorCount == 3) {
                passErrorCount = 0;

                [self closePassProc];
            }
        } else {
            passErrorCount = 0;
            [self showIndicator:@"开台中..."];
            [DADeskProxy initDesk:selectedDesk._id userId:curWaitterId type:@"1" people:@"4" callback:^(NSError *err, DAService *service) {
                if ([service._status integerValue ] != 200) {
                    [progress hide:YES];
                    [ProgressHUD showError:service._error];
                    DDLogWarn(@"开台失败,错误信息:%@",service._error);
                    return ;
                }
                UIStoryboard *menubookStoryboard = [UIStoryboard storyboardWithName:@"DARootView" bundle:nil];
                DARootViewController *menubookVC = [menubookStoryboard instantiateViewControllerWithIdentifier:@"menubookVC"];
                menubookVC.curService = service;

                NSLog(@"debug : deskId : %@  serviceId  :   %@ " ,service.deskId, service._id);
                DDLogWarn(@"开台成功,service :%@ " , [[service description] stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"]);

                [progress hide:YES];
                [self closePassProc];
                [self hideProc];
                [self.navigationController pushViewController:menubookVC animated:YES];
            }];
        }
    }];



}

- (NSString *)getWaitterId {
    NSString *curWaitterId = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.diandian.curWaitterUserId"];

    if (curWaitterId == nil || curWaitterId.length ==0) {
        curWaitterId = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.diandian.userId"];
    }
    return curWaitterId;
}

//加菜
-(void)addDishProc{

    DDLogWarn(@"加菜按钮点击,service信息:%@", [[selectedDesk.service description] stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"]);

    UIStoryboard *menubookStoryboard = [UIStoryboard storyboardWithName:@"DARootView" bundle:nil];
    DARootViewController *menubookVC = [menubookStoryboard instantiateViewControllerWithIdentifier:@"menubookVC"];
    menubookVC.curService = selectedDesk.service;
    menubookVC.willAddItem = @"YES";
    [self closePassProc];
    [self hideProc];
    [self.navigationController pushViewController:menubookVC animated:YES];
}

//退菜
-(void)backDishProc{
    DDLogWarn(@"退菜按钮点击,service信息:%@", [[selectedDesk.service description] stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"]);

    DABackOrderViewController *backVc = [[DABackOrderViewController alloc] initWithNibName:@"DABackOrderViewController" bundle:nil servieId:selectedDesk.service._id deskId:selectedDesk._id];
    backVc.modalPresentationStyle = UIModalPresentationFormSheet;
    [self.navigationController presentViewController:backVc animated:YES completion:nil];

}

//结账
-(void)checkOutProc{
    DDLogWarn(@"结账按钮点击,service信息:%@", [[selectedDesk.service description] stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"]);


    DABillViewController *viewController = [[DABillViewController alloc]
            initWithNibName:@"DABillViewController" bundle:nil];
    viewController.curService = selectedDesk.service;
    [self hideProc];
    [self.navigationController pushViewController:viewController animated:YES];
}

//换桌
-(void)changeDeskProc{
    isStartChangeTable = YES;
    isTableFlicker = YES;
    [self.collectionView reloadItemsAtIndexPaths:self.collectionView.indexPathsForVisibleItems];
    [self hideProc];
}

//换桌
-(void)hideProc{
    [UIView animateWithDuration:0.3
                     animations:^(void) {
                         rsvc.view.frame = CGRectMake(1024, 134, 170, 500);
                     }];
}

//关闭手势
-(void)closePassProc{
    [lockVC dismissViewControllerAnimated:NO completion:nil];
}
//==================
@end
