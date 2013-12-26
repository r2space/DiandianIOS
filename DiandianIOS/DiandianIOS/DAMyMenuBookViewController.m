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
    
    titleLabel.text = data.item.itemName;
    
//    [imageView setImage:[DAMenuProxy getImageFromDisk:data.item.smallimage]];
    [[TMCache sharedCache] objectForKey:data.item.smallimage
                                    block:^(TMCache *cache, NSString *key, id object) {
                                        if (object) {

                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                NSLog(@"cacheed");
                                                [imageView setImage:(UIImage *)object];
                                            });
                                            return;
                                        }
                                        NSLog(@"cache miss, requesting %@", data.item.smallimage);

                                        UIImage *image = [DAMenuProxy getImageFromDisk:data.item.smallimage];

                                        [imageView setImage:image];
                                            
                                    }];

    imageView.layer.cornerRadius = 10;
    imageView.layer.masksToBounds = YES;
    
    
    cell.layer.cornerRadius = 10;
    cell.layer.masksToBounds = YES;
    

    
    if ([data.item.type integerValue] == 10) {
        [titleLabel setHidden:YES];
        
        NSMutableArray *imageList = [[NSMutableArray alloc] init];
        [imageList addObject:data.item.smallimage];
        [imageList addObject:data.item.bigimage];
        // 创建定时器
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
//    
//    if (data.item.itemPriceHalf!=nil && data.item.itemPriceHalf.length > 0 ) {
//        labelAmount.text = [NSString stringWithFormat:@"大%@元/小%@元",data.item.itemPriceNormal, data.item.itemPriceHalf];
//        if ([data.item.type integerValue] != 10) {
//            [addSmallBtn setHidden:NO];
//        }
//        
//    } else {
        labelAmount.text = [NSString stringWithFormat:@"%@元",data.item.itemPriceNormal];
        [addSmallBtn setHidden:YES];
        //添加小份动画
//        [addSmallBtn addTarget:self
//                   action:@selector(addSmallMenu:) forControlEvents:UIControlEventTouchUpInside];
//    }
    

    [addBtn addTarget:self
            action:@selector(addMenu:) forControlEvents:UIControlEventTouchUpInside];

    float  x = 191;
    float  y = 186;
    float  mx = 402;
    float  my = 391;
    float  bx = 699;
    float  by = 624;
    dispatch_async(dispatch_get_main_queue(), ^{
       

    
    if ([data.row intValue] == 1 && [data.column intValue] == 1 ) {
        [addBtn setFrame:CGRectMake(x,y,83 ,27.5)];
        UIView *addBtnBackgroud = (UIView *)[cell viewWithTag:401];
        UIView *maskBackgroud = (UIView *)[cell viewWithTag:101];
        [maskBackgroud setFrame:CGRectMake(maskBackgroud.frame.origin.x ,y , maskBackgroud.frame.size.width , 27.5)];
        [addBtnBackgroud setFrame:CGRectMake(x,y,83 ,27.5)];
        [labelAmount setFrame:CGRectMake(100, y, labelAmount.frame.size.width, labelAmount.frame.size.height)];
        [titleLabel setFrame:CGRectMake(10, y, titleLabel.frame.size.width, titleLabel.frame.size.height)];
    } else if([data.row intValue] == 2 && [data.column intValue] == 2 )  {
        [addBtn setFrame:CGRectMake(mx,my,166 ,55)];
        UIView *addBtnBackgroud = (UIView *)[cell viewWithTag:401];
        UIView *maskBackgroud = (UIView *)[cell viewWithTag:101];
        [maskBackgroud setFrame:CGRectMake(0 ,my , maskBackgroud.frame.size.width , 55)];
        [addBtnBackgroud setFrame:CGRectMake(mx,my,166 ,55)];
        [labelAmount setFrame:CGRectMake(100, my + 10 , labelAmount.frame.size.width, labelAmount.frame.size.height)];
        [titleLabel setFrame:CGRectMake(10, my + 10 , titleLabel.frame.size.width, titleLabel.frame.size.height)];
    } else if ([data.row intValue] == 3 && [data.column intValue] == 3 )  {
        [addBtn setFrame:CGRectMake(bx,by,166 ,55)];
        UIView *addBtnBackgroud = (UIView *)[cell viewWithTag:401];
        UIView *maskBackgroud = (UIView *)[cell viewWithTag:101];
        [maskBackgroud setFrame:CGRectMake(0 ,by , maskBackgroud.frame.size.width , 55)];
        [addBtnBackgroud setFrame:CGRectMake(bx,by,166 ,55)];
        [labelAmount setFrame:CGRectMake(100, by + 10 , labelAmount.frame.size.width, labelAmount.frame.size.height)];
        [titleLabel setFrame:CGRectMake(10, by + 10 , titleLabel.frame.size.width, titleLabel.frame.size.height)];
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
        [self popupDetail:data.item];
    }
    
    
}


-(void) popupDetailMenu :(NSNotification *) sender
{
    DAItem * menu  = (DAItem *)[sender object];
    [self popupDetail:menu];
}

-(void) popupDetail :(DAItem *) item
{

    DAMyMenuBookPopupController *menuBookPopupVC = [[DAMyMenuBookPopupController alloc] initWithNibName:@"DAMyMenuBookPopupController" bundle:nil];
    menuBookPopupVC.delegate = self;
    menuBookPopupVC.curItem = item;
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
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"sdfdfdf");
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"sdfdfdf22 ,%d  self.pageControl.numberOfPages : %d" ,self.pageControl.currentPage,self.pageControl.numberOfPages);
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"sdfdfdf22 ,%d  self.pageControl.numberOfPages : %d" ,self.pageControl.currentPage,self.pageControl.numberOfPages);
    int curPage = self.pageControl.currentPage;
    int numPage = self.pageControl.numberOfPages;
    
    if (curPage == (numPage - 1)) {
        NSLog(@"准备翻页");
        pageRurned ++;
    }
    if (curPage == (numPage - 1) && pageRurned == 2) {
        NSLog(@"后翻页");
        
        if (menuIndex == ([menuList.items count] - 1) ) {
            return;
        }
        
        menuIndex ++;
        
        
        
        NSNotification *orderReloadNotification = [NSNotification notificationWithName:@"filterReload" object:[NSString stringWithFormat:@"%d",menuIndex] ];
        [[NSNotificationCenter defaultCenter] postNotification:orderReloadNotification];
        
        NSNotification *segmentedControlNotification = [NSNotification notificationWithName:@"segmentedControlReload" object:[NSString stringWithFormat:@"%d",menuIndex]];
        [[NSNotificationCenter defaultCenter] postNotification:segmentedControlNotification];
        pageRurned = 0;
        pagePre = 0;
    }
    if (curPage == 0) {
        pagePre ++;
    }
    if (curPage == 0 && pagePre==1) {
        if (menuIndex == 0) {
            return;
        }
        menuIndex --;
        pageRurned = 0;
        pagePre = 0;
        
        NSNotification *orderReloadNotification = [NSNotification notificationWithName:@"filterReload" object:[NSString stringWithFormat:@"%d",menuIndex] ];
        [[NSNotificationCenter defaultCenter] postNotification:orderReloadNotification];
        
        NSNotification *segmentedControlNotification = [NSNotification notificationWithName:@"segmentedControlReload" object:[NSString stringWithFormat:@"%d",menuIndex]];
        [[NSNotificationCenter defaultCenter] postNotification:segmentedControlNotification];

    }
}
@end
