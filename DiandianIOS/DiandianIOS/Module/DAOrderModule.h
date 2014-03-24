//
//  DAOrderModule.h
//  DiandianIOS
//
//  Created by Antony on 13-11-25.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SmartSDK.h"


@class DAOrder;
@class DAMyOrderList;

@interface DAOrderModule : NSObject

-(void) addOrder:(NSArray * )orderList serviceId:(NSString *)serviceId deskId:(NSString *)deskId callback:(void (^)(NSError *err, DAMyOrderList *list))callback;

-(void) getAllOrderList:(int)start count:(int)count callback:(void (^)(NSError *err, DAMyOrderList *list))callback;

-(void) getOrderListWithBack:(NSString *)back start :(int)start count:(int)count callback:(void (^)(NSError *err, DAMyOrderList *list))callback;

-(void) getOrderListByServiceId :(NSString *) servicdId withBack:(NSString *)withBack  callback:(void (^)(NSError *err, DAMyOrderList *list))callback;

-(void) getDeskListOfNeItemOrder:(void (^)(NSError *err, DAMyOrderList *list))callback;

-(void) getOrderNEItemListByServiceId:(NSString *)serviceId callback:(void (^)(NSError *err, DAMyOrderList *list))callback;

-(void) setDoneOrderWIthReturnData: (NSString *) orderId callback:(void (^)(NSError *err, DAMyOrderList *list))callback;

-(void) setDoneOrderWIthReturnDeskData: (NSString *) orderId callback:(void (^)(NSError *err, DAMyOrderList *list))callback;

-(void) getOrderItemList:(void (^)(NSError *err, DAMyOrderList *list))callback;
//
//-(void) getOrderNEItemList:(void (^)(NSError *err, DAMyOrderList *list))callback;

-(void) setFreeOrderWithArray:(NSArray *) orderIds deskId:(NSString *)deskId callback:(void (^)(NSError *err, DAMyOrderList *order))callback;


-(void) getDeskListByOrderIds :(NSArray *) orderIds callback:(void (^)(NSError *err, DAMyOrderList *list))callback;

-(void) setDoneOrder:(NSString *) orderId  callback:(void (^)(NSError *err, DAOrder *list))callback;

- (void) setDoneOrderWithArrayIds :(NSArray *) orderIds callback:(void (^)(NSError *err, DAMyOrderList *list))callback;

-(void) setBackOrder:(NSString *) orderId  callback:(void (^)(NSError *err, DAOrder *list))callback;

-(void) setBackOrderWithArray:(NSArray *) backOrderList deskId:(NSString *)deskId callback:(void (^)(NSError *err, DAMyOrderList *order))callback;
-(void) getDishOrderItemList:(void (^)(NSError *err, DAMyOrderList *list))callback;
@end
