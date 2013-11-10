//
//  DADeviceModule.m
//  TribeSDK
//
//  Created by kita on 13-8-31.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DADeviceModule.h"
#import "DAAFHttpClient.h"

#define kURLDeviceConfirm       @"/device/add.json"
#define kURLDeviceLogin         @"/device/register.json"
#define kURLDeviceSetUserid     @"/device/clear.json"

@implementation DADeviceModule
-(void)checkStatus:(DADeviceConfirm *)device callback:(void (^)(NSError *error, DADeviceConfirm *confirmInfo))callback
{
    NSString *path = [NSString stringWithFormat:kURLDeviceLogin];
    [[DAAFHttpClient sharedClient] getPath:path parameters:[device toDictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (callback) {
            callback(nil, [[DADeviceConfirm alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (callback) {
            callback(error, nil);
        }
    }];
}

-(void) clearDeviceUserId:(NSString *)companyCode deviceid:(NSString *)deviceid callback:(void (^)(NSError *, DADeviceConfirm *))callback
{

    NSString *path = [NSString stringWithFormat:kURLDeviceSetUserid];
    
    NSDictionary *device = [NSDictionary dictionaryWithObjectsAndKeys:@" ",@"userid",companyCode,@"code",deviceid,@"deviceid", nil];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:device success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (callback) {
            callback(nil, [[DADeviceConfirm alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (callback) {
            callback(error, nil);
        }
    }];
    
}

@end
