//
//  DAItem.h
//  DiandianIOS
//
//  Created by Antony on 13-11-20.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAEntity.h"

@interface DAItem : DAEntity <NSCoding>

@property(retain, nonatomic) NSString *printerId;
@property(retain, nonatomic) NSString *itemName;
@property(retain, nonatomic) NSString *itemPriceNormal;
@property(retain, nonatomic) NSString *itemPriceHalf;
@property(retain, nonatomic) NSString *itemPriceDiscount;
@property(retain, nonatomic) NSString *itemType;
@property(retain, nonatomic) NSString *itemComment;
@property(retain, nonatomic) NSString *itemMaterial;
@property(retain, nonatomic) NSString *itemMethod;
@property(retain, nonatomic) NSString *bigimage;
@property(retain, nonatomic) NSString *smallimage;
@property(retain, nonatomic) NSNumber *type;
@property(retain, nonatomic) NSNumber *soldout;

@property(retain, nonatomic) NSNumber *discount;
@property(retain, nonatomic) NSNumber *amount;
@property(retain, nonatomic) NSString *status;

@end
