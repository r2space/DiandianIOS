//
//  DATurnover.h
//  TribeSDK
//
//  Created by LI LIN on 2013/05/14.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "Jastor.h"
#import "DAUser.h"

@interface DATurnoverItem : Jastor

@property (retain, nonatomic) NSString *amount;
@property (retain, nonatomic) NSString *name;

@end

@interface DATurnover : Jastor

@property (retain, nonatomic) NSString *id;
@property (retain, nonatomic) NSString *_id;

@property (retain, nonatomic) NSString *date;
@property (retain, nonatomic) NSString *weather;
@property (retain, nonatomic) NSString *amount;
@property (retain, nonatomic) NSArray *category;

@property (retain, nonatomic) NSString *createby;
@property (retain, nonatomic) NSString *createat;
@property (retain, nonatomic) NSString *editby;
@property (retain, nonatomic) NSString *editat;
@property (retain, nonatomic) DAUser *user;

@end
