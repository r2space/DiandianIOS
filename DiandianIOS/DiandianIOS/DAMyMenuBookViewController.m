//
//  DAMyMenuBookViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-6.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAMyMenuBookViewController.h"
#import "DAMenuModule.h"
#import "DAMyMenuBookCell.h"
#import "UIViewController+MJPopupViewController.h"
#import "DAMyMenuBookPopupController.h"
#import "DAAnimation.h"
#import "SmartSDK.h"
#import "ProgressHUD.h"
#import "DAMenuProxy.h"
#import "MBProgressHUD.h"

#define MENU_FRAME_WIDTH    882
#define MENU_FRAME_HEIGHT   701

@interface DAMyMenuBookViewController () <DAMyMenuBookPopupDelegate>
{
    
    //api
    int pageItemCount;
    
    NSMutableArray *dataList;
    DAMenuList *menuList;
    DASoldoutList *soldoutList;
    int menuIndex;
    BOOL listType;
    UICollectionViewFlowLayout *defaultLayout;
    NSTimer *timer;
    BOOL timerFlag;
    NSMutableArray *adImageList;
    UIImageView *adImageView;
    int adIndex;
    
    int pageRurned;
    int pagePre;
    MBProgressHUD       *progress;  // 消息框
}
@end

@implementation DAMyMenuBookViewController

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
    timerFlag = YES;
    dataList = [[NSMutableArray alloc ] init];
    menuIndex = 0;
    listType = YES;
    pageRurned = 0 ;
    pagePre = 0;
    UINib *cellNib = [UINib nibWithNibName:@"DAMyMenuBookCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"DAMyMenuBookCell"];

    
    RFQuiltLayout* layout = (id)[self.collectionView collectionViewLayout];
    layout.direction = UICollectionViewScrollDirectionHorizontal;
    layout.blockPixels = CGSizeMake(294 ,233);
    layout.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(filterReload:) name:@"filterReload" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popupDetailMenu:) name:@"popupDetailMenu" object:nil];
    
    defaultLayout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
    [self initMenus];
    

    
}

- (void) initMenus
{
    //option
    
    pageItemCount = 6;
    
    
}

- (void) viewDidAppear:(BOOL)animated {
    [self.collectionView reloadData];
    
    DAMenu *menu = [menuList.items objectAtIndex:menuIndex];
    self.pageControl.numberOfPages = [menu.page integerValue];
                                      
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [self loadFromDisk];
    [super viewWillAppear:animated];
    
}

-(void)loadFromDisk{
    
    menuList = [[DAMenuList alloc]unarchiveObjectWithFileWithName:FILE_MENU_LIST];
    
    DAMenu *menu = [menuList.items objectAtIndex:menuIndex];
    for (DAItem *aItem in menu.items){
        [dataList addObject:aItem ];
    }
    if (self.curService != nil) {
        [[DAItemModule alloc] getSoldoutItemList:^(NSError *err, DASoldoutList *list) {
            soldoutList = list;
            [self.collectionView reloadData];
        }];
    }
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    DDLogWarn(@"didReceiveMemoryWarning  :  %@" ,[self class]);
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return [dataList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
    DAItemLayout *data = [[DAItemLayout alloc] initWithDictionary:[dataList objectAtIndex:indexPath.row]];
    
    
    DAMyMenuBookCell *cell;
    NSString *cellIdentifier ;
    NSNumber *nsRow = [[NSNumber alloc] initWithInt:1];
    NSNumber *nsColumn = [[NSNumber alloc] initWithInt:1];
    cellIdentifier = @"DAMyMenuBookCell";
    
    cell = [[DAMyMenuBookCell alloc] initWithObj:data.item collectionView:collectionView cellIdentifier:cellIdentifier indexPath:indexPath row:nsRow column:nsColumn];
    cell.itemData = data.item;
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:11];
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:102];
    UIButton *addBtn = (UIButton *)[cell viewWithTag:13];
    UIButton *addSmallBtn = (UIButton *)[cell viewWithTag:14];
    UILabel *labelAmount = (UILabel *)[cell viewWithTag:19];
    

    UIImage *image = [DAMenuProxy getImageFromDisk:data.item.smallimage];
    if (image) {
        [imageView setImage:image];
    } else {
        NSString *urlString = [DAMenuProxy resourceURLString:data.item.smallimage];
        NSURL *url = [NSURL URLWithString:urlString];
        NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:url];
        [req setValue:@"Application/octet-stream" forHTTPHeaderField:@"Accept"];
        [req setHTTPMethod:@"GET"];
        
        [NSURLConnection sendAsynchronousRequest:req
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data1, NSError *error) {
                                   if( data1 != nil ){
                                       NSString *saveImageName = data.item.smallimage;
                                       NSString *path = [DAMenuProxy imagePath:saveImageName];
                                       [data1 writeToFile:path atomically:YES];
                                       UIImage *image = [DAMenuProxy getImageFromDisk:data.item.smallimage];
                                       [imageView setImage:image];
                                   
                                   }else{
                                       NSLog(@" download fail!!! save image - %@", data.item.smallimage);
                                   }
                                   
                                   
                               }];
    }

                                            


    imageView.layer.cornerRadius = 10;
    imageView.layer.masksToBounds = YES;
    
    
    cell.layer.cornerRadius = 10;
    cell.layer.masksToBounds = YES;
    

    
    if ([data.item.type integerValue] == 10) {
        [titleLabel setHidden:YES];
        
        NSMutableArray *imageList = [[NSMutableArray alloc] init];
        [imageList addObject:data.item.smallimage];
//        [imageList addObject:data.item.bigimage];

        adImageList = imageList;
        adImageView = imageView;
        timerFlag = NO;
        [addBtn setHidden:YES];
        [addSmallBtn setHidden:YES];
        [labelAmount setHidden:YES];
    } else {
        [titleLabel setHidden:NO];
        [addBtn setHidden:NO];
        [addSmallBtn setHidden:NO];
        [labelAmount setHidden:NO];
        timerFlag = YES;
        
    }

    titleLabel.text = [NSString stringWithFormat:@"%@    %@元",data.item.itemName, data.item.itemPriceNormal];
    labelAmount.text = [NSString stringWithFormat:@""];
    [labelAmount setHidden:YES];
    [addSmallBtn setHidden:YES];

    [addBtn addTarget:self
            action:@selector(addMenu:) forControlEvents:UIControlEventTouchUpInside];

    float  x = 121;
    float  y = 158;
    float  mx = 402;
    float  my = 391;
    float  bx = 699;
    float  by = 624;
    dispatch_async(dispatch_get_main_queue(), ^{
       

    
    if ([data.row intValue] == 1 && [data.column intValue] == 1 ) {
        [addBtn setFrame:CGRectMake(x,y,166 ,55)];
        UIView *addBtnBackgroud = (UIView *)[cell viewWithTag:401];
        UIView *maskBackgroud = (UIView *)[cell viewWithTag:101];
        UIView *titleBackgroud = (UIView *)[cell viewWithTag:99];
        [titleBackgroud setFrame:CGRectMake(titleBackgroud.frame.origin.x ,0 , titleBackgroud.frame.size.width , 55)];
        [maskBackgroud setFrame:CGRectMake(maskBackgroud.frame.origin.x ,y , maskBackgroud.frame.size.width , 55)];
        [addBtnBackgroud setFrame:CGRectMake(x,y,166 ,55)];
        [labelAmount setFrame:CGRectMake(100, y, labelAmount.frame.size.width, labelAmount.frame.size.height)];
        [titleLabel setFrame:CGRectMake(10, 10, titleLabel.frame.size.width, titleLabel.frame.size.height)];

    } else if([data.row intValue] == 2 && [data.column intValue] == 2 )  {
        [addBtn setFrame:CGRectMake(mx,my,166 ,55)];
        UIView *addBtnBackgroud = (UIView *)[cell viewWithTag:401];
        UIView *maskBackgroud = (UIView *)[cell viewWithTag:101];
        UIView *titleBackgroud = (UIView *)[cell viewWithTag:99];
        [titleBackgroud setFrame:CGRectMake(titleBackgroud.frame.origin.x ,0 , titleBackgroud.frame.size.width , 55)];
        [maskBackgroud setFrame:CGRectMake(0 ,my , maskBackgroud.frame.size.width , 55)];
        [addBtnBackgroud setFrame:CGRectMake(mx,my,166 ,55)];
        [labelAmount setFrame:CGRectMake(100, my + 10 , labelAmount.frame.size.width, labelAmount.frame.size.height)];
        [titleLabel setFrame:CGRectMake(10, 0 + 10 , titleLabel.frame.size.width, titleLabel.frame.size.height)];

    } else if ([data.row intValue] == 3 && [data.column intValue] == 3 )  {
        [addBtn setFrame:CGRectMake(bx,by,166 ,55)];
        UIView *addBtnBackgroud = (UIView *)[cell viewWithTag:401];
        UIView *maskBackgroud = (UIView *)[cell viewWithTag:101];
        UIView *titleBackgroud = (UIView *)[cell viewWithTag:99];
        [titleBackgroud setFrame:CGRectMake(titleBackgroud.frame.origin.x ,0 , titleBackgroud.frame.size.width , 55)];
        [maskBackgroud setFrame:CGRectMake(0 ,by , maskBackgroud.frame.size.width , 55)];
        [addBtnBackgroud setFrame:CGRectMake(bx,by,166 ,55)];
        [labelAmount setFrame:CGRectMake(100, by + 10 , labelAmount.frame.size.width, labelAmount.frame.size.height)];
        [titleLabel setFrame:CGRectMake(10, 0 + 10 , titleLabel.frame.size.width, titleLabel.frame.size.height)];

    }
    
    });
    BOOL soldoutFlag = NO;
    for (DASoldout *soldout in soldoutList.items) {
        if ([data.item._id isEqualToString:soldout.itemId]) {
            soldoutFlag = YES;
            break;
        }
        soldoutFlag = NO;
    }
    UIImageView *soldoutView = (UIImageView *)[cell viewWithTag:666];
    if (soldoutFlag) {
        
        [soldoutView setHidden:NO];
        
        [addBtn setEnabled:NO];
        
    } else {
        [soldoutView setHidden:YES];
        [addBtn setEnabled:YES];
    }

    
    
    
    return cell;
}

// 定时获取消息。发生滚动时，停止定时器
- (void)timerEvent:(NSTimer *)timer
{
    if (!timerFlag) {
        timerFlag = YES;
            [adImageView setImage:[DAMenuProxy getImageFromDisk:[adImageList objectAtIndex:adIndex]]];
            
            
            adIndex = adIndex + 1;
            if (adIndex == [adImageList count]) {
                adIndex = 0;
            }
            timerFlag = NO;
        
    }
    
    
}


-(void)addSmallMenu:(UIButton*)button
{
    [DAAnimation addSmallOrderAnimation:button withSupview:self];
}
    
-(void)addMenu:(UIButton*)button{
    
    [DAAnimation addOrderAnimation:button withSupview:self];
}

#pragma mark – RFQuiltLayoutDelegate

- (CGSize) blockSizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DAItemLayout *data = [[DAItemLayout alloc] initWithDictionary:[dataList objectAtIndex:indexPath.row]];
    return  CGSizeMake([data.row intValue], [data.column intValue]);
}

- (UIEdgeInsets)insetsForItemAtIndexPath:(NSIndexPath *)indexPath {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{

    int page = (int)targetContentOffset->x / MENU_FRAME_WIDTH ;
    if (targetContentOffset->x / MENU_FRAME_WIDTH > (int)targetContentOffset->x / MENU_FRAME_WIDTH) {
        page = page + 1;
    }
    self.pageControl.currentPage = page;


}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    DAItemLayout *data = [[DAItemLayout alloc] initWithDictionary:[dataList objectAtIndex:indexPath.row]];

    for (DASoldout *soldout in soldoutList.items) {
        if ([data.item._id isEqualToString:soldout.itemId]) {

            return;
        }

    }
    if ([data.item.type integerValue] != 10) {
        [self popupDetail:data.item from:@"menubook"];
    }
    
    
}


-(void) popupDetailMenu :(NSNotification *) sender
{
    DAItem * menu  = (DAItem *)[sender object];
    [self popupDetail:menu from:@"notification"];
}

-(void) popupDetail :(DAItem *) item from:(NSString *) from
{

    DAMyMenuBookPopupController *menuBookPopupVC = [[DAMyMenuBookPopupController alloc] initWithNibName:@"DAMyMenuBookPopupController" bundle:nil];
    menuBookPopupVC.delegate = self;
    menuBookPopupVC.curItem = item;
    menuBookPopupVC.from = from;

    [self presentPopupViewController:menuBookPopupVC animationType:MJPopupViewAnimationFade];
    
}

- (void)filterReload : (NSNotification*) notification
{
    NSString *noticeMenuIndex = [notification object];
    
    DAMenu *menu = [menuList.items objectAtIndex:[noticeMenuIndex integerValue]];
    menuIndex = [noticeMenuIndex integerValue];
    NSMutableArray *tmpList = [[NSMutableArray alloc] init];
    [self loadFromDisk];
    [tmpList addObjectsFromArray:menu.items];

    dataList = [[NSMutableArray alloc]initWithArray:tmpList];

    [self.collectionView reloadData];
    
    self.pageControl.numberOfPages = [menu.page integerValue];
    self.pageControl.currentPage = 0;
    [self gotoPage:NO];
    
}
- (void)cancelButtonClicked:(DAMyMenuBookPopupController*) popupViewController
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

- (void)gotoPage:(BOOL)animated
{
    NSInteger page = self.pageControl.currentPage;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
	// update the scroll view to the appropriate page
    CGRect bounds = self.collectionView.bounds;
    bounds.origin.x = MENU_FRAME_WIDTH * page;
    bounds.origin.y = 0;
    [self.collectionView scrollRectToVisible:bounds animated:animated];
}

- (IBAction)changePage:(id)sender
{
    [self gotoPage:YES];    // YES = animate
}
-(DASoldoutList *)getSoldout
{
    return soldoutList;
}
@end
