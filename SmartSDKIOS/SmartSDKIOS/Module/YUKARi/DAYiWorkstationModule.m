//
//  DAYiWorkstationModule.m
//  TribeSDK
//
//  Created by Antony on 13-9-18.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAYiWorkstationModule.h"


#define kURLWorkstationList @"/workstation/list.json"


@implementation DAYiWorkstationModule

-(void) getWorkstationList:(void (^)(NSError *, DAYiWorkStation *))callback
{
    NSString *path = [NSString stringWithFormat:kURLWorkstationList];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAYiWorkStation alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
        
    }];
}

@end
