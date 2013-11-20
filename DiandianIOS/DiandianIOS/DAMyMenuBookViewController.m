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

#define MENU_FRAME_WIDTH    876
#define MENU_FRAME_HEIGHT   694

@interface DAMyMenuBookViewController () <DAMyMenuBookPopupDelegate>
{
    
    //api
    int pageItemCount;

    NSMutableArray *menuList;
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

    menuList = [[NSMutableArray alloc ] init];
    listType = YES;
    [self loadFromDisk];
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
    self.pageControl.numberOfPages = [menuList count] / pageItemCount ;
    if ([menuList count] % pageItemCount !=0) {
        self.pageControl.numberOfPages = self.pageControl.numberOfPages + 1;
    }
    
}

-(void)loadFromDisk{
    NSString *pathString = [[NSBundle mainBundle] pathForResource:@"menu" ofType:@"json"];
    NSData *elementsData = [NSData dataWithContentsOfFile:pathString];
    
    NSError *anError = nil;
    NSArray *parsedElements = [NSJSONSerialization JSONObjectWithData:elementsData
                                                              options:NSJSONReadingAllowFragments
                                                                error:&anError];
    
    for (NSDictionary *aModuleDict in parsedElements){
        [menuList addObject:[[DAMenu alloc ]initWithDictionary:aModuleDict]];
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return [menuList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
    // we're going to use a custom UICollectionViewCell, which will hold an image and its label
    //
    
    DAMenu *data = [menuList objectAtIndex:indexPath.row];
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

    cell = [[DAMyMenuBookCell alloc] initWithObj:data collectionView:collectionView cellIdentifier:cellIdentifier indexPath:indexPath row:nsRow column:nsColumn];
    
    cell.menuData = data;
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:11];
    titleLabel.text = data.name;
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:102];
    [imageView setImage:[ UIImage imageNamed:data.image]];
    UIButton *addBtn = (UIButton *)[cell viewWithTag:13];
    UILabel *labelAmount = (UILabel *)[cell viewWithTag:19];
    labelAmount.text = [NSString stringWithFormat:@"%@元",data.price];

    [addBtn addTarget:self
            action:@selector(addMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(void)addMenu:(UIButton*)button{
    
    [DAAnimation addOrderAnimation:button withSupview:self];
}
#pragma mark – RFQuiltLayoutDelegate

- (CGSize) blockSizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!listType) {
      return  CGSizeMake(3, 3);
    }
//    if(indexPath.row >= menuList.count)
//        NSLog(@"Asking for index paths of non-existant cells!! %d from %d cells", indexPath.row, menuList.count);
    
//    if (indexPath.row % 10 == 0)
//        return CGSizeMake(3, 1);
//    if (indexPath.row % 11 == 0)
//        return CGSizeMake(2, 1);
//    else if (indexPath.row % 7 == 0)
//        return CGSizeMake(1, 3);
//    else if (indexPath.row % 8 == 0)
//        return CGSizeMake(1, 2);
//    else if(indexPath.row % 3 == 0)
//        return CGSizeMake(2, 2);
    NSNumber *rows = [[NSNumber alloc]initWithInt:6];
    
    if (indexPath.row % [rows integerValue] == 0) {
        return CGSizeMake(2, 2);
    } else if(indexPath.row % [rows integerValue] == 1){
        return CGSizeMake(1, 1);
    } else if(indexPath.row % [rows integerValue] == 2){
        return CGSizeMake(1, 1);
    } else if(indexPath.row % [rows integerValue] == 3){
        return CGSizeMake(1, 1);
    } else if(indexPath.row % [rows integerValue] == 4){
        return CGSizeMake(1, 1);
    } else if(indexPath.row % [rows integerValue] == 5){
        return CGSizeMake(1, 1);
    } else if(indexPath.row % [rows integerValue] == 6){
        return CGSizeMake(1, 1);
//    } else if(indexPath.row % [rows integerValue] == 7){
//        return CGSizeMake(1, 1);
    } else {
        return CGSizeMake(1, 1);
    }
    
    
    
    if (indexPath.row == 0) return CGSizeMake(5, 5);
    
    return CGSizeMake(1, 1);
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
    DAMenu *data = [menuList objectAtIndex:indexPath.row];
    [self popupDetail:data];
    
}


-(void) popupDetailMenu :(NSNotification *) sender
{
    DAMenu * menu  = (DAMenu *)[sender object];
    [self popupDetail:menu];
}

-(void) popupDetail :(DAMenu *) menu
{

    DAMyMenuBookPopupController *secondDetailViewController = [[DAMyMenuBookPopupController alloc] initWithNibName:@"DAMyMenuBookPopupController" bundle:nil];
    secondDetailViewController.delegate = self;
    secondDetailViewController.tableNO = self.tableNO;
    secondDetailViewController.menuData = menu;
    [self presentPopupViewController:secondDetailViewController animationType:MJPopupViewAnimationFade];
    
}

- (void)filterReload : (NSNotification*) notification
{
    NSString *obj = [notification object];
    NSMutableArray *tmpList = [[NSMutableArray alloc] init];
    [self loadFromDisk];
   
    for (DAMenu *menu in menuList) {
        if ([menu.type isEqualToString:obj]) {
            [tmpList addObject:menu];
            
        }
    
    }
    menuList = [[NSMutableArray alloc]initWithArray:tmpList];
    [self.collectionView reloadData];
    
    self.pageControl.numberOfPages = [menuList count] / 5 ;
    if ([menuList count] % 5 !=0) {
        self.pageControl.numberOfPages = self.pageControl.numberOfPages + 1;
    }
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
