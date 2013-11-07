//
//  DAGroupFetcherTests.m
//  TribeSDK
//
//  Created by LI LIN on 2013/04/17.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAGroupFetcherTests.h"

@implementation DAGroupFetcherTests
{
    BOOL asynchronousLoginState;
    BOOL asynchronousGroupState;
}


- (void)setUp
{
    [super setUp];
    
    [[DALoginModule alloc] login:self name:@"l_li@dreamarts.co.jp" password:@"l_li"];;
    
    asynchronousLoginState = NO;
    NSRunLoop *theRL = [NSRunLoop currentRunLoop];
    while (!asynchronousLoginState && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
}


- (void)didFinishLogin:(DAUser *)user
{
    asynchronousLoginState = YES;
}


- (void)didFailLogin
{
    asynchronousLoginState = YES;
}


- (void)testGetGroupById
{
    [[DAGroupFetcher alloc] getGroupById:self gid:@"51626d2b32db460000000001"];
    
    asynchronousGroupState = NO;
    NSRunLoop *theRL = [NSRunLoop currentRunLoop];
    while (!asynchronousGroupState && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    
    NSLog(@"success");
}

- (void) didFinishFetchingGroup:(DAGroup *)group
{
    asynchronousGroupState = YES;
    NSLog(@"group : %@", group);
}


@end
