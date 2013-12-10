//
//  DAUserList.h
//  DiandianIOS
//
//  Created by Antony on 13-12-1.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAEntity.h"
#import "SmartSDK.h"

@interface DAUserList : DAEntity


@property (retain, nonatomic) NSArray   *items;
@property (retain, nonatomic) NSNumber  *totalItems;


@end
