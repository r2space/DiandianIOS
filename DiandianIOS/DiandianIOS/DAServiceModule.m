//
//  DAServiceModule.m
//  DiandianIOS
//
//  Created by Antony on 13-11-22.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAServiceModule.h"

@implementation DAServiceModule

-(void)startService:(NSString *)deskId userId:(NSString *)userId type:(NSString *)type people:(NSString *)people callback:(void (^)(NSError *err, DAService *service))callback
{
    NSString *path = [NSString stringWithFormat:API_START_SERVICE];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:deskId forKey:@"deskId"];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:type forKey:@"type"];
    [dic setObject:people forKey:@"people"];
    
    [[DAAFHttpClient sharedClient] postPath:path parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DAService *data = [[DAService alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]];
        
        if (callback) {
            callback(nil, data);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
        
    }];
    
}

@end
