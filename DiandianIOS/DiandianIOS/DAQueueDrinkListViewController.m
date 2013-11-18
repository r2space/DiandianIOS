//
//  DAQueueDrinkListViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-15.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAQueueDrinkListViewController.h"

@interface DAQueueDrinkListViewController ()
{
    NSArray *dataList;
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
}


- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return [dataList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
    // we're going to use a custom UICollectionViewCell, which will hold an image and its label
    //
    
    
    
    
    static NSString *cellIdentifier = @"DAQueueDrinkListCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSDictionary *row = [dataList objectAtIndex:indexPath.row];
    

    UILabel *lblName = (UILabel *)[cell viewWithTag:10];
    lblName.text = [row objectForKey:@"name"];
    UILabel *lblWaitingTime = (UILabel *)[cell viewWithTag:11];
    lblWaitingTime.text = [row objectForKey:@"waitingtime"];
    UILabel *lblAmount = (UILabel *)[cell viewWithTag:12];
    lblAmount.text = [row objectForKey:@"amount"];
    
    return cell;
}
-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *row = [dataList objectAtIndex:indexPath.row];
    NSLog(@"%@", row);
    
}

- (void)loadFromFile {
    NSString *pathString = [[NSBundle mainBundle] pathForResource:@"queue_drink" ofType:@"json"];
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
