//
//  DAPurchaseModule.h
//  TribeSDK
//
//  Created by LI LIN on 2013/05/14.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAAFHttpClient.h"
#import "DAPurchase.h"
#import "DAPurchaseList.h"

@interface DAPurchaseModule : NSObject

- (void)add:(DAPurchase *)daily callback:(void (^)(NSError *error, DAPurchase *daily))callback;

- (void)update:(DAPurchase *)daily callback:(void (^)(NSError *error, DAPurchase *daily))callback;

- (void)getList:(NSString *)from
          start:(int)start
          count:(int)count
       callback:(void (^)(NSError *error, DAPurchaseList *list))callback;

- (void)getByDate:(NSString *)date
         callback:(void (^)(NSError *error, DAPurchaseList *purchase))callback;

- (void)getTemplate:(void (^)(NSError *error, DAPurchaseList *purchase))callback;


@end
