//
//  DARequestHelper.h
//  TribeSDK
//
//  Created by 李 林 on 2012/12/05.
//  Copyright (c) 2012年 dac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DARequestHelper : NSObject

+ (NSMutableURLRequest *) httpRequest:(NSString *)api method:(NSString *)method;
+ (NSString*)uriEncodeForString:(NSString *)string;
+ (NSMutableURLRequest *) httpFileRequest:(NSString *)api image:(UIImage *)image;

@end
