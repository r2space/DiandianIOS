//
//  DAOrderProxy.h
//  DiandianIOS
//
//  Created by Antony on 13-11-25.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SmartSDK.h"

@interface DAOrderProxy : NSObject

//+(void) proxyDeskOrderList :

+(void) refreshOrderList:(NSArray *) orderDic;

+(void) getOldOrderListByServiceId:(NSString *)serviceId withBack:(NSString * )withBack callback:(void (^)(NSError *err, DAMyOrderList *list))callback;

+ (DAMyOrderList* ) getOneDataList:(DAMyOrderList *) orderList;
+ (DAMyOrderList* ) getOneDeskDataList:(DAMyOrderList *) orderList;


@end
