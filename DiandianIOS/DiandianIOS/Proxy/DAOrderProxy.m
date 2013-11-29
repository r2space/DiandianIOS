//
//  DAOrderProxy.m
//  DiandianIOS
//
//  Created by Antony on 13-11-25.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAOrderProxy.h"

@implementation DAOrderProxy


+(void) refreshOrderList:(NSArray *) orderDic
{
    NSNotification *orderReloadNotification = [NSNotification notificationWithName:@"ioRefreshOrderList" object:orderDic];
    [[NSNotificationCenter defaultCenter] postNotification:orderReloadNotification];
}

+(void) getOldOrderListByServiceId:(NSString *)serviceId callback:(void (^)(NSError *err, DAMyOrderList *list))callback
{
    [[DAOrderModule alloc] getOrderListByServiceId:serviceId callback:^(NSError *err, DAMyOrderList *list) {
        int orderNum = 0;
        NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
        NSMutableArray *oldItems = [[NSMutableArray alloc] init];
        
        for ( DAOrder *order in list.items ) {
            int itOrderNum = [order.orderNum intValue];
            if (orderNum != itOrderNum) {
                if ([tmpArray count] > 0){
                    [oldItems addObject:tmpArray];
                }
                tmpArray = [[NSMutableArray alloc]init];
                orderNum = itOrderNum;
                [tmpArray addObject:order];
                
            } else {
                
                [tmpArray addObject:order];
            }
        }
        
        if ([tmpArray count] > 0){
            [oldItems addObject:tmpArray];
        }
        list.oldItems = [[NSArray alloc]initWithArray:oldItems];
        
        callback(nil,list);
    }];
}



+ (DAMyOrderList* ) getOneDataList:(DAMyOrderList *) orderList
{
    DAMyOrderList *tempDataList = [[DAMyOrderList alloc]init];
    NSMutableArray *tmpList = [[NSMutableArray alloc] init];
    
    for (int i = 0 ; i < orderList.items.count ; i ++) {
        DAOrder *order = [orderList.items objectAtIndex:i];
        BOOL hasOneItem = NO;
        if ([tmpList count] > 0 ) {
            for (int j = 0 ; j < [tmpList count] ; j ++) {
                DAOrder *tmpOrder = [tmpList objectAtIndex:j];
                if ([tmpOrder.itemId isEqualToString:order.itemId] && [tmpOrder.type isEqualToNumber:order.type]) {
                    hasOneItem = YES;
                    
                }
            }
        }
        if (!hasOneItem) {
            order.oneItems = [[NSMutableArray alloc]init];
            [order.oneItems addObject:order._id];
            [tmpList addObject: order];
        } else {
            for (DAOrder *oneOrder in tmpList) {
                if (oneOrder.itemId == order.itemId && [oneOrder.type isEqualToNumber:order.type]) {
                    [oneOrder.oneItems addObject:order._id];
                }
            }
        }
        
    }
    tempDataList.items = [[NSArray alloc]initWithArray:tmpList];
    return tempDataList;
}



@end
