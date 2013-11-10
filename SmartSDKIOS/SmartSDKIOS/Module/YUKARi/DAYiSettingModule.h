//
//  DAYiSettingModule.h
//  TribeSDK
//
//  Created by Antony on 13-9-25.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAYiSettingList.h"
#import "DAAFHttpClient.h"
@interface DAYiSettingModule : NSObject


-(void)getAppimages:(void (^)(NSError *, DAYiSettingList *))callback;

@end
