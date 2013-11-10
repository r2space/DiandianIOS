//
//  DAMessageModule.h
//  TribeSDK
//
//  Created by kita on 13-4-10.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DAMessage.h"
#import "DAMessageList.h"
#import "DAAFHttpClient.h"


@interface DAMessageModule : NSObject

-(void) getMessage:(NSString *)messageId
          callback:(void (^)(NSError *error, DAMessage *message))callback;

// homepage
-(void) getMessagesInTimeLineStart:(int)start
                            count:(int)count
                           before:(NSString *)date
                         callback:(void (^)(NSError *error, DAMessageList *messages))callback;

// group
-(void) getMessagesInGroup:(NSString *) gid
                    start: (int)start
                    count: (int)count
                   before:(NSString *)date
                 callback:(void (^)(NSError *error, DAMessageList *messages))callback;

// user
-(void) getMessagesByUser:(NSString *) uid
                   start: (int)start
                   count: (int)count
                  before:(NSString *)date
                callback:(void (^)(NSError *error, DAMessageList *messages))callback;

// comment list
-(void) getComments:(NSString *)messageId
              start:(int)start
              count:(int)count
           callback:(void (^)(NSError *error, DAMessageList *messages))callback;

-(void) send:(DAMessage *)message
    callback:(void (^)(NSError *error, DAMessage *message))callback;

-(void) forward:(DAMessage *)message
       callback:(void (^)(NSError *error, DAMessage *message))callback;

-(void) like:(NSString *)messageId callback:(void(^)(NSError *error, DAMessage *message))callback;

-(void) unlike:(NSString *)messageId callback:(void(^)(NSError *error, DAMessage *message))callback;
@end
