//
//  DAPublishLayoutList.h
//  TribeSDK
//
//  Created by kita on 13-8-31.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import <TribeSDK/TribeSDK.h>
#import "Jastor.h"
@class DAPublishLayout;


@interface DAPublishLayoutList : Jastor <NSCoding>
@property (retain, nonatomic) NSArray *items;

-(BOOL)contains:(NSString *)publishLayoutId;
-(void)replacePublishLayout:(DAPublishLayout *)publishLayout appendWhenNotFind:(BOOL)append;
-(void)removePublishLayoutById:(NSString *)layoutId;
@end
