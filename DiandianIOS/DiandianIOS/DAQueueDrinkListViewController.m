//
//  DAQueueDrinkListViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-15.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAQueueDrinkListViewController.h"
#import "ProgressHUD.h"
#import "DAOrderProxy.h"
#import "Tool.h"
#import "MBProgressHUD.h"


@interface DAQueueDrinkListViewController ()
{
    DAMyOrderList *dataList;
    MBProgressHUD *progress;
}
@end

@implementation DAQueueDrinkListViewController

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
    // Do any additional setup after loading the view from its nib.
    UINib *cellNib = [UINib nibWithNibName:@"DAQueueDrinkListCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"DAQueueDrinkListCell"];
    [self loadFromFile];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    DDLogWarn(@"didReceiveMemoryWarning  :  %@" ,[self class]);
}


- (void)showIndicator:(NSString *)message
{
    if(progress == nil){
        progress = [MBProgressHUD showHUDAddedTo:self.view.window.rootViewController.view animated:YES];
        progress.mode = MBProgressHUDModeIndeterminate;

    }
    progress.labelText = message;
    [progress show:YES];
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return [dataList.items count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
    // we're going to use a custom UICollectionViewCell, which will hold an image and its label
    //
    
    
    
    
    static NSString *cellIdentifier = @"DAQueueDrinkListCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    DAOrder *row = [dataList.items objectAtIndex:indexPath.row];
    

    UILabel *lblName = (UILabel *)[cell viewWithTag:10];
    lblName.text = row.item.itemName;
    UILabel *lblWaitingTime = (UILabel *)[cell viewWithTag:11];
    lblWaitingTime.text = [Tool compareCurrentTime:row.createat];
    
    UILabel *lblAmount = (UILabel *)[cell viewWithTag:12];
    lblAmount.text = [NSString stringWithFormat:@"%@份",row.amount];
    
    return cell;
}
-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DAOrder *order = [dataList.items objectAtIndex:indexPath.row];
    self.disableSocketIO();
    [self showIndicator:@"上菜中..."];
    [[DAOrderModule alloc] setDoneOrderWIthReturnDeskData:order._id callback:^(NSError *err, DAMyOrderList *list) {
        NSMutableArray *tempList = [[NSMutableArray alloc]init];
        for (DAOrder *tmpOrder in dataList.items) {
            if (![tmpOrder._id isEqualToString:order._id]) {
                [tempList addObject:tmpOrder];
            }
        }
        dataList.items = [[NSArray alloc]initWithArray:tempList];
        [self.collectionView reloadData];
          [progress hide:YES];
          self.itemClickCallback(list);
    }];
    

}

- (void)loadFromFile {

    
}


-(void ) getQueueListWithServiceId:(NSString *)serviceId deskId:(NSString *)deskId
{
    [self showIndicator:@"刷新中..."];
    [[DAOrderModule alloc]getOrderNEItemListByServiceId:serviceId callback:^(NSError *err, DAMyOrderList *list) {
//        dataList = [DAOrderProxy getOneDataList:list];
        dataList = list;
        [self.collectionView reloadData];
        [progress hide:YES];
    }];
}
@end
