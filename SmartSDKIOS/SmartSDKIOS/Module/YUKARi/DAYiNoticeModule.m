//
//  DAYiNoticeModule.m
//  TribeSDK
//
//  Created by LI LIN on 2013/09/05.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAYiNoticeModule.h"

#define kURLNoticeList @"/notice/list.json?start=%d&count=%d"

@implementation DAYiNoticeModule

-(void)getNoticeList:(int)start count:(int)count callback:(void (^)(NSError *, DAYiNoticeList*))callback
{
    NSString *path = [NSString stringWithFormat:kURLNoticeList, start, count];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAYiNoticeList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

@end
