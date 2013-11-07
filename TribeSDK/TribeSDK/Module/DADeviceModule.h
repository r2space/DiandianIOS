//
//  DADeviceModule.h
//  TribeSDK
//
//  Created by kita on 13-8-31.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DADeviceConfirm.h"

@interface DADeviceModule : NSObject
-(void)checkStatus:(DADeviceConfirm *)device callback:(void (^)(NSError *error, DADeviceConfirm *confirmInfo))callback;

-(void) clearDeviceUserId:(NSString *)companyCode deviceid:(NSString *)deviceid callback:(void (^)(NSError *error, DADeviceConfirm *confirmInfo))callback;

@end
