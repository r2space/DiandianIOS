//
//  DADesk.h
//  DiandianIOS
//
//  Created by Antony on 13-11-21.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAEntity.h"
#import "SmartSDK.h"

@interface DADesk : DAEntity<NSCoding>

@property(retain, nonatomic) NSString *_id;
@property(retain, nonatomic) NSString *createat;
@property(retain, nonatomic) NSString *createby;
@property(retain, nonatomic) NSString *editat;
@property(retain, nonatomic) NSString *editby;
@property(retain, nonatomic) NSString *name;
@property(retain, nonatomic) NSNumber *valid;
@property(retain, nonatomic) NSNumber *capacity;
@property(retain, nonatomic) NSNumber *type;
@property(retain, nonatomic) DAService *service;

@property(retain, nonatomic) NSString *tableId;
@property(retain, nonatomic) NSString *state;
@property(retain, nonatomic) NSString *numOfPepole;
@property(retain, nonatomic) NSString *waitterId;
@property(retain, nonatomic) NSString *durationTime;
@property(retain, nonatomic) NSString *unfinishedCount;

-(void)swap:(DADesk *)otherTable;
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end