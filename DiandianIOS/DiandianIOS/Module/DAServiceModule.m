//
//  DAServiceModule.m
//  DiandianIOS
//
//  Created by Antony on 13-11-22.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAServiceModule.h"

@implementation DAServiceModule

- (void) getTakeoutServiceList:(void (^)(NSError *err, DAServiceList *list))callback
{
    NSString *path = [NSString stringWithFormat:API_GET_TAKEOUT_SERVICELIST];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        DAServiceList *data = [[DAServiceList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]];
        
        if (callback) {
            callback(nil, data);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
        
    }];
    
}
- (void) getRecentServiceList:(void (^)(NSError *err, DAServiceList *list))callback
{
    NSString *path = [NSString stringWithFormat:API_GET_RECENT_SERVICELIST];

    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        DAServiceList *data = [[DAServiceList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]];

        if (callback) {
            callback(nil, data);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        if (callback) {
            callback(error, nil);
        }

    }];

}
-(void)startService:(NSString *)deskId
             userId:(NSString *)userId
               type:(NSString *)type
             people:(NSString *)people
              phone:(NSString *)phone
           callback:(void (^)(NSError *err, DAService *service))callback
{
    NSString *path = [NSString stringWithFormat:API_START_SERVICE];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:deskId forKey:@"deskId"];
    [dic setObject:userId forKey:@"userId"];
    [dic setObject:type forKey:@"type"];
    [dic setObject:people forKey:@"people"];
    [dic setObject:phone forKey:@"phone"];
    
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

-(void) changeService :(NSString *)serviceId
                deskId:(NSString *)deskId
                userId:(NSString *)userId
              callback:(void (^)(NSError *err, DAService *service))callback
{
    NSString *path = [NSString stringWithFormat:API_CHANGE_SERVICE];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:serviceId forKey:@"serviceId"];
    [dic setObject:deskId forKey:@"deskId"];
    
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

-(void) getBillByServiceId : (NSString * )serviceId
                  callback :(void (^)(NSError *err, DABill *bill))callback
{
    NSString *path = [NSString stringWithFormat:API_GET_BILL,serviceId];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DABill *data = [[DABill alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]];
        
        if (callback) {
            callback(nil, data);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
        
    }];
}

-(void) stopService:(NSString *) serviceId
             amount:(NSString *) amount
             profit:(NSString *) profit
               agio:(NSString *) agio
            userPay:(NSString *) userPay
       preferential:(NSString *) preferential
            payType:(NSString *) payType
               note:(NSString *) note
           callback:(void (^)(NSError *err, DAService *service))callback
{
    NSString *path = [NSString stringWithFormat:API_STOP_BILL];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:serviceId forKey:@"serviceId"];
    [dic setObject:amount forKey:@"amount"];
    [dic setObject:profit forKey:@"profit"];
    [dic setObject:userPay forKey:@"userPay"];
    [dic setObject:agio forKey:@"agio"];
    [dic setObject:preferential forKey:@"preferential"];
    [dic setObject:payType forKey:@"payType"];
    if(note != nil){
        [dic setObject:note forKey:@"serviceNote"];
    }else{
        [dic setObject:@"" forKey:@"serviceNote"];
    }
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
