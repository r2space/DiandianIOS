//
//  DAYiSettingModule.m
//  TribeSDK
//
//  Created by Antony on 13-9-25.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAYiSettingModule.h"
#define kURLAppimageList @"/setting/find/appimage.json"

@implementation DAYiSettingModule

-(void)getAppimages:(void (^)(NSError *, DAYiSettingList *))callback
{
    NSString *path = [NSString stringWithFormat:kURLAppimageList];
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DAYiSettingList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (callback) {
            callback(error, nil);
        }
    }];
}
@end
