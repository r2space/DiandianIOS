//
//  DABill.h
//  DiandianIOS
//
//  Created by Antony on 13-12-2.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "SmartSDK.h"
#import "DAEntity.h"

@interface DABill : DAEntity

@property (retain, nonatomic) DADesk    *desk;
@property (retain, nonatomic) NSArray   *items;
@property (retain, nonatomic) NSNumber  *amount;
@property (retain, nonatomic) NSString  *waiter;

@end
