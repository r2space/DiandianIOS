//
//  DAMenuProxy.h
//  DiandianIOS
//
//  Created by Antony on 13-11-26.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SmartSDK.h"

@interface DAMenuProxy : NSObject


+ (void) getMenuListApiList;

+ (UIImage *)getImageFromDisk :(NSString *)name;
@end
