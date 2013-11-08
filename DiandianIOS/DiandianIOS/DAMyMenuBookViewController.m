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
    defaultLayout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(filterReload:)
                                                 name:@"filterReload" object:nil];
    
    
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

    NSString *cellIdentifier ;
    if (!listType) {
        cellIdentifier = @"DAMyBigMenuBookCell";
    } else {
        cellIdentifier = @"DAMyMenuBookCell";
    }
    
    DAMyMenuBookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.menuData = data;
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:11];
    titleLabel.text = data.name;
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:12];
    [imageView setImage: [UIImage imageNamed:data.image]];
    UIButton *addBtn = (UIButton *)[cell viewWithTag:13];
    
    [addBtn addTarget:self
            action:@selector(addMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(void)addMenu:(UIButton*)button{
    NSLog(@"增加菜");
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (listType) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setItemSize:CGSizeMake(693, 680)];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        
        [self.collectionView setCollectionViewLayout:flowLayout];
        
        UINib *cellbigNib = [UINib nibWithNibName:@"DAMyBigMenuBookCell" bundle:nil];
        [self.collectionView registerNib:cellbigNib forCellWithReuseIdentifier:@"DAMyBigMenuBookCell"];
        
        listType = NO;
        [self.collectionView  reloadData];
    } else {
        
        
        [self.collectionView setCollectionViewLayout:defaultLayout];
        
        UINib *cellNib = [UINib nibWithNibName:@"DAMyMenuBookCell" bundle:nil];
        [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"DAMyMenuBookCell"];
        
        listType = YES;
        [self.collectionView  reloadData];
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
