//
//  DADesk.h
//  DiandianIOS
//
//  Created by Antony on 13-11-21.
//  Copyright (c) 2013年 DAC. All rights reserved.
//


#import "DAEntity.h"
#import "SmartSDK.h"

@interface DADesk : DAEntity<NSCoding>


@property(retain, nonatomic) NSString *name;
@property(retain, nonatomic) NSNumber *valid;
@property(retain, nonatomic) NSNumber *capacity;
@property(retain, nonatomic) NSNumber *type;
@property(retain, nonatomic) DAService *service;


- (id)initWithDictionary:(NSDictionary *)dictionary;
- (BOOL)isEmpty;
- (BOOL)isHasUnfinished;
@end