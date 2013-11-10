//
//  DAFileHistory.m
//  TribeSDK
//
//  Created by mac on 13-5-6.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAFileHistory.h"
#import "DAFile.h"

@implementation DAFileHistory
@synthesize items;
+(Class) items_class {
    return [DAFile class];
}
@end
