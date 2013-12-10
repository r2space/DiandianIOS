//
//  DADevice.h
//  DiandianIOS
//
//  Created by Antony on 13-11-29.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAEntity.h"
#import "SmartSDK.h"

@interface DAMyDevice : DAEntity<NSCoding>

@property (retain, nonatomic) NSString  *deviceid;
@property (retain, nonatomic) NSString  *deviceuid;


@end
