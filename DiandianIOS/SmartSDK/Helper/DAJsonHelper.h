//
//  DAJsonHelper.h
//  TribeSDK
//
//  Created by 李 林 on 2012/12/05.
//  Copyright (c) 2012年 dac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAJsonHelper : NSObject

+ (NSDictionary *) decode:(NSData *) json;

+ (id) objectAtPath:(id)json path:(NSString *)path;
+ (BOOL) isNumeric:(NSString *)string;

@end
