//
//  DATurnoverModule.m
//  TribeSDK
//
//  Created by LI LIN on 2013/05/14.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DATurnoverModule.h"

#define kURLTurnoverAdd     @"/app/turnover/add.json"
#define kURLTurnoverUpdate  @"/app/turnover/update.json?id=%@"
#define kURLTurnoverList    @"/app/turnover/list.json?month=%@&start=%d&limit=%d"
#define kURLTurnoverListAll @"/app/turnover/list.json?from=%@&start=%d&limit=%d"

@implementation DATurnoverModule

- (void)add:(DATurnover *)daily callback:(void (^)(NSError *error, DATurnover *daily))callback
{
    NSDictionary *params = [daily toDictionary];
    
    [[DAAFHttpClient sharedClient] postPath:kURLTurnoverAdd parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DATurnover alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

- (void)update:(DATurnover *)daily callback:(void (^)(NSError *error, DATurnover *daily))callback
{
    NSDictionary *params = [daily toDictionary];
    NSString *path = [NSString stringWithFormat:kURLTurnoverUpdate, daily._id];
    
    [[DAAFHttpClient sharedClient] postPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DATurnover alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}


- (void)getListByMonth:(NSString *)month
                 start:(int)start
                 count:(int)count
              callback:(void (^)(NSError *error, DATurnoverList *list))callback
{
    NSString *m = [DARequestHelper uriEncodeForString:month];
    NSString *path = [NSString stringWithFormat:kURLTurnoverList, m, start, count];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DATurnoverList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}

// 获取指定日期开始的数据
- (void)getList:(NSString *)from
                 start:(int)start
                 count:(int)count
              callback:(void (^)(NSError *error, DATurnoverList *list))callback
{
    NSString *m = [DARequestHelper uriEncodeForString:from];
    NSString *path = [NSString stringWithFormat:kURLTurnoverListAll, m, start, count];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (callback) {
            callback(nil, [[DATurnoverList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
    }];
}


@end
