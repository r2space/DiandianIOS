//
//  DAQueueItemListViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-15.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAQueueItemListViewController.h"
#import "ProgressHUD.h"

@interface DAQueueItemListViewController ()
{

    DAMyOrderList *dataList;
    NSIndexPath *oldIndexPath;
    UICollectionViewCell * oldcell;
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
    // Do any additional setup after loading the view from its nib.
    UINib *cellNib = [UINib nibWithNibName:@"DAQueueItemListCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"DAQueueItemListCell"];
    [self loadFromFile];

    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ioRefreshOrderList:) name:@"ioRefreshOrderList" object:nil];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)ioRefreshOrderList : (NSNotification*) notification
{
    [ProgressHUD show:@"推送消息"];
    NSArray *obj = [notification object];
    NSMutableArray *tmpArray = [[NSMutableArray alloc]init];
    for (NSDictionary *orderdic in obj) {
        DAOrder *order = [[DAOrder alloc ]initWithDictionary:orderdic];
        [tmpArray addObject:order];
    }
    
    [tmpArray addObjectsFromArray:dataList.items];
    
    dataList = [[DAMyOrderList alloc]init];
    dataList.items = [[NSArray alloc]initWithArray:tmpArray];
    [self.collectionView reloadData];
    [ProgressHUD dismiss];
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
    
    // we're going to use a custom UICollectionViewCell, which will hold an image and its label
    //
    
    
    
    
    static NSString *cellIdentifier = @"DAQueueItemListCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    DAOrder *row = [dataList.items objectAtIndex:indexPath.row];
    
    UIImageView *imgItem = (UIImageView *)[cell viewWithTag:10];
    imgItem.image = [UIImage imageNamed:@"top_bg3.png"];
    UILabel *lblName = (UILabel *)[cell viewWithTag:11];
    lblName.text = @"xxxxxx";
    UILabel *lblWaitingTime = (UILabel *)[cell viewWithTag:12];
    lblWaitingTime.text = @"dddddd";
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}
-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DAOrder *row = [dataList.items objectAtIndex:indexPath.row];
    NSLog(@"%@", row);
    NSString *tableNO = row.deskId;
    NSString *name = row.deskId;
    self.selectItemBlock(name,tableNO);
    
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

    [[DAOrderModule alloc]getAllOrderList:0 count:20 callback:^(NSError *err, DAMyOrderList *list) {
        dataList = list;
        [self.collectionView reloadData];
    }];
    
    
    
}


- (void)filterItem:(NSString *)itemId tableNO:(NSString *)tableNo
{
    
//    
//    [[DAOrderModule alloc]getAllOrderList:0 count:20 callback:^(NSError *err, DAOrderList *list) {
//        dataList = list;
//    }];

    [self.collectionView reloadData];
    
    
    
}







@end
