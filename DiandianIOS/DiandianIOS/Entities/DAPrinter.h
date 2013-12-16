//
//  DAPrinter.h
//  DiandianIOS
//
//  Created by Antony on 13-12-13.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "SmartSDK.h"
#import "DAEntity.h"

@interface DAPrinter : DAEntity<NSCoding>

@property (retain, nonatomic) NSString  *name;
@property (retain, nonatomic) NSString  *printerIP;
@property (retain, nonatomic) NSString  *type;
@property (retain, nonatomic) NSString  *valid;

@end
