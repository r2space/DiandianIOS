//
//  DAOrderProxy.m
//  DiandianIOS
//
//  Created by Antony on 13-11-25.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAOrderProxy.h"

@implementation DAOrderProxy


+(void) refreshOrderList:(NSArray *) orderDic
{
    NSNotification *orderReloadNotification = [NSNotification notificationWithName:@"ioRefreshOrderList" object:orderDic];
    [[NSNotificationCenter defaultCenter] postNotification:orderReloadNotification];
}

@end
