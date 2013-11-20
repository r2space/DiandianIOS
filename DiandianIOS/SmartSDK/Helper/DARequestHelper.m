//
//  DARequestHelper.m
//  TribeSDK
//
//  Created by 李 林 on 2012/12/05.
//  Copyright (c) 2012年 dac. All rights reserved.
//

#import "DARequestHelper.h"
#import <UIKit/UIKit.h>

#define kHost               @"http://10.2.3.199:3000"
#define kBoundary           @"_boundary_jp_co_dreamarts_"

@implementation DARequestHelper

+ (NSMutableURLRequest *) httpRequest:(NSString *)api method:(NSString *)method
{
    // To create Request the URL
    NSString *urlString = nil;
    
    // Add csrftoken
    if ([@"GET" isEqualToString:method]) {
        urlString = [NSString stringWithFormat:@"%@%@", kHost, api];
    } else {
        
        NSString *csrftoken = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.sdk.csrftoken"];
        NSString *spliter = [api rangeOfString:@"?"].location == NSNotFound ? @"?" : @"&";
        urlString = [NSString stringWithFormat:@"%@%@%@_csrf=%@", kHost, api, spliter, [DARequestHelper uriEncodeForString:csrftoken]];
    }
    NSURL *url = [NSURL URLWithString:urlString];
    
    // Add Header
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:method];
    if ([@"GET" isEqualToString:method]) {
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    } else {
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    // Set cookie
    NSString *cookie = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.sdk.cookie"];
    [request setValue:cookie forHTTPHeaderField:@"cookie"];
    
    return request;
}

// POST File
+ (NSMutableURLRequest *)httpFileRequest:(NSString *)api image:(UIImage *)image
{
    // URLRequest
    NSString *csrftoken = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.sdk.csrftoken"];
    NSString *urlString = [NSString stringWithFormat:@"%@%@?_csrf=%@", kHost, api, [DARequestHelper uriEncodeForString:csrftoken]];

    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // HttpBody
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    NSMutableData *contents = [[NSMutableData alloc] init];
    
    [contents appendData:[[NSString stringWithFormat:@"--%@\r\n", kBoundary]
                          dataUsingEncoding:NSUTF8StringEncoding]];
    [contents appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"files\"; filename=\"%@\"\r\n", @"picture.jpg"]
                          dataUsingEncoding:NSUTF8StringEncoding]];
    [contents appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [contents appendData:imageData];
    [contents appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [contents appendData:[[NSString stringWithFormat:@"--%@--\r\n\r\n", kBoundary]
                          dataUsingEncoding:NSUTF8StringEncoding]];

    // Header info
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", kBoundary];
    NSString *contentLength = [NSString stringWithFormat:@"%lu", (unsigned long)contents.length];
    NSString *cookie = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.sdk.cookie"];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:contents];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:contentLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    
    return request;
}


// テキストをエスケープする
+ (NSString*)uriEncodeForString:(NSString *)string {
    return (__bridge_transfer NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                (__bridge CFStringRef)string,
                                                                                NULL,
                                                                                (CFStringRef)@"!*'();:@&=+$,./?%#[]",
                                                                                kCFStringEncodingUTF8);
}


@end
