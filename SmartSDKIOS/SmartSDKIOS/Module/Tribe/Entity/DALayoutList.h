//
//  DALayoutList.h
//  TribeSDK
//
//  Created by kita on 13-8-30.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "Jastor.h"
@class DALayout;


@interface DALayoutList : Jastor <NSCoding>
@property (retain, nonatomic) NSArray *items;
-(BOOL)contains:(NSString *)layoutId;
-(void)replaceLayout:(DALayout *)layout appendWhenNotFind:(BOOL)append;
-(void)removeLayoutById:(NSString *)layoutId;
@end
