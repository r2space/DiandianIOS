//
//  DAOpenTableViewController.m
//  MenuBook
//
//  Created by Antony on 13-11-5.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAOpenTableViewController.h"
#import "DAOpenTableViewCell.h"

@interface DAOpenTableViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation DAOpenTableViewController

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
	// Do any additional setup after loading the view.
    
    //[self.collectionView registerClass:[DAOpenTableViewController class] forCellWithReuseIdentifier:@"TableCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 1
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return 8;
}
// 2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}
// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DAOpenTableViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"TableCell" forIndexPath:indexPath];
//    cell.imageView.image =
    
    return cell;
}
// 4
/*- (UICollectionReusableView *)collectionView:
 (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
 {
 return [[UICollectionReusableView alloc] init];
 }*/



@end
