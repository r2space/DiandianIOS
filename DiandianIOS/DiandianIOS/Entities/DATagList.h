//
//  DATagList.h
//  DiandianIOS
//
//  Created by Antony on 13-12-24.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAEntity.h"
#import "SmartSDK.h"

@interface DATagList : DAEntity<NSCoding>

@property (retain, nonatomic) NSArray   *items;

@end
