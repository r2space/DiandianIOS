//
//  DADeskModule.m
//  DiandianIOS
//
//  Created by Antony on 13-11-21.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DADeskModule.h"

@implementation DADeskModule


-(void) getDeskListWithArchiveName:(NSString *)archiveName callback:(void (^)(NSError *err, DADeskList *list))callback
{
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    NSString *path = [NSString stringWithFormat:API_DESK_LIST,(int)timeStamp];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DADeskList *data = [[DADeskList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]];
        
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
