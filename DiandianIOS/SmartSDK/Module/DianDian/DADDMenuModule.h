//
//  DAMenuModule.h
//  TribeSDK
//
//  Created by Antony on 13-11-19.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAAFHttpClient.h"
#import "SmartSDK.h"
#import "DAMenuList.h"


@interface DADDMenuModule : NSObject


-(void) getList:(void (^)(NSError *err, DAMenuList * list))callback;

@end
