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


#define MENU_FRAME_WIDTH    876
#define MENU_FRAME_HEIGHT   694

@interface DAMyMenuBookViewController () <DAMyMenuBookPopupDelegate>
{
    
    //api
    int pageItemCount;
    
    NSMutableArray *dataList;
    DAMenuList *menuList;
    int menuIndex;
    BOOL listType;
    UICollectionViewFlowLayout *defaultLayout;
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

    dataList = [[NSMutableArray alloc ] init];
    menuIndex = 0;
    listType = YES;
    UINib *cellNib = [UINib nibWithNibName:@"DAMyMenuBookCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"DAMyMenuBookCell"];

    
    RFQuiltLayout* layout = (id)[self.collectionView collectionViewLayout];
    layout.direction = UICollectionViewScrollDirectionHorizontal;
    layout.blockPixels = CGSizeMake(292 ,230);
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
    self.pageControl.numberOfPages = [menu.items count] / pageItemCount ;
    if ([menu.items count] % pageItemCount !=0) {
        self.pageControl.numberOfPages = self.pageControl.numberOfPages + 1;
    }
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [self loadFromDisk];
}

-(void)loadFromDisk{
    
    menuList = [[DAMenuList alloc]unarchiveObjectWithFileWithName:FILE_MENU_LIST];
    
    DAMenu *menu = [menuList.items objectAtIndex:menuIndex];
    for (DAItem *aItem in menu.items){
        [dataList addObject:aItem ];
    }
    [self.collectionView reloadData];

    
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
    if (!listType) {
        cellIdentifier = @"DAMyBigMenuBookCell";
        nsRow = [[NSNumber alloc] initWithInt:3];
        nsColumn = [[NSNumber alloc] initWithInt:3];

    } else {
        cellIdentifier = @"DAMyMenuBookCell";
        NSNumber *rows = [[NSNumber alloc]initWithInt:5];
        if (indexPath.row % [rows integerValue] == 0) {
            nsRow = [[NSNumber alloc] initWithInt:1];
            nsColumn = [[NSNumber alloc] initWithInt:1];
        } else if(indexPath.row % [rows integerValue] == 1){
            nsRow = [[NSNumber alloc] initWithInt:2];
            nsColumn = [[NSNumber alloc] initWithInt:2];
        } else if(indexPath.row % [rows integerValue] == 2){
            nsRow = [[NSNumber alloc] initWithInt:1];
            nsColumn = [[NSNumber alloc] initWithInt:1];
        } else if(indexPath.row % [rows integerValue] == 3){
            nsRow = [[NSNumber alloc] initWithInt:1];
            nsColumn = [[NSNumber alloc] initWithInt:2];
        } else if(indexPath.row % [rows integerValue] == 4){
            nsRow = [[NSNumber alloc] initWithInt:1];
            nsColumn = [[NSNumber alloc] initWithInt:1];
        } else if(indexPath.row % [rows integerValue] == 5){
            nsRow = [[NSNumber alloc] initWithInt:1];
            nsColumn = [[NSNumber alloc] initWithInt:1];
        } else if(indexPath.row % [rows integerValue] == 6){
            nsRow = [[NSNumber alloc] initWithInt:2];
            nsColumn = [[NSNumber alloc] initWithInt:2];
        } else if(indexPath.row % [rows integerValue] == 7){
            nsRow = [[NSNumber alloc] initWithInt:1];
            nsColumn = [[NSNumber alloc] initWithInt:1];
        }
    }

    cell = [[DAMyMenuBookCell alloc] initWithObj:data.item collectionView:collectionView cellIdentifier:cellIdentifier indexPath:indexPath row:nsRow column:nsColumn];
    
    cell.itemData = data.item;
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:11];
//    titleLabel.text = data.name;
    titleLabel.text = data.item.itemName;
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:102];

    [imageView setImage:[DAMenuProxy getImageFromDisk:data.item.smallimage]];
    
    UIButton *addBtn = (UIButton *)[cell viewWithTag:13];
    UIButton *addSmallBtn = (UIButton *)[cell viewWithTag:14];
    UILabel *labelAmount = (UILabel *)[cell viewWithTag:19];
    if (data.item.itemPriceHalf!=nil && data.item.itemPriceHalf.length > 0 ) {
        labelAmount.text = [NSString stringWithFormat:@"大%@元/小%@元",data.item.itemPriceNormal, data.item.itemPriceHalf];
        [addSmallBtn setHidden:NO];
    } else {
        labelAmount.text = [NSString stringWithFormat:@"%@元",data.item.itemPriceNormal];
        [addSmallBtn setHidden:YES];
        //添加小份动画
        [addSmallBtn addTarget:self
                   action:@selector(addSmallMenu:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [addBtn addTarget:self
            action:@selector(addMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
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
    return UIEdgeInsetsMake(2, 2, 2, 2);
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
    [self popupDetail:data.item];
    
}


-(void) popupDetailMenu :(NSNotification *) sender
{
    DAItem * menu  = (DAItem *)[sender object];
    [self popupDetail:menu];
}

-(void) popupDetail :(DAItem *) menu
{

    DAMyMenuBookPopupController *secondDetailViewController = [[DAMyMenuBookPopupController alloc] initWithNibName:@"DAMyMenuBookPopupController" bundle:nil];
    secondDetailViewController.delegate = self;
    secondDetailViewController.tableNO = self.tableNO;
    secondDetailViewController.menuData = menu;
    [self presentPopupViewController:secondDetailViewController animationType:MJPopupViewAnimationFade];
    
}

- (void)filterReload : (NSNotification*) notification
{
    DAMenu *menu = [notification object];
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
@end
