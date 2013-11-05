//
//  DAMyBookViewController.m
//  MenuBook
//
//  Created by Antony on 13-11-5.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAMyBookViewController.h"
#import "DABookCell.h"

@interface DAMyBookViewController ()

@end

@implementation DAMyBookViewController

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
    UINib *cellNib = [UINib nibWithNibName:@"DABookCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"simpleCell"];
    
    NSMutableArray *firstSection = [[NSMutableArray alloc] init];
    for (int i=0; i<10; i++){
       [firstSection addObject:[NSString stringWithFormat:@"单元格 %d", i]];
    }
    self.dataArray = [[NSArray alloc] initWithArray:firstSection];

//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    [flowLayout setItemSize:CGSizeMake(100, 100)];
//    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//    flowLayout.sectionInset = UIEdgeInsetsMake(0, 2, 0, 0);
    
    
//    [self.collectionView setCollectionViewLayout:flowLayout];
    
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    NSString *cellData = [self.dataArray  objectAtIndex:indexPath.row];
    NSLog(@"%@",cellData);
    static NSString *cellIdentifier = @"simpleCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:10];
    titleLabel.text = cellData;
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    NSLog(@"%d" , [self.dataArray count]);
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataArray count];
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"sadfsdfsadf");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
