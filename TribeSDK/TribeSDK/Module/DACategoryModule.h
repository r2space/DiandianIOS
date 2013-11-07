//
//  DADataStore.h
//  TribeSDK
//
//  Created by LI LIN on 2013/05/14.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAAFHttpClient.h"
#import "DACategory.h"

@interface DACategoryModule : NSObject

- (void)getCategory:(NSString *)categoryId
           callback:(void (^)(NSError *error, DACategory *category))callback;

- (void)create:(DACategory *)category callback:(void (^)(NSError *error, DACategory *category))callback;

- (void)addItem:(DACategory *)category callback:(void (^)(NSError *error, DACategory *category))callback;

@end
