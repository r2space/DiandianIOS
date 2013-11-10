//
//  DANotificationList.m
//  TribeSDK
//
//  Created by mac on 13-4-25.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DANotification.h"
#import "DANotificationList.h"

@implementation DANotificationList

@synthesize  total,items;

+(Class) items_class {
    return [DANotification class];
}

@end
