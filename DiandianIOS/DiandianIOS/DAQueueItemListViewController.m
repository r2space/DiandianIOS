//
//  DAQueueItemListViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-15.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAQueueItemListViewController.h"

#import "DAMenuProxy.h"

#import "ProgressHUD.h"

#import "DAOrderProxy.h"

#import "Tool.h"
#import "MBProgressHUD.h"


@interface DAQueueItemListViewController ()
{

    DAMyOrderList *dataList;
    NSIndexPath *oldIndexPath;
    UICollectionViewCell * oldcell;
    DAMenuList *menuList;
    NSMutableArray *itemList;
    NSDate *nowData;
    MBProgressHUD *progress;
}
@end

@implementation DAQueueItemListViewController

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
    dataList =  [[DAMyOrderList alloc ]init];
    dataList.items = [[NSArray alloc]init];
    itemList = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view from its nib.
    UINib *cellNib = [UINib nibWithNibName:@"DAQueueItemListCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"DAQueueItemListCell"];
    

    menuList = [[DAMenuList alloc]unarchiveObjectWithFileWithName:FILE_MENU_LIST];
    for (DAMenu *menu in menuList.items) {
        for (DAItem *item in menu.items) {
            [itemList addObject:item];
        }
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ioRefreshOrderList:) name:@"ioRefreshOrderList" object:nil];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self loadFromFile];
}

- (void)ioRefreshOrderList : (NSNotification*) notification
{
////    [ProgressHUD show:@"推送消息"];
//    NSDictionary *obj = [notification object];
//    NSArray *items = [obj objectForKey:@"items"];
//    NSMutableArray *tmpArray = [[NSMutableArray alloc]init];
//    for (NSDictionary *orderdic in items) {
//        DAOrder *order = [[DAOrder alloc ]initWithDictionary:orderdic];
//        [tmpArray addObject:order];
//    }
//    
//    [tmpArray addObjectsFromArray:dataList.items];
//    
//    dataList = [[DAMyOrderList alloc]init];
//    dataList.items = [[NSArray alloc]initWithArray:tmpArray];
//    [self.collectionView reloadData];
////    [ProgressHUD dismiss];
    [self loadFromFile];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return [dataList.items count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
    static NSString *cellIdentifier = @"DAQueueItemListCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    DAOrder *row = [dataList.items objectAtIndex:indexPath.row];

    UIImageView *imgItem = (UIImageView *)[cell viewWithTag:10];
    imgItem.image = [DAMenuProxy getImageFromDisk:row.item.smallimage];
    UILabel *lblName = (UILabel *)[cell viewWithTag:11];
    if ([row.type integerValue] == 0) {
        lblName.text = row.item.itemName;
    } else {
        lblName.text = [NSString stringWithFormat:@"%@(小份)",row.item.itemName];
    }
    
    UILabel *lblWaitingTime = (UILabel *)[cell viewWithTag:12];
    
    UILabel *lblCountDesk = (UILabel *)[cell viewWithTag:13];
    if ([row.oneItems count] == 1) {
        if (row.desk.name) {
            lblCountDesk.text = [NSString stringWithFormat:@"%@" ,row.desk.name];
        } else {
            lblCountDesk.text = @"外卖";
        }
        

    } else {
        lblCountDesk.text = [NSString stringWithFormat:@"%d桌" ,[row.oneItems count]];
    }

    
    lblWaitingTime.text = [Tool compareCurrentTime:row.createat];
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)showIndicator:(NSString *)message
{
    progress = [MBProgressHUD showHUDAddedTo:self.view.window.rootViewController.view animated:YES];
    progress.mode = MBProgressHUDModeIndeterminate;
    progress.labelText = message;
    progress.color = [UIColor colorWithRed:102.0f/255.0f green:0.0f/255.0f blue:204.0f/255.0f alpha:1.0f];
    [progress show:YES];
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DAOrder *row = [dataList.items objectAtIndex:indexPath.row];
    NSString *deskId = row.deskId;
    NSArray *oneItems =  row.oneItems;
    self.selectItemBlock(oneItems,deskId);
    
    NSArray *cells = [self.collectionView visibleCells];
    for (UICollectionViewCell * cObj in cells) {
        cObj.backgroundColor = [UIColor clearColor];
    }

    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor darkGrayColor];
}

#pragma mark --UICollectionViewDelegate

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
    
}

-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSArray *cells =  [collectionView visibleCells];
//    for (UICollectionViewCell *cobj in cells ) {
//        cobj.backgroundColor = [UIColor clearColor];
//        
//    }
}


- (void)loadFromFile {

    
    [[DAOrderModule alloc]getOrderItemList:^(NSError *err, DAMyOrderList *list) {
        dataList = [DAOrderProxy getOneDataList:list];
        [self.collectionView reloadData];
        
    }];
    
    
}

- (void)filterItem:(NSString *)itemId tableNO:(NSString *)tableNo
{
    [self loadFromFile];
}







@end
