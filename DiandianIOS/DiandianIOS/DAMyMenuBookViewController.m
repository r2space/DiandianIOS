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


@interface DAMyMenuBookViewController ()
{
    MSGridView *gridView;
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
    layout.blockPixels = CGSizeMake(340 ,200);
    layout.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(filterReload:) name:@"filterReload" object:nil];
    
    defaultLayout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
}
- (void) viewDidAppear:(BOOL)animated {
    [self.collectionView reloadData];
}

-(void)loadFromDisk{
    NSString *pathString = [[NSBundle mainBundle] pathForResource:@"menu" ofType:@"json"];
    NSData *elementsData = [NSData dataWithContentsOfFile:pathString];
    
    NSError *anError = nil;
    NSArray *parsedElements = [NSJSONSerialization JSONObjectWithData:elementsData
                                                              options:NSJSONReadingAllowFragments
                                                                error:&anError];
    
    for (NSDictionary *aModuleDict in parsedElements){
        [menuList addObject:[[DAMyMenu alloc ]initWithDictionary:aModuleDict]];
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
    
    DAMyMenu *data = [menuList objectAtIndex:indexPath.row];
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

    UIButton *addBtn = (UIButton *)[cell viewWithTag:13];
    
    [addBtn addTarget:self
            action:@selector(addMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(void)addMenu:(UIButton*)button{
    NSLog(@"增加菜");
}
#pragma mark – RFQuiltLayoutDelegate

- (CGSize) blockSizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!listType) {
      return  CGSizeMake(3, 3);
    }
//    if(indexPath.row >= menuList.count)
        NSLog(@"Asking for index paths of non-existant cells!! %d from %d cells", indexPath.row, menuList.count);
    
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
    NSNumber *rows = [[NSNumber alloc]initWithInt:5];
    
    if (indexPath.row % [rows integerValue] == 0) {
        return CGSizeMake(1, 1);
    } else if(indexPath.row % [rows integerValue] == 1){
        return CGSizeMake(2, 2);
    } else if(indexPath.row % [rows integerValue] == 2){
        return CGSizeMake(1, 1);
    } else if(indexPath.row % [rows integerValue] == 3){
        return CGSizeMake(1, 2);
    } else if(indexPath.row % [rows integerValue] == 4){
        return CGSizeMake(1, 1);
    } else if(indexPath.row % [rows integerValue] == 5){
        return CGSizeMake(1, 1);
//    } else if(indexPath.row % [rows integerValue] == 6){
//        return CGSizeMake(2, 2);
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

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (listType) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setItemSize:CGSizeMake(693, 680)];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        flowLayout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
        
        
        UINib *cellbigNib = [UINib nibWithNibName:@"DAMyBigMenuBookCell" bundle:nil];
        [self.collectionView registerNib:cellbigNib forCellWithReuseIdentifier:@"DAMyBigMenuBookCell"];
        
        listType = NO;
        [self.collectionView  reloadData];
    } else {
        
        
        [self.collectionView setCollectionViewLayout:defaultLayout];
        
        UINib *cellNib = [UINib nibWithNibName:@"DAMyMenuBookCell" bundle:nil];
        [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"DAMyMenuBookCell"];
        
        listType = YES;
        [self.collectionView reloadData];
    }
    
    
}


- (void)filterReload : (NSNotification*) notification
{
    NSString *obj = [notification object];
    NSMutableArray *tmpList = [[NSMutableArray alloc] init];
    [self loadFromDisk];
   
    for (DAMyMenu *menu in menuList) {
        if ([menu.type isEqualToString:obj]) {
            [tmpList addObject:menu];
            
        }
    
    }
    menuList = [[NSMutableArray alloc]initWithArray:tmpList];
    [self.collectionView reloadData];
}
@end
