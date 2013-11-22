//
//  DADeskList.h
//  DiandianIOS
//
//  Created by Antony on 13-11-21.
//  Copyright (c) 2013年 DAC. All rights reserved.
//


#import "DAEntity.h"

@interface DADeskList : DAEntity<NSCoding>

@property (retain, nonatomic) NSArray   *items;
@property (retain, nonatomic) NSNumber  *totalItems;

@end
