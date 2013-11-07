//
//  DANotificationModule.h
//  TribeSDK
//
//  Created by kita on 13-5-3.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAAFHttpClient.h"
#import "DANotificationList.h"
#import "DAApns.h"

@interface DANotificationModule : NSObject

-(void) getNotificationListByType: (NSString *)type
                            start:(int)start
                            count:(int)count
                         callback:(void (^)(NSError *error, DANotificationList *notificationList))callback;

-(void)getUnreadNotificationListByType:(NSString *)type
                                 start:(int)start
                                 count:(int)count
                              callback:(void (^)(NSError *, DANotificationList *))callback;

- (void)read:(NSString *)nid
    callback:(void (^)(NSError *error, NSString *nid))callback;

- (void)updateDeviceToken:(DAApns *)apn
                 callback:(void (^)(NSError *error, DAApns *apn))callback;

- (void)clearDeviceToken:(DAApns *)apn
                callback:(void (^)(NSError *error, DAApns *apn))callback;

@end
