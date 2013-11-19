//
//  DAMenuModule.h
//  TribeSDK
//
//  Created by Antony on 13-11-19.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAAFHttpClient.h"
#import "DAMyMenu.h"
#import "DAMyMenuList.h"

@interface DADDMenuModule : NSObject


-(void) getList:(void (^)(NSError *err, DAMyMenuList * list))callback;
@end
