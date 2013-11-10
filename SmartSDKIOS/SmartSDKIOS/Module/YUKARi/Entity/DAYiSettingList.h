//
//  DAYiSettingList.h
//  TribeSDK
//
//  Created by Antony on 13-9-25.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//
#import "Jastor.h"

#import "DAYiSetting.h"
@interface DAYiSettingList : Jastor<NSCoding>


@property(retain, nonatomic) NSArray *items;

@end
