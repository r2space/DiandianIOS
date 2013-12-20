//
//  DALoginModule.h
//  TribeSDK
//
//  Created by LI LIN on 2013/04/13.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAAFHttpClient.h"
#import "DAUser.h"
#import "SmartSDK.h"
@class DAMyDevice;

@interface DALoginModule : NSObject

+ (NSString *)getLoginUserId;


- (void)login:(NSString *)name
     password:(NSString *)password
       target:(id)target
      success:(SEL)success
      failure:(SEL)failure;

- (void)login:(NSString *)name
     password:(NSString *)password
     callback:(void (^)(NSError *error, DAUser *user))callback;

- (void) updatePattern:(NSString *)Pattern userId:(NSString * )userId callback:(void (^)(NSError *error, DAUser *user))callback;

- (void) checkPattern:(NSString *)Pattern userId:(NSString * )userId callback:(void (^)(NSError *error, NSDictionary *user))callback;

- (void)yukarilogin:(NSString *)name
     password:(NSString *)password
        code :(NSString *)code
     callback:(void (^)(NSError *error, DAUser *user))callback;

- (void)logout:(NSString *)token  callback:(void (^)(NSError *error))callback;

-(void)addDevice:(NSString *)deviceId userId :(NSString * )userId token:(NSString *)token  callback:(void (^)(NSError *error, DAMyDevice *device))callback;

@end
