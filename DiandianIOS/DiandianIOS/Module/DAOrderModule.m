//
//  DAOrderModule.m
//  DiandianIOS
//
//  Created by Antony on 13-11-25.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAOrderModule.h"
#import "SmartSDK.h"

@implementation DAOrderModule
-(void) setBackOrderWithArray:(NSArray *) orderIds deskId:(NSString *)deskId callback:(void (^)(NSError *err, DAMyOrderList *order))callback
{
    NSString *path = API_SETORDER_BACK;
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:orderIds forKey:@"orderIds"];
    [params setObject:deskId forKey:@"deskId"];
    
    [[DAAFHttpClient sharedClient] postPath:path  parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DAMyOrderList *data = [[DAMyOrderList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]];
        
        if (callback) {
            callback(nil, data);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
        
    }];

}

-(void) setBackOrder:(NSString *) orderId  callback:(void (^)(NSError *err, DAOrder *list))callback
{
    NSString *path = [NSString stringWithFormat:API_SETORDER_BACK_BY_ID,orderId];
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DAOrder *data = [[DAOrder alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]];
        
        if (callback) {
            callback(nil, data);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
        
    }];
}

-(void) setDoneOrder: (NSString *) orderId callback:(void (^)(NSError *err, DAOrder *list))callback
{
    NSString *path = [NSString stringWithFormat:API_SETORDER_DONE_BY_ID,orderId];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DAOrder *data = [[DAOrder alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]];
        
        if (callback) {
            callback(nil, data);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
        
    }];
}

-(void) getDeskListByOrderIds :(NSArray *) orderIds callback:(void (^)(NSError *err, DAMyOrderList *list))callback
{
    
    NSString *path = API_ORDERS_DESK_BY_IDS([self stringFormatWithOrderIds:orderIds]);
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DAMyOrderList *data = [[DAMyOrderList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]];
        
        if (callback) {
            callback(nil, data);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
        
    }];
    
}

-(NSString *) stringFormatWithOrderIds:(NSArray *) orderIds
{
    NSMutableString *sOrderIds = [[NSMutableString alloc]init];
    for (int i =0 ;i<[orderIds count] ;i ++) {
        NSString *orderId = [orderIds objectAtIndex:i];
        if (i != 0) {
            [sOrderIds appendString:@","];
        }
        [sOrderIds appendString:orderId];
        
    }
    return [NSString stringWithFormat:@"%@",sOrderIds];
}

-(void) getOrderListWithBack:(NSString *)back start :(int)start count:(int)count callback:(void (^)(NSError *err, DAMyOrderList *list))callback
{
    NSString *path = [NSString stringWithFormat:API_ALL_ORDER_LIST_BY_BACK,start,count,back];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DAMyOrderList *data = [[DAMyOrderList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]];
        
        if (callback) {
            callback(nil, data);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
        
    }];
}

-(void)getAllOrderList:(int)start count:(int)count callback:(void (^)(NSError *err, DAMyOrderList *list))callback
{
    NSString *path = [NSString stringWithFormat:API_ALL_ORDER_LIST,start,count];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DAMyOrderList *data = [[DAMyOrderList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]];
        
        if (callback) {
            callback(nil, data);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
        
    }];
    
}


-(void) getOrderListByServiceId :(NSString *) servicdId callback:(void (^)(NSError *err, DAMyOrderList *list))callback
{
    NSString *path = [NSString stringWithFormat:API_ALL_ORDER_LIST_BY_SERVICEID,servicdId];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DAMyOrderList *data = [[DAMyOrderList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]];
        
        if (callback) {
            callback(nil, data);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
        
    }];
}

-(void) getOrderListByServiceId :(NSString *) servicdId withBack:(NSString *)withBack callback:(void (^)(NSError *err, DAMyOrderList *list))callback
{
    NSString *path = [NSString stringWithFormat:API_ALL_ORDER_LIST_WITH_BACK,servicdId,withBack];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DAMyOrderList *data = [[DAMyOrderList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]];
        
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
