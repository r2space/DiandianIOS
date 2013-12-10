//
//  DAItemLayout.h
//  DiandianIOS
//
//  Created by Antony on 13-11-26.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAEntity.h"
#import "SmartSDK.h"

@interface DAItemLayout : DAEntity<NSCoding>


@property(retain, nonatomic) NSString *itemId;
@property(retain, nonatomic) NSString *column;
@property(retain, nonatomic) NSString *row;
@property(retain, nonatomic) NSString *index;
@property(retain, nonatomic) DAItem *item;

@property(retain, nonatomic) NSNumber *amount;


@end
