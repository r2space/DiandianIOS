//
//  DAMyMenuBookCell.m
//  DiandianIOS
//
//  Created by Antony on 13-11-7.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAMyMenuBookCell.h"

@implementation DAMyMenuBookCell

- (DAMyMenuBookCell *)initWithObj:(DAMyMenu *)menu collectionView:(UICollectionView *)collectionView  cellIdentifier: (NSString *)cellIdentifier indexPath:(NSIndexPath *)indexPath row:(NSNumber *)row column:(NSNumber *)column
{
    DAMyMenuBookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    UIImageView  *imageView = [UIImageView alloc];
    if ([row isEqualToNumber:[[NSNumber alloc] initWithInt:1]] && [column isEqualToNumber:[[NSNumber alloc] initWithInt:1]]) {
        imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 240, 240)];
        
    } else if([row isEqualToNumber:[[NSNumber alloc] initWithInt:2]] && [column isEqualToNumber:[[NSNumber alloc] initWithInt:2]]){
        imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 480)];
        
    } else if([row isEqualToNumber:[[NSNumber alloc] initWithInt:1]] && [column isEqualToNumber:[[NSNumber alloc] initWithInt:2]]){
        imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 240, 480)];
        
    }  else if([row isEqualToNumber:[[NSNumber alloc] initWithInt:3]] && [column isEqualToNumber:[[NSNumber alloc] initWithInt:3]]){
        imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 720, 720)];
    }
    [imageView setImage: [UIImage imageNamed:menu.image]];

    [[cell viewWithTag:12] addSubview:imageView];
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
    NSLog(@"dfdaf  data  %@  " ,self.menuData.name);
    NSNotification *orderReloadNotification = [NSNotification notificationWithName:@"orderReload" object:self.menuData];
    [[NSNotificationCenter defaultCenter] postNotification:orderReloadNotification];
}
@end
