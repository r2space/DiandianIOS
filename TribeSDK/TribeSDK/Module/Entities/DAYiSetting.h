//
//  DAYiSetting.h
//  TribeSDK
//
//  Created by Antony on 13-9-25.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import <TribeSDK/TribeSDK.h>
#import "Jastor.h"

@interface DAYiSetting : Jastor<NSCoding>

@property (retain, nonatomic) NSString *_id;
@property (retain, nonatomic) NSString *key;
@property (retain, nonatomic) NSString *val;

@end
