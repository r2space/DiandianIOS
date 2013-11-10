//
//  DAYiNoticeModule.h
//  TribeSDK
//
//  Created by LI LIN on 2013/09/05.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAAFHttpClient.h"
#import "DAYiNotice.h"

@interface DAYiNoticeModule : NSObject

-(void)getNoticeList:(int)start count:(int)count callback:(void (^)(NSError *, DAYiNoticeList*))callback;

@end
