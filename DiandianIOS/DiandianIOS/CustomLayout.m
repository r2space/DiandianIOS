//
//  CustomLayout.m
//  DiandianIOS
//
//  Created by Antony on 13-11-9.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "CustomLayout.h"
#define ITEM_SIZE 70  

@implementation CustomLayout
-(void)prepareLayout
{
    [super prepareLayout];

    CGSize size = self.collectionView.frame.size;
    _cellCount = 9;
    _center = CGPointMake(size.width / 2.0, size.height / 2.0);
    _radius = MIN(size.width, size.height) / 2.5;
    _center = CGPointMake(0, 0);
}

-(CGSize)collectionViewContentSize
{
    return [self collectionView].frame.size;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
    if (path.row % 9 == 0) {
        attributes.size = CGSizeMake(220, 220);
    } else if (path.row % 9 == 1) {
        attributes.size = CGSizeMake(440, 220);
    } else if (path.row % 9 == 2) {
        attributes.size = CGSizeMake(200, 220);
    } else if(path.row%2 == 0){
        attributes.size = CGSizeMake(ITEM_SIZE, ITEM_SIZE);
    } else {
        attributes.size = CGSizeMake(ITEM_SIZE+200, ITEM_SIZE+100);
    }

    

    attributes.center = CGPointMake(_center.x + path.item * 200 , _center.y + path.item * 200);
    return attributes;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
  NSMutableArray* attributes = [NSMutableArray array];
  for (NSInteger i=0 ; i < self.cellCount; i++) {
      NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
      [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
  }
  return attributes;
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForInsertedItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    attributes.alpha = 0.0;
    attributes.center = CGPointMake(_center.x, _center.y);
    return attributes;
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDeletedItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes* attributes = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    attributes.alpha = 0.0;
    attributes.center = CGPointMake(_center.x, _center.y);
    attributes.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0);  
    return attributes;  
}
@end
