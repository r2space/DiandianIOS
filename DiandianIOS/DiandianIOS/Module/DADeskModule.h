//
//  DADeskModule.h
//  DiandianIOS
//
//  Created by Antony on 13-11-21.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SmartSDK.h"
#import "DADeskList.h"

@interface DADeskModule : NSObject


-(void) getDeskListWithArchiveName:(NSString *)archiveName callback:(void (^)(NSError *err, DADeskList *list))callback;





@end
