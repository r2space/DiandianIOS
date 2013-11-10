//
//  DATurnoverModule.h
//  TribeSDK
//
//  Created by LI LIN on 2013/05/14.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAAFHttpClient.h"
#import "DATurnover.h"
#import "DATurnoverList.h"

@interface DATurnoverModule : NSObject

- (void)add:(DATurnover *)daily callback:(void (^)(NSError *error, DATurnover *daily))callback;

- (void)update:(DATurnover *)daily callback:(void (^)(NSError *error, DATurnover *daily))callback;

- (void)getListByMonth:(NSString *)month
                 start:(int)start
                 count:(int)count
              callback:(void (^)(NSError *error, DATurnoverList *list))callback;

- (void)getList:(NSString *)from
          start:(int)start
          count:(int)count
       callback:(void (^)(NSError *error, DATurnoverList *list))callback;

@end
