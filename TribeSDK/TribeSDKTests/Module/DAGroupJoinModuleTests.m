//
//  DAGroupJoinModuleTests.m
//  TribeSDK
//
//  Created by LI LIN on 2013/04/17.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAGroupJoinModuleTests.h"

@implementation DAGroupJoinModuleTests
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


- (void)testJoin
{
    [[DAGroupJoinModule alloc] join:self gid:@"516d1e3870e8e71cf500000b" uid:@"51626d2c32db46000000002b"];
    
    asynchronousGroupState = NO;
    NSRunLoop *theRL = [NSRunLoop currentRunLoop];
    while (!asynchronousGroupState && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    
    NSLog(@"success1");
}

- (void)didFinishJoin:(DAGroup *)group
{
    asynchronousGroupState = YES;
    NSLog(@"group : %@", group);
}

@end
