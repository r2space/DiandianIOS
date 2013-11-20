//
//  DACommon.h
//  TribeSDK
//
//  Created by kita on 13-4-12.
//  Copyright (c) 2013年 dac. All rights reserved.
//


#import <UIKit/UIKit.h>


#ifndef smart_sdk_DACommon_h
#define smart_sdk_DACommon_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Thirdpartys
#import "AFNetworking.h"
#import "Jastor.h"

//
#import "DAMacros.h"
#import "DAJsonHelper.h"
#import "DARequestHelper.h"

#endif

@interface DACommon : NSObject
+(NSString *)getCatchedImagePath:(NSString *)fileId;
+(BOOL) isImageCatched:(NSString *)fileId;
+(UIImage *) getCatchedImage:(NSString *)fileId;
+(UIImage *) getCatchedImage:(NSString *)fileId defaultImage:(UIImage *)defaultImg;
+ (NSString *) dataToFile:(NSData *)data fileName:(NSString *)fileName;

+ (NSString *) getServerHost; // Ex. 10.2.3.199
+ (NSString *) getServerAddress; // Ex. http://10.2.3.199
+ (NSString *) getServerAddress:(BOOL)isSecure; // Ex. https://10.2.3.199:3000
@end
