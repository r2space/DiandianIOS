//
//  DAAFHttpClient.m
//  TribeSDK
//
//  Created by LI LIN on 2013/05/03.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAAFHttpClient.h"
#import "DACommon.h"
#import "Reachability.h"

@implementation DAAFHttpClient

// Singletons
+ (DAAFHttpClient *)sharedClient {
    
    static DAAFHttpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[DAAFHttpClient alloc] initWithBaseURL:[NSURL URLWithString:[DACommon getServerAddress]]];
        
        // 设定当前网络状态
        _sharedClient.isReachable = [Reachability reachabilityWithHostname:[DACommon getServerHost]].isReachable;
        
        // 监控网络状态
        [_sharedClient setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
            NSLog(@"network status : %d", status);
            
            _sharedClient.isReachable = (status != AFNetworkReachabilityStatusNotReachable);
            if (_sharedClient.isReachable) {
                [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kNoticeNotReachable object:nil]];
            }
        }];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    NSString *cookie = [[NSUserDefaults standardUserDefaults] objectForKey:kHTTPCookie];
    [self setDefaultHeader:@"cookie" value:cookie];
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    
    // TODO: HTTPS对应
    //if ([[url scheme] isEqualToString:@"https"] && [[url host] isEqualToString:@"dreamarts.co.jp"]) {
    //    [self setDefaultSSLPinningMode:AFSSLPinningModePublicKey];
    //}
    
    return self;
}
-(void)setCookie :(NSString *)cookie
{
    [self setDefaultHeader:@"cookie" value:cookie];
}
- (void)getPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    [self setDefaultHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    [super getPath:path parameters:parameters success:success failure:failure];
}

- (void)postPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    self.parameterEncoding = AFJSONParameterEncoding;
    [super postPath:[self appendCsrf:path] parameters:parameters success:success failure:failure];
}

- (void)putPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    self.parameterEncoding = AFJSONParameterEncoding;
    [super putPath:[self appendCsrf:path] parameters:parameters success:success failure:failure];
}

- (void)deletePath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    [super deletePath:[self appendCsrf:path] parameters:parameters success:success failure:failure];
}

- (NSMutableURLRequest *)multipartFormRequestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block
{
    NSString *csrfPath = [self appendCsrf:path];
    return [super multipartFormRequestWithMethod:method path:csrfPath parameters:parameters constructingBodyWithBlock:block];
}

- (NSString *)appendCsrf:(NSString *)path
{
    NSString *csrftoken = [[NSUserDefaults standardUserDefaults] objectForKey:kHTTPCsrfToken];
    NSString *spliter = [path rangeOfString:@"?"].location == NSNotFound ? @"?" : @"&";
    
    return [NSString stringWithFormat:@"%@%@_csrf=%@", path, spliter, [DARequestHelper uriEncodeForString:csrftoken]];
}

- (NSString*)uriEncodeForString:(NSString *)string
{
    return (__bridge_transfer NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                (__bridge CFStringRef)string,
                                                                                NULL,
                                                                                (CFStringRef)@"!*'();:@&=+$,./?%#[]",
                                                                                kCFStringEncodingUTF8);
}

@end
