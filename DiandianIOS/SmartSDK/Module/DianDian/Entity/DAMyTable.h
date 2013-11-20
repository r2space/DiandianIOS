//
//  DAMyMenu.h
//  TribeSDK
//
//  Created by Antony on 13-11-7.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//


#import "Jastor.h"

@interface DAMyTable: Jastor

@property(retain, nonatomic) NSString *tableId;
@property(retain, nonatomic) NSString *name;
@property(retain, nonatomic) NSString *type;
@property(retain, nonatomic) NSString *state;
@property(retain, nonatomic) NSString *numOfPepole;
@property(retain, nonatomic) NSString *waitterId;
@property(retain, nonatomic) NSString *durationTime;
@property(retain, nonatomic) NSString *unfinishedCount;

-(void)swap:(DAMyTable*)otherTable;
@end

