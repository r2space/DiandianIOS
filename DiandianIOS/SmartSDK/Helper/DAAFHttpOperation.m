//
//  DAAFHttpOperation.m
//  TribeSDK
//
//  Created by LI LIN on 2013/05/16.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAAFHttpOperation.h"
#import "DAMacros.h"
#import "DACommon.h"

@implementation DAAFHttpOperation

+ (NSSet *)acceptableContentTypes
{
    
    return [NSSet setWithObjects:@"image/tiff", @"image/jpeg", @"image/gif", @"image/png", @"image/ico", @"image/bmp", @"application/zip", nil];
}

- (id)initWithRequestPath:(NSString *)path
{
    NSString *url = [NSString stringWithFormat:@"%@%@", [DACommon getServerAddress], path];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    return [self initWithRequest:request];
}

@end
