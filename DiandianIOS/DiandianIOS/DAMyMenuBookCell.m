//
//  DAMyMenuBookCell.m
//  DiandianIOS
//
//  Created by Antony on 13-11-7.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAMyMenuBookCell.h"

@implementation DAMyMenuBookCell


- (NSArray *)constrainSubview:(UIView *)subview toMatchWithSuperview:(UIView *)superview
{
    subview.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(subview);
    
    NSArray *constraints = [NSLayoutConstraint
                            constraintsWithVisualFormat:@"H:|[subview]|"
                            options:0
                            metrics:nil
                            views:viewsDictionary];
    constraints = [constraints arrayByAddingObjectsFromArray:
                   [NSLayoutConstraint
                    constraintsWithVisualFormat:@"V:|[subview]|"
                    options:0
                    metrics:nil
                    views:viewsDictionary]];
    [superview addConstraints:constraints];
    
    return constraints;
}

- (DAMyMenuBookCell *)initWithObj:(DAItem *)menu collectionView:(UICollectionView *)collectionView  cellIdentifier: (NSString *)cellIdentifier indexPath:(NSIndexPath *)indexPath row:(NSNumber *)row column:(NSNumber *)column
{
    DAMyMenuBookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    UIImageView  *imageView = [UIImageView alloc];
    if ([row isEqualToNumber:[[NSNumber alloc] initWithInt:1]] && [column isEqualToNumber:[[NSNumber alloc] initWithInt:1]]) {
        imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 240)];
        
    } else if([row isEqualToNumber:[[NSNumber alloc] initWithInt:2]] && [column isEqualToNumber:[[NSNumber alloc] initWithInt:2]]){
        imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 600, 480)];
        
    } else if([row isEqualToNumber:[[NSNumber alloc] initWithInt:1]] && [column isEqualToNumber:[[NSNumber alloc] initWithInt:2]]){
        imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 480)];
        
    }  else if([row isEqualToNumber:[[NSNumber alloc] initWithInt:3]] && [column isEqualToNumber:[[NSNumber alloc] initWithInt:3]]){
        imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 900, 720)];
    }
    
    [imageView setImage: [UIImage imageNamed:@"茶香虾.jpg"]];
    
    [((UIImageView *)[cell viewWithTag:12]).superview addSubview:imageView];
    UIView *maskView = [cell viewWithTag:101];

//    [cell constrainSubview:maskView toMatchWithSuperview:((UIImageView *)[cell viewWithTag:12]).superview];



    [((UIImageView *)[cell viewWithTag:12]).superview addSubview:maskView];
    return cell;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)addMenu:(id)sender {
    NSNotification *addOrderNotification = [NSNotification notificationWithName:@"menu_addOrder" object:self.itemData];
    
    [[NSNotificationCenter defaultCenter] postNotification:addOrderNotification];
}

- (IBAction)addSmallItem:(id)sender {
    NSNotification *notice = [NSNotification notificationWithName:@"menu_addSmallItem" object:self.itemData];
    
    [[NSNotificationCenter defaultCenter] postNotification:notice];
}

@end
