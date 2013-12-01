//
//  DAUserModule.m
//  DiandianIOS
//
//  Created by Antony on 13-12-1.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAUserModule.h"

@implementation DAUserModule


-(void) getAllUserList:(void (^)(NSError *err, DAUserList *list))callback
{
    NSString *path = [NSString stringWithFormat:API_ALL_USER_LIST];
    
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


@end
