//
//  DAMyTableViewCell.h
//  DiandianIOS
//
//  Created by Xu Yang on 11/7/13.
//  Copyright (c) 2013 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAMyTableViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *tableTitle;
@property (strong, nonatomic) IBOutlet UILabel *tableState;
@property (weak, nonatomic) IBOutlet UIImageView *imgTable;

- (void)setData:(NSString*)title setState:(NSString*)state;
@end
