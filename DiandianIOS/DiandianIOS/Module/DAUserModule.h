//
//  DAUserModule.h
//  DiandianIOS
//
//  Created by Antony on 13-12-1.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SmartSDK.h"

@class DAUserList;
@interface DAUserModule : NSObject


-(void) getAllUserList:(void (^)(NSError *err, DAUserList *list))callback;

@end
