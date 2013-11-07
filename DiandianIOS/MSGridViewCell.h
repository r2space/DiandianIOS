//
//  MSGridViewCell.h
//  Shareight
//
//  Created by Martin Saunders on 06/08/2013.
//  Copyright (c) 2013 TBC Digital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAMenuModule.h"
#define contentbuffer 2
@interface MSGridViewCell : UIView <UIGestureRecognizerDelegate>
@property (nonatomic,strong) NSString *reuseIdentifier;
@property (nonatomic,strong) UIView *contentView;

@property (nonatomic,strong) DAMenuModule *menuData;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)identifier menuData:(DAMenuModule *)menuData;
@end
