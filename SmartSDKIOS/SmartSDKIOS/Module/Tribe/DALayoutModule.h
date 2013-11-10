//
//  DALayoutModule.h
//  TribeSDK
//
//  Created by kita on 13-8-30.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DALayoutList.h"
#import "DAPublishLayoutList.h"

@interface DALayoutModule : NSObject
- (void)getNeedConfirmLayoutListStart:(int)start count:(int)count callback:(void (^)(NSError *error, DALayoutList *layouts))callback;

- (void)getPublishLayoutListStart:(int)start count:(int)count callback:(void (^)(NSError *error, DAPublishLayoutList *layouts))callback;

- (void)getSelfLayoutListStart:(int)start count:(int)count callback:(void (^)(NSError *error, DALayoutList *layouts))callback;

-(void)checkMyselfLayoutUpdata:(NSString *)layoutIds callback:(void (^)(NSError *error, DALayoutList *layouts))callback;

-(void)checkNeedConfirmLayoutUpdata:(NSString *)layoutIds callback:(void (^)(NSError *error, DALayoutList *layouts))callback;

-(void)checkPublishLayoutUpdata:(NSString *)layoutIds callback:(void (^)(NSError *error, DAPublishLayoutList *layouts))callback;

@end
