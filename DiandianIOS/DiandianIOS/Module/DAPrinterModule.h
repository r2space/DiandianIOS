//
//  DAPrinterModule.h
//  DiandianIOS
//
//  Created by Antony on 13-12-13.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SmartSDK.h"

@class DAPrinterList;
@class DAPrinter;

@interface DAPrinterModule : NSObject


-(void)getPrinterById:(NSString *)printerId callback:(void (^)(NSError *err, DAPrinter *obj))callback;

-(void)getPrinterList:(void (^)(NSError *err, DAPrinterList *obj))callback;

@end
