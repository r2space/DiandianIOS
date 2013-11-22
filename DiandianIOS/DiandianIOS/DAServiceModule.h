//
//  DAServiceModule.h
//  DiandianIOS
//
//  Created by Antony on 13-11-22.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAAFHttpClient.h"
#import "DAService.h"
#import "SmartSDK.h"

@interface DAServiceModule : NSObject


-(void) startService:(NSString *)deskId
              userId:(NSString *)userId
                type:(NSString *)type
              people:(NSString *)people
            callback:(void (^)(NSError *err, DAService *service))callback;

@end
