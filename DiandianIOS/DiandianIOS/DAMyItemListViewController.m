//
//  DAMyItemListViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-14.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAMyItemListViewController.h"

@interface DAMyItemListViewController ()
{
    NSArray *dataList;
}
@end

@implementation DAMyItemListViewController

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
    dataList =  [[NSArray alloc ]init];
    // Do any additional setup after loading the view from its nib.
    UINib *cellNib = [UINib nibWithNibName:@"DAMyItemCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"DAMyItemCell"];
    
    [self loadFromFile];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return [dataList count] ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
    // we're going to use a custom UICollectionViewCell, which will hold an image and its label
    //
    
    
    NSString *cellIdentifier ;
    
    cellIdentifier = @"DAMyItemCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSDictionary *row = [dataList objectAtIndex:indexPath.row];
    
    NSLog(@"%@", row);
    
    
    UIImageView *imgItem = (UIImageView *)[cell viewWithTag:10];
    imgItem.image = [UIImage imageNamed:[row objectForKey:@"image"]];
    UILabel *lblName = (UILabel *)[cell viewWithTag:11];
    lblName.text = [row objectForKey:@"name"];
    UILabel *lblWaitingTime = (UILabel *)[cell viewWithTag:12];
    lblWaitingTime.text = [row objectForKey:@"waitingtime"];

    
    return cell;
}
-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *row = [dataList objectAtIndex:indexPath.row];
    NSLog(@"%@", row);
    
}
- (void)loadFromFile {
    NSString *pathString = [[NSBundle mainBundle] pathForResource:@"queue_detail" ofType:@"json"];
    NSData *elementsData = [NSData dataWithContentsOfFile:pathString];
    
    NSError *anError = nil;
    NSArray *items = [NSJSONSerialization JSONObjectWithData:elementsData
                                                     options:NSJSONReadingAllowFragments
                                                       error:&anError];
    
    NSMutableArray *tmpList = [[NSMutableArray alloc] init];
    for (NSDictionary *d in items){
        [tmpList addObject:d];
    }
    dataList = [[NSArray alloc] initWithArray:tmpList];
    [self.collectionView reloadData];
}



@end
