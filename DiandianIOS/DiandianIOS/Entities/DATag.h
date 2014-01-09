//
//  DATag.h
//  DiandianIOS
//
//  Created by Antony on 13-12-24.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAEntity.h"
#import "SmartSDK.h"

@interface DATag : DAEntity<NSCoding>

@property (retain, nonatomic) NSString  *selected;
@property (retain, nonatomic) NSString  *should;
@property (retain, nonatomic) NSString  *scope;
@property (retain, nonatomic) NSString  *name;
@property (retain, nonatomic) NSNumber  *counter;


@end
