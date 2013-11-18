//
//  DAQueueItemListViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-15.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAQueueItemListViewController.h"

@interface DAQueueItemListViewController ()
{
    NSArray *dataList;
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
    dataList =  [[NSArray alloc ]init];
    // Do any additional setup after loading the view from its nib.
    UINib *cellNib = [UINib nibWithNibName:@"DAQueueItemListCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"DAQueueItemListCell"];
    [self loadFromFile];

    // Do any additional setup after loading the view from its nib.
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
    
    // we're going to use a custom UICollectionViewCell, which will hold an image and its label
    //
    
    
    
    
    static NSString *cellIdentifier = @"DAQueueItemListCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSDictionary *row = [dataList objectAtIndex:indexPath.row];
    
    UIImageView *imgItem = (UIImageView *)[cell viewWithTag:10];
    imgItem.image = [UIImage imageNamed:[row objectForKey:@"image"]];
    UILabel *lblName = (UILabel *)[cell viewWithTag:11];
    lblName.text = [row objectForKey:@"name"];
    UILabel *lblWaitingTime = (UILabel *)[cell viewWithTag:12];
    lblWaitingTime.text = [row objectForKey:@"waitingtime"];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}
-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *row = [dataList objectAtIndex:indexPath.row];
    NSLog(@"%@", row);
    NSString *tableNO = [row objectForKey:@"table"];
    NSString *name = [row objectForKey:@"name"];
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


- (void)filterItem:(NSString *)itemId tableNO:(NSString *)tableNo
{
    
    NSMutableArray *tmpList = [[NSMutableArray alloc] init];
    for (NSDictionary *d in dataList){
        NSString *table = [d objectForKey:@"table"];
        NSString *name =  [d objectForKey:@"name"];
        if ([table isEqualToString:tableNo] && [name isEqualToString:itemId]) {
            
        } else {
            [tmpList addObject:d];
        }
        
    }
    dataList = [[NSArray alloc] initWithArray:tmpList];
    [self.collectionView reloadData];
    
    
    
}







@end
