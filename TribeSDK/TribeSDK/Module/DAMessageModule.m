//
//  DAMessageModule.m
//  tribe
//
//  Created by kita on 13-4-10.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DAMessageModule.h"

#define kURLCreate @"/message/create.json"
#define kURLForward @"/message/forward.json"
#define kURLMessage @"/message/get.json?mid=%@"

#define kURLMessagesInTimeLine @"/message/list/home.json?start=%d&count=%d&before=%@"
#define kURLMessagesInGroup @"/message/list/group.json?start=%d&count=%d&gid=%@&before=%@"
#define kURLMessagesByUser @"/message/list/user.json?start=%d&count=%d&uid=%@&before=%@"

#define kURLComments @"/message/list/reply.json?mid=%@&start=%d&count=%d"
#define kURLLike    @"/message/like.json"
#define kURLUnlike    @"/message/unlike.json"

@implementation DAMessageModule

-(void) getMessage:(NSString *)messageId callback:(void (^)(NSError *error, DAMessage *message))callback
{
    NSString *path = [NSString stringWithFormat:kURLMessage,messageId];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (callback) {
            callback(nil, [[DAMessage alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

-(void)getMessagesInTimeLineStart:(int)start count:(int)count before:(NSString *)date callback:(void (^)(NSError *, DAMessageList *))callback
{
    NSString *path = [NSString stringWithFormat:kURLMessagesInTimeLine,start,count,date];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (callback) {
            callback(nil, [[DAMessageList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

-(void)getMessagesInGroup:(NSString *)gid start:(int)start count:(int)count before:(NSString *)date callback:(void (^)(NSError *, DAMessageList *))callback
{
    NSString *path = [NSString stringWithFormat:kURLMessagesInGroup,start,count,gid,date];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (callback) {
            callback(nil, [[DAMessageList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

-(void)getMessagesByUser:(NSString *)uid start:(int)start count:(int)count before:(NSString *)date callback:(void (^)(NSError *, DAMessageList *))callback
{
    NSString *path = [NSString stringWithFormat:kURLMessagesByUser,start,count,uid,date];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (callback) {
            callback(nil, [[DAMessageList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

-(void)getComments:(NSString *)messageId start:(int)start count:(int)count callback:(void (^)(NSError *, DAMessageList *))callback
{
    NSString *path = [NSString stringWithFormat:kURLComments,messageId,start,count];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (callback) {
            callback(nil, [[DAMessageList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

-(void)send:(DAMessage *)message callback:(void (^)(NSError *, DAMessage *))callback
{
    NSDictionary *params = [message toDictionary];
    
    [[DAAFHttpClient sharedClient] postPath:kURLCreate parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAMessage alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

-(void)forward:(DAMessage *)message callback:(void (^)(NSError *, DAMessage *))callback
{
    NSDictionary *params = [message toDictionary];
    
    [[DAAFHttpClient sharedClient] postPath:kURLForward parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAMessage alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

-(void) like:(NSString *)messageId callback:(void(^)(NSError *error, DAMessage *message))callback
{
    NSString *path = kURLLike;
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:messageId, @"mid", nil];
    
    [[DAAFHttpClient sharedClient] putPath:path parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (callback) {
            callback(nil, [[DAMessage alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (callback) {
            callback(error, nil);
        }
    }];
}

-(void) unlike:(NSString *)messageId callback:(void(^)(NSError *error, DAMessage *message))callback
{
    NSString *path = kURLUnlike;
    NSDictionary *param = [[NSDictionary alloc] initWithObjectsAndKeys:messageId, @"mid", nil];
    
    [[DAAFHttpClient sharedClient] putPath:path parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (callback) {
            callback(nil, [[DAMessage alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (callback) {
            callback(error, nil);
        }
    }];
}

@end
