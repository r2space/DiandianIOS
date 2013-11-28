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
@end
