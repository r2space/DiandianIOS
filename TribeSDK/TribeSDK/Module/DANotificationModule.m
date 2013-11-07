//
//  DANotificationModule.m
//  TribeSDK
//
//  Created by kita on 13-5-3.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DANotificationModule.h"

#define kURLNotificationsUnread     @"/notification/list/unread.json?type=%@&start=%d&limit=%d"
#define kURLNotifications           @"/notification/list.json?type=%@&start=%d&limit=%d"
#define kURLAddToken                @"/notification/addtoken.json"
#define kURLClearToken              @"/notification/cleartoken.json"
#define kURLRead                    @"/notification/read.json"

@implementation DANotificationModule

-(void)getNotificationListByType:(NSString *)type start:(int)start count:(int)count callback:(void (^)(NSError *, DANotificationList *))callback
{
    NSString *path = [NSString stringWithFormat:kURLNotifications, type, start, count];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DANotificationList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

-(void)getUnreadNotificationListByType:(NSString *)type start:(int)start count:(int)count callback:(void (^)(NSError *, DANotificationList *))callback
{
    NSString *path = [NSString stringWithFormat:kURLNotificationsUnread, type, start, count];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DANotificationList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}


- (void)read:(NSString *)nid callback:(void (^)(NSError *error, NSString *nid))callback
{
    NSString *path = [NSString stringWithFormat:kURLRead];
    
    NSArray *array = [[NSArray alloc] initWithObjects:nid, nil];
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:array, @"nids", nil];
    
    [[DAAFHttpClient sharedClient] putPath:path parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, nid);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}


- (void)updateDeviceToken:(DAApns *)apn callback:(void (^)(NSError *error, DAApns *apn))callback
{
    [[DAAFHttpClient sharedClient] putPath:kURLAddToken parameters:[apn toDictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAApns alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

- (void)clearDeviceToken:(DAApns *)apn callback:(void (^)(NSError *error, DAApns *apn))callback
{
    [[DAAFHttpClient sharedClient] putPath:kURLClearToken parameters:[apn toDictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAApns alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

@end
