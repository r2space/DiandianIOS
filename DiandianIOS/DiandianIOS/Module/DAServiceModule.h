//
//  DAServiceModule.h
//  DiandianIOS
//
//  Created by Antony on 13-11-22.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAAFHttpClient.h"
#import "DAService.h"
#import "SmartSDK.h"

@class DABill;
@class DAServiceList;

@interface DAServiceModule : NSObject

- (void) getTakeoutServiceList:(void (^)(NSError *err, DAServiceList *list))callback;

- (void) getRecentServiceList:(void (^)(NSError *err, DAServiceList *list))callback;

-(void) startService:(NSString *)deskId
              userId:(NSString *)userId
                type:(NSString *)type
              people:(NSString *)people
               phone:(NSString *)phone
            callback:(void (^)(NSError *err, DAService *service))callback;


-(void) changeService :(NSString *)serviceId
                deskId:(NSString *)deskId
                userId:(NSString *)userId
              callback:(void (^)(NSError *err, DAService *service))callback;

-(void) getBillByServiceId : (NSString * )serviceId
                  callback :(void (^)(NSError *err, DABill *bill))callback;


-(void) stopService:(NSString *) serviceId
             amount:(NSString *) amount
             profit:(NSString *) profit
               agio:(NSString *) agio
            userPay:(NSString *) userPay
       preferential:(NSString *) preferential
            payType:(NSString *) payType
               note:(NSString *) note
           callback:(void (^)(NSError *err, DAService *service))callback;


@end
