//
//  DADeskProxy.h
//  DiandianIOS
//
//  Created by Antony on 13-11-21.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SmartSDK.h"
#import "DAService.h"

@interface DADeskProxy : NSObject

+(void) initApp;

+(void) initDesk :(NSString *) deskId  userId :(NSString *) userId  type:(NSString *)type people:(NSString *)people callback:(void (^)(NSError *err, DAService *service))callback;

@end
