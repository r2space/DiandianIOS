//
//  DAItemList.h
//  DiandianIOS
//
//  Created by Antony on 13-12-23.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAEntity.h"
#import "SmartSDK.h"

@interface DAItemList : DAEntity<NSCoding>

@property (retain, nonatomic) NSArray   *items;
@property (retain, nonatomic) NSArray   *tags;
@property (retain, nonatomic) NSNumber  *totalItems;

    
@end
