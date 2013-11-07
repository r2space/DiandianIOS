//
//  DAYiConferenceModule.m
//  TribeSDK
//
//  Created by kita on 13-10-16.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAYiConferenceModule.h"
#import "DAAFHttpClient.h"

#define kURLSend @"/conference/add.json"


@implementation DAYiConferenceModule
-(void)send:(DAYiConference *)conference callback:(void (^)(NSError *error, DAYiConference *result))callback
{
    NSDictionary *params = [conference toDictionary];
    [[DAAFHttpClient sharedClient] postPath:kURLSend parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAYiConference alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

@end
