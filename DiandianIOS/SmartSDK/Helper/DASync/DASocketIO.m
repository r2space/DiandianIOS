//
//  DASocketIO.m
//  DiandianIOS
//
//  Created by Antony on 13-11-21.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DASocketIO.h"
#define kInfoPlistKeyServerAddress  @"ServerAddress"
#define kInfoPlistKeyServerPort     @"ServerPort"
#define kServerAddress      @"jp.co.dreamarts.smart.sdk.server.address"
#define kServerPort         @"jp.co.dreamarts.smart.sdk.server.port"

@implementation DASocketIO


// Singletons
+ (DASocketIO *)sharedClient:(id<SocketIODelegate>)delegate{
    
    static DASocketIO *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[DASocketIO alloc] initWithDelegate:delegate];
        
    });
    
    return _sharedClient;
}

-(void)conn
{
    NSString *address = [[NSUserDefaults standardUserDefaults] objectForKey:kServerAddress];
    NSInteger port = [[NSUserDefaults standardUserDefaults] integerForKey:kServerPort];
//    NSString *address = @"10.2.3.237";
//    NSInteger port = 3000;
    [self connectToHost:address onPort:port];
}

-(void)sendJSONwithAction:(NSString *)action  data:(NSDictionary *)data
{
    NSMutableDictionary *tmpDic = [[NSMutableDictionary alloc] init];
    [tmpDic setObject:action forKey:@"action"];
    [tmpDic setObject:data forKey:@"data"];
    [self sendEvent:@"message" withData:tmpDic];
    
}

@end
