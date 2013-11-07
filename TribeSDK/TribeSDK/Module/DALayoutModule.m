//
//  DALayoutModule.m
//  TribeSDK
//
//  Created by kita on 13-8-30.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DALayoutModule.h"
#import "DAAFHttpClient.h"
#define kURLGetLayoutList    @"/layout/list.json?start=%d&count=%d&publish=%d&status=%d"
#define kURLGetMySelfList    @"/layout/list/myself.json?start=%d&count=%d&status=%d"
#define kURLcheckLayoutUpdata   @"/layonut/checkupdate.json?type=%@&layoutIds=%@"


@implementation DALayoutModule
-(void)getNeedConfirmLayoutListStart:(int)start count:(int)count callback:(void (^)(NSError *, DALayoutList *))callback
{
    NSString *path = [NSString stringWithFormat:kURLGetLayoutList, start, count, 0, 22];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DALayoutList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

- (void)getPublishLayoutListStart:(int)start count:(int)count callback:(void (^)(NSError *error, DAPublishLayoutList *layouts))callback
{
    NSString *path = [NSString stringWithFormat:kURLGetLayoutList, start, count, 1,22];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAPublishLayoutList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}


- (void)getSelfLayoutListStart:(int)start count:(int)count callback:(void (^)(NSError *error, DALayoutList *layouts))callback
{
    NSString *path = [NSString stringWithFormat:kURLGetMySelfList, start, count , 0];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DALayoutList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

-(void)checkMyselfLayoutUpdata:(NSString *)layoutIds callback:(void (^)(NSError *error, DALayoutList *layouts))callback
{
    NSString *path = [NSString stringWithFormat:kURLcheckLayoutUpdata, @"myself", layoutIds];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DALayoutList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}


-(void)checkNeedConfirmLayoutUpdata:(NSString *)layoutIds callback:(void (^)(NSError *error, DALayoutList *layouts))callback
{
    NSString *path = [NSString stringWithFormat:kURLcheckLayoutUpdata, @"needconfirm", layoutIds];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DALayoutList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}


-(void)checkPublishLayoutUpdata :(NSString *)layoutIds callback:(void (^)(NSError *error, DAPublishLayoutList *layouts))callback
{
    NSString *path = [NSString stringWithFormat:kURLcheckLayoutUpdata, @"publish", layoutIds];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAPublishLayoutList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

@end
