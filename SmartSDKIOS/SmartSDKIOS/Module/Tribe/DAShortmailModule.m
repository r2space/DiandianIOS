//
//  DASortmailCreatePoster.m
//  TribeSDK
//
//  Created by LI LIN on 2013/04/26.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAShortmailModule.h"

#define kURLCreate  @"shortmail/creat.json"
#define kURLStory   @"shortmail/story.json?contact=%@&date=%@&count=%d"
//#define kURLStory   @"shortmail/story.json?uid=%@&type=earlier&start=%d&count=%d"
#define kURLUsers   @"shortmail/users.json?start=%d&count=%d"

@implementation DAShortmailModule

- (void)send:(DAShortmail *)shortmail callback:(void (^)(NSError *error, DAShortmail *shortmail))callback
{
    NSDictionary *params = [shortmail toDictionary];

    [[DAAFHttpClient sharedClient] postPath:kURLCreate parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAShortmail alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}


- (void)getStoryByContact:(NSString *)contact
                    date:(NSString *)date
                    count:(int)count
                 callback:(void (^)(NSError *error, DAShortmailList *shortmails))callback
{
    DAAFHttpClient *client = [DAAFHttpClient sharedClient];
    
    NSString *encodedDate = [client uriEncodeForString:date];
    NSString *path = [NSString stringWithFormat:kURLStory, contact, encodedDate, count];
    
    [client getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAShortmailList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}


- (void)getUsers:(int)start count:(int)count callback:(void (^)(NSError *error, DAContactList *contact))callback
{
    NSString *path = [NSString stringWithFormat:kURLUsers, start, count];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAContactList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}


@end
