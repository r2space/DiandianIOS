//
//  DAOrderList.h
//  DiandianIOS
//
//  Created by Antony on 13-11-22.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAEntity.h"


@interface DAMyOrderList : DAEntity<NSCoding>

@property (retain, nonatomic) NSArray   *items;
@property (retain, nonatomic) NSNumber  *totalItems;
@property (retain, nonatomic) NSArray   *oldItems;
@property (retain, nonatomic) NSString  *orderNum;
@property (retain, nonatomic) NSString  *deskName;
@property (retain, nonatomic) NSString  *now;

-(NSMutableArray*)toArray;
@end
