//
//  DAYiConferenceModule.h
//  TribeSDK
//
//  Created by kita on 13-10-16.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAYiConference.h"

@interface DAYiConferenceModule : NSObject
-(void)send:(DAYiConference *)conference callback:(void (^)(NSError *error, DAYiConference *result))callback;

@end
