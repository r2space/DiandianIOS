//
//  DADeskProxy.m
//  DiandianIOS
//
//  Created by Antony on 13-11-21.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DADeskProxy.h"


@implementation DADeskProxy


+(void) initApp
{
    
}

+(void) initDesk :(NSString *) deskId  userId :(NSString *) userId  type:(NSString *)type people:(NSString *)people callback:(void (^)(NSError *err, DAService *service))callback
{
    [[DAServiceModule alloc] startService:deskId userId:userId type:type people:people callback:^(NSError *err, DAService *service) {
        
        callback(nil , service);
    }];
}

@end
