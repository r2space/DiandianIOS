//
//  DAOrder.h
//  DiandianIOS
//
//  Created by Antony on 13-11-22.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAEntity.h"
#import "SmartSDK.h"

@interface DAOrder : DAEntity

@property (retain, nonatomic) NSString  *deskId;
@property (retain, nonatomic) NSString  *serviceId;
@property (retain, nonatomic) NSString  *userId;
@property (retain, nonatomic) NSString  *itemId;
@property (retain, nonatomic) NSString  *orderSeq;
@property (retain, nonatomic) DAService *service;
@property (retain, nonatomic) DAItem   *item;
@property (retain, nonatomic) NSString *type;
@property (retain, nonatomic) NSString *back;
@property (retain, nonatomic) NSString *valid;
@property (retain, nonatomic) NSString *remark;

@property (retain, nonatomic) NSString *isNew;

@end