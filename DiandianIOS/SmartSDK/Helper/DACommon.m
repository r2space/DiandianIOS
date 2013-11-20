//
//  DACommon.m
//  TribeSDK
//
//  Created by kita on 13-4-12.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DACommon.h"
#import "DAMacros.h"

@implementation DACommon
+(NSString *)getCatchedImagePath:(NSString *)fileId
{
    if (fileId == nil) {
        return nil;
    }
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [NSString stringWithFormat:@"%@/%@", [path objectAtIndex:0], fileId];
}

+(BOOL)isImageCatched:(NSString *)fileId
{
    BOOL isDir;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExists = ([fileManager fileExistsAtPath:[DACommon getCatchedImagePath:fileId] isDirectory:&isDir] && !isDir);
    return fileExists;
}

+(UIImage *)getCatchedImage:(NSString *)fileId
{
    if (![DACommon isImageCatched:fileId]) {
        return nil;
    }
    NSString *file = [DACommon getCatchedImagePath:fileId];
    return [UIImage imageWithContentsOfFile:file];
}

+(UIImage *)getCatchedImage:(NSString *)fileId defaultImage:(UIImage *)defaultImg
{
    UIImage* img = [DACommon getCatchedImage:fileId];
    if (img == nil) {
        return defaultImg;
    }
    return img;
}

/**
 * 
 */
+ (NSString *) dataToFile:(NSData *)data fileName:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentDir = [paths objectAtIndex:0];
    
    NSString* file = [NSString stringWithFormat:@"%@/%@", documentDir, fileName];
    [data writeToFile:file atomically:YES];
    
    return file;
}

+ (NSString *) getServerAddress
{
    return [DACommon getServerAddress:NO];
}

+ (NSString *) getServerHost
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kServerAddress];
}

+ (NSString *) getServerAddress:(BOOL)isSecure
{
    NSString *protocal = isSecure ? @"https" : @"http";
    NSString *address = [[NSUserDefaults standardUserDefaults] objectForKey:kServerAddress];
    NSInteger port = [[NSUserDefaults standardUserDefaults] integerForKey:kServerPort];
    
    NSString *url = [NSString stringWithFormat:@"%@://%@", protocal, address];
    if (port == 80) {
        return url;
    } else {
        return [url stringByAppendingFormat:@":%d", (int)port];
    }
}

@end
