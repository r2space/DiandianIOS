//
//  DAItemModule.m
//  DiandianIOS
//
//  Created by Antony on 13-12-23.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAItemModule.h"

@implementation DAItemModule

- (void) getSoldoutItemList:(void (^)(NSError *err, DASoldoutList *list))callback
{
    NSString *path = [NSString stringWithFormat:API_SOLDOUT_ITEM_LIST ];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DASoldoutList *data = [[DASoldoutList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]];
        
        if (callback) {
            callback(nil, data);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
        
    }];
    
}
-(void) removeSoldOut:(NSString *)itemId callback:(void (^)(NSError *err,NSDictionary *sold))callback
{
    NSString *path = [NSString stringWithFormat:API_REMOVE_SOLDOUT];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:itemId forKey:@"itemId"];
    [[DAAFHttpClient sharedClient] postPath:path parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [responseObject valueForKeyPath:@"data"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
        
    }];
}

- (void) removeAllSoldout :(void (^)(NSError *err, NSDictionary *sold))callback
{
    NSString *path = [NSString stringWithFormat:API_REMOVEALL_SOLDOUT];
    
    [[DAAFHttpClient sharedClient] postPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
        
    }];
}

-(void) addSoldOut:(NSString *)itemId callback:(void (^)(NSError *err, DASoldout *list))callback
{
    NSString *path = [NSString stringWithFormat:API_ADD_SOLDOUT];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:itemId forKey:@"itemId"];
    [[DAAFHttpClient sharedClient] postPath:path parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DASoldout *data = [[DASoldout alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]];
        
        if (callback) {
            callback(nil, data);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
        
    }];
}

-(void) getItemList:(int)start count:(int)count keyword:(NSString *)keyword tag:(NSString * )tag soldoutType:(NSString * )soldoutType callback:(void (^)(NSError *err, DAItemList *list))callback
{
    NSString *path = [NSString stringWithFormat:API_ITEM_LIST,start,count,keyword,soldoutType];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:tag forKey:@"tags"];
    [[DAAFHttpClient sharedClient] getPath:path parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DAItemList *data = [[DAItemList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]];
        
        if (callback) {
            callback(nil, data);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
        
    }];
    
}

-(void) getTagList: (void (^)(NSError *err, DATagList *list))callback
{
    NSString *path = [NSString stringWithFormat:API_TAG_LIST];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DATagList *data = [[DATagList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]];
        
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
