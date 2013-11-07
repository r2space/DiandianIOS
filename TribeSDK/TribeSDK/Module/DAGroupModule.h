//
//  DAGroupModule.h
//  TribeSDK
//
//  Created by LI LIN on 2013/05/15.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAAFHttpClient.h"
#import "DAUserList.h"
#import "DAGroupList.h"
#import "DAGroup.h"

@interface DAGroupModule : NSObject

- (void)getUserListInGroup:(NSString *)gid start:(int)start count:(int)count callback:(void (^)(NSError *error, DAUserList *users))callback;
- (void)getGroup:(NSString *)gid callback:(void (^)(NSError *error, DAGroup *group))callback;
- (void)getGroupListStart:(int)start count:(int)count type:(NSString *)type keywords:(NSString *)keywords callback:(void (^)(NSError *error, DAGroupList *groups))callback;
- (void)getGroupListByUser:(NSString *)uid start:(int)start count:(int)count callback:(void (^)(NSError *error, DAGroupList *groups))callback;
- (void)joinGroup:(NSString *)gid uid:(NSString *)uid callback:(void (^)(NSError *error, DAGroup *group))callback;
- (void)leaveGroup:(NSString *)gid uid:(NSString *)uid callback:(void (^)(NSError *error, DAGroup *group))callback;
- (void)create:(DAGroup *)group callback:(void (^)(NSError *error, DAGroup *group))callback;
- (void)update:(DAGroup *)group callback:(void (^)(NSError *error, DAGroup *group))callback;
@end
