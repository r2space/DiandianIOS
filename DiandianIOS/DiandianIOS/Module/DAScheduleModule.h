//
//  DAScheduleModule.h
//  DiandianIOS
//
//  Created by Antony on 13-12-6.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SmartSDK.h"
@class DASchedule;
@class DAScheduleList;

@interface DAScheduleModule : NSObject

-(void) addSchedule:(NSString *)people
              phone:(NSString *)phone
                time:(NSString *)time
              desk:(NSString *)desk
            callback:(void (^)(NSError *err, DASchedule *schedule))callback;


-(void) removeScheduleById:(NSString *)scheduleId
                  callback:(void (^)(NSError *err, DASchedule *schedule))callback;

-(void)getScheduleList:(int)start count:(int)count callback:(void (^)(NSError *err, DAScheduleList *list))callback;

@end
