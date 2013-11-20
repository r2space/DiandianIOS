//
//  DAMenuModule.m
//  TribeSDK
//
//  Created by Antony on 13-11-19.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DADDMenuModule.h"
#import "SmartSDK.h"

@implementation DADDMenuModule

-(void) getList:(void (^)(NSError *err, DAMenuList *list))callback
{
    NSString *path = [NSString stringWithFormat:@"/menu/list.json"];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAMenuList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
        
    }];

    
}
@end
