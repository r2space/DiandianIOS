//
//  DAScheduleModule.m
//  DiandianIOS
//
//  Created by Antony on 13-12-6.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAScheduleModule.h"

@implementation DAScheduleModule

-(void) addSchedule:(NSString *)people
              phone:(NSString *)phone
               time:(NSString *)time
               desk:(NSString *)desk
           callback:(void (^)(NSError *err, DASchedule *schedule))callback
{
    NSString *path = [NSString stringWithFormat:API_ADD_SCHEDULE];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:people forKey:@"people"];
    [dic setObject:phone forKey:@"phone"];
    [dic setObject:time forKey:@"time"];
    [dic setObject:desk forKey:@"desk"];
    
    
    [[DAAFHttpClient sharedClient] postPath:path parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DASchedule *data = [[DASchedule alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]];
        
        if (callback) {
            callback(nil, data);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
        
    }];
    
}


-(void) removeScheduleById:(NSString *)scheduleId
                  callback:(void (^)(NSError *err, DASchedule *schedule))callback
{
    NSString *path = [NSString stringWithFormat:API_REMOVE_SCHEDULE];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:scheduleId forKey:@"scheduleId"];
    
    [[DAAFHttpClient sharedClient] postPath:path parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DASchedule *data = [[DASchedule alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]];
        
        if (callback) {
            callback(nil, data);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (callback) {
            callback(error, nil);
        }
        
    }];
}

-(void)getScheduleList:(int)start count:(int)count callback:(void (^)(NSError *err, DAScheduleList *list))callback
{
    NSString *path = [NSString stringWithFormat:API_LIST_SCHEDULE,start,count];
    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DAScheduleList *data = [[DAScheduleList alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]];
        
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
