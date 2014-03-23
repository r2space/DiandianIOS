//
//  DAService.h
//  DiandianIOS
//
//  Created by Antony on 13-11-21.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAEntity.h"

@interface DAService : DAEntity <NSCoding>

@property (retain, nonatomic) NSString *_id;
@property (retain, nonatomic) NSString *deskId;
@property (retain, nonatomic) NSNumber *type;
@property (retain, nonatomic) NSNumber *status;
@property (retain, nonatomic) NSNumber *people;
@property (retain, nonatomic) NSNumber *unfinishedCount;
@property (retain, nonatomic) NSString *billNum;
@property (retain, nonatomic) NSString *orderNo;
@property (retain, nonatomic) NSString *phone;
@property (retain, nonatomic) NSString *takeout;


@property (retain, nonatomic) NSString *amount;
@property (retain, nonatomic) NSString *profit;
@property (retain, nonatomic) NSString *agio;
@property (retain, nonatomic) NSString *preferential;

@property (retain, nonatomic) NSString *payType;
@property (retain, nonatomic) NSString *createat;
@property (retain, nonatomic) NSString *createby;
@property (retain, nonatomic) NSString *editat;
@property (retain, nonatomic) NSString *editby;

@property (retain, nonatomic) NSString *deskName;
@property (retain, nonatomic) NSString *userPay;
@end
