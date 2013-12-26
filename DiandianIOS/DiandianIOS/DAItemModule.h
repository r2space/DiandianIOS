//
//  DAItemModule.h
//  DiandianIOS
//
//  Created by Antony on 13-12-23.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SmartSDK.h"
@class DAItemList;
@class DATagList;
@class DASoldout;
@class DASoldoutList;
@interface DAItemModule : NSObject

-(void) getItemList:(int)start count:(int)count keyword:(NSString *)keyword tag:(NSString * )tag soldoutType:(NSString * )soldoutType callback:(void (^)(NSError *err, DAItemList *list))callback;

-(void) getTagList: (void (^)(NSError *err, DATagList *list))callback;

-(void) addSoldOut:(NSString *)itemId callback:(void (^)(NSError *err, DASoldout *sold))callback;

-(void) removeSoldOut:(NSString *)itemId callback:(void (^)(NSError *err, NSDictionary *sold))callback;

- (void) removeAllSoldout :(void (^)(NSError *err, NSDictionary *sold))callback;

- (void) getSoldoutItemList:(void (^)(NSError *err, DASoldoutList *list))callback;


@end
