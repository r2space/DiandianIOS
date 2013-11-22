//
//  DASocketIO.m
//  DiandianIOS
//
//  Created by Antony on 13-11-21.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DASocketIO.h"

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
    [self connectToHost:@"10.2.3.201" onPort:3000];
}

-(void)sendEvent:(NSString *)event data:(NSObject *)data
{
    [self sendEvent:event withData:data];
}

@end
