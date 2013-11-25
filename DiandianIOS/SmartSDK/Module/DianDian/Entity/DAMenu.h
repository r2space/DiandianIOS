//
//  DAMyMenu.h
//  TribeSDK
//
//  Created by Antony on 13-11-7.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//


#import "Jastor.h"
#import "DAItem.h"


@interface DAMenu : Jastor<NSCoding>

@property(retain, nonatomic) NSString *_id;
@property(retain, nonatomic) NSString *name;
@property(retain, nonatomic) NSNumber *page;
@property(retain, nonatomic) NSArray  *items;

@property(retain, nonatomic) NSString *title;
@property(retain, nonatomic) NSString *image;
@property(retain, nonatomic) NSString *price;
@property(retain, nonatomic) NSString *type;
@property(retain, nonatomic) NSString *index;
@property(retain, nonatomic) NSString *amount;
@property(retain, nonatomic) NSString *status;



@end

