//
//  DAServiceList.h
//  DiandianIOS
//
//  Created by Antony on 13-12-3.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "SmartSDK.h"
#import "DAEntity.h"

@interface DAServiceList : DAEntity


@property (retain, nonatomic) NSArray   *items;
@property (retain, nonatomic) NSNumber  *totalItems;


@end
