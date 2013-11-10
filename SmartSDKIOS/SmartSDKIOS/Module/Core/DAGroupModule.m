//
//  DAGroupModule.m
//  TribeSDK
//
//  Created by LI LIN on 2013/05/15.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAGroupModule.h"

#define kURLGetGroupMember  @"group/members.json?start=%d&count=%d&gid=%@"
#define kURLGetGroup        @"/group/get.json?_id=%@"
#define kURLGetGroupList    @"/group/list.json?start=%d&count=%d&type=%@&keywords=%@"
#define kURLGetGroupListByUser  @"/group/list.json?joined=true&start=%d&count=%d&uid=%@"
#define kURLJoinGroup       @"/group/join.json"
#define kURLLeaveGroup      @"/group/leave.json"
#define kURLCreateGroup     @"/group/create.json"
#define kURLUpdateGroup     @"/group/update.json?_id=%@"

@implementation DAGroupModule

- (void)getUserListInGroup:(NSString *)gid start:(int)start count:(int)count callback:(void (^)(NSError *error, DAUserList *users))callback
{
    NSString *path = [NSString stringWithFormat:kURLGetGroupMember, start, count, gid];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAUserList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

-(void)getGroup:(NSString *)gid callback:(void (^)(NSError *error, DAGroup *group))callback
{
    NSString *path = [NSString stringWithFormat:kURLGetGroup, gid];
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAGroup alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

- (void)getGroupListStart:(int)start count:(int)count type:(NSString *)type keywords:(NSString *)keywords callback:(void (^)(NSError *error, DAGroupList *groups))callback
{
    DAAFHttpClient *client = [DAAFHttpClient sharedClient];
    NSString *path = [NSString stringWithFormat:kURLGetGroupList, start, count, type, [client uriEncodeForString:keywords]];
    [client getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAGroupList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

- (void)getGroupListByUser:(NSString *)uid start:(int)start count:(int)count callback:(void (^)(NSError *error, DAGroupList *groups))callback
{
    NSString *path = [NSString stringWithFormat:kURLGetGroupListByUser, start, count, uid];
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAGroupList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

- (void)joinGroup:(NSString *)gid uid:(NSString *)uid callback:(void (^)(NSError *error, DAGroup *group))callback
{
    NSString *path = [NSString stringWithFormat:kURLJoinGroup];
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:uid, @"uid", gid, @"gid", nil];
    
    [[DAAFHttpClient sharedClient] putPath:path parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAGroup alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

- (void)leaveGroup:(NSString *)gid uid:(NSString *)uid callback:(void (^)(NSError *error, DAGroup *group))callback
{
    NSString *path = [NSString stringWithFormat:kURLLeaveGroup];
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:uid, @"uid", gid, @"gid", nil];
    [[DAAFHttpClient sharedClient] putPath:path parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAGroup alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

- (void)create:(DAGroup *)group callback:(void (^)(NSError *error, DAGroup *group))callback
{
    NSString *path = [NSString stringWithFormat:kURLCreateGroup];

    [[DAAFHttpClient sharedClient] postPath:path parameters:[group toDictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (callback) {
            callback(nil, [[DAGroup alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (callback) {
            callback(error, nil);
        }
    }];
}

- (void)update:(DAGroup *)group callback:(void (^)(NSError *error, DAGroup *group))callback
{
    NSString *path = [NSString stringWithFormat:kURLUpdateGroup, group._id];
    
    [[DAAFHttpClient sharedClient] putPath:path parameters:[group toDictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (callback) {
            callback(nil, [[DAGroup alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (callback) {
            callback(error, nil);
        }
    }];
}

@end
