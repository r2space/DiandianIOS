//
//  DAOrderModule.h
//  DiandianIOS
//
//  Created by Antony on 13-11-25.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAMyOrderList.h"


@interface DAOrderModule : NSObject

-(void) getAllOrderList:(int)start count:(int)count callback:(void (^)(NSError *err, DAMyOrderList *list))callback;

-(void) getOrderListByServiceId :(NSString *) servicdId callback:(void (^)(NSError *err, DAMyOrderList *list))callback;

@end
