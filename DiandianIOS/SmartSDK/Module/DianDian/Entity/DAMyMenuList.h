//
//  DAMyMenuList.h
//  TribeSDK
//
//  Created by Antony on 13-11-9.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"
@interface DAMyMenuList : Jastor <NSCoding>
@property (retain, nonatomic) NSArray   *items;
@property (retain, nonatomic) NSString  *total;
@end
