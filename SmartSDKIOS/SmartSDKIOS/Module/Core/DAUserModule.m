//
//  DAUserModule.m
//  TribeSDK
//
//  Created by LI LIN on 2013/05/19.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAUserModule.h"

#define kURLGetUser                 @"/user/get.json?_id=%@"
#define kURLGetUserList             @"/user/list.json?start=%d&count=%d"
#define kURLGetUserFollowerList     @"/user/list.json?kind=follower&uid=%@&start=%d&count=%d&keywords=%@"
#define kURLGetUserFollowingList    @"/user/list.json?kind=following&uid=%@&start=%d&count=%d&keywords=%@"
#define kURLFollow                  @"/user/follow.json?_id=%@"
#define kURLUnfollow                @"/user/unfollow.json?_id=%@"
#define kURLUpdate                  @"/user/update.json?_id=%@"
#define kURLUpdatePassword                  @"/user/updatePassword.json"


#define kURLGetUserSearchListBykeywords             @"/user/list.json?start=%d&count=%d&kind=all&gid=%@&keywords=%@"

#define kURLGetUserInGroupListBykeywords             @"/user/list.json?start=%d&count=%d&uid=%@&kind=group&gid=%@&keywords=%@"
@implementation DAUserModule

- (void) getUserListStart:(int)start count:(int)count keywords:(NSString *)keywords callback:(void (^)(NSError *error, DAUserList *users))callback;

{
    DAAFHttpClient *client = [DAAFHttpClient sharedClient];
    NSString *path = [NSString stringWithFormat:kURLGetUserSearchListBykeywords, start, count,@"",[client uriEncodeForString:keywords]];
    
    [client getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAUserList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
        
    }];
}


- (void) getUserListInGroup:(NSString *)gid uid:(NSString *)uid start:(int)start count:(int)count keywords:(NSString *)keywords callback:(void (^)(NSError *error, DAUserList *users))callback
{
    DAAFHttpClient *client = [DAAFHttpClient sharedClient];
    NSString *path = [NSString stringWithFormat:kURLGetUserInGroupListBykeywords, start, count,uid,gid,[client uriEncodeForString:keywords]];
    [client getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAUserList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
        
    }];
}


- (void)getUserFollowerListByUser:(NSString *)uid start:(int)start count:(int)count  keywords:(NSString *)keywords callback:(void (^)(NSError *error, DAUserList *users))callback
{
    DAAFHttpClient *client = [DAAFHttpClient sharedClient];
    NSString *path = [NSString stringWithFormat:kURLGetUserFollowerList, uid, start, count,[client uriEncodeForString:keywords]];
    
    [client getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAUserList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

- (void)getUserFollowingListByUser:(NSString *)uid start:(int)start count:(int)count  keywords:(NSString *)keywords callback:(void (^)(NSError *error, DAUserList *users))callback
{
    DAAFHttpClient *client = [DAAFHttpClient sharedClient];
    NSString *path = [NSString stringWithFormat:kURLGetUserFollowingList, uid, start, count,[client uriEncodeForString:keywords]];
    
    [client getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAUserList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}


- (void)getUserById:(NSString *)uid callback:(void (^)(NSError *error, DAUser *user))callback
{
    NSString *path = [NSString stringWithFormat:kURLGetUser, uid];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAUser alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}


- (void)follow:(NSString *)uid callback:(void (^)(NSError *error, NSString *uid))callback
{
    NSString *path = [NSString stringWithFormat:kURLFollow, uid];
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:uid, @"uid", nil];
    
    [[DAAFHttpClient sharedClient] putPath:path parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, uid);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

- (void)unfollow:(NSString *)uid callback:(void (^)(NSError *error, NSString *uid))callback
{
    NSString *path = [NSString stringWithFormat:kURLUnfollow, uid];
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:uid, @"uid", nil];
    
    [[DAAFHttpClient sharedClient] putPath:path parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, uid);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

- (void)update:(DAUser *)user callback:(void (^)(NSError *error, DAUser *user))callback
{
    NSString *path = [NSString stringWithFormat:kURLUpdate, user._id];
    
    [[DAAFHttpClient sharedClient] putPath:path parameters:[user toDictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAUser alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}
-(void)changePass:(NSString *)oldpass confirmpass:(NSString *)confirmpass callback:(void (^)(NSError *error, DAUser *user))callback
{
    NSString *path = [NSString stringWithFormat:kURLUpdatePassword];

    NSDictionary *pass = [NSDictionary dictionaryWithObjectsAndKeys:oldpass,@"oldpass",confirmpass,@"confirmpass",nil];//注意
    [[DAAFHttpClient sharedClient] postPath:path parameters:pass success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAUser alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

@end
