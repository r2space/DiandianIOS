//
//  DALoginModuleTests.m
//  TribeSDK
//
//  Created by LI LIN on 2013/04/14.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DALoginModuleTests.h"

@implementation DALoginModuleTests
{
    BOOL asynchronousState;
}


- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}


- (void)testLogin
{
    [[DALoginModule alloc] login:self name:@"l_li@dreamarts.co.jp" password:@"l_li"];

    // 等待非同期代码结束
    asynchronousState = NO;
    NSRunLoop *theRL = [NSRunLoop currentRunLoop];
    while (!asynchronousState && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);

    STAssertEquals(@"a", @"a", @"xxxxxxxxxxx");
    NSLog(@"lalalalala");
}


- (void)didFinishLogin:(DAUser *)user
{
    asynchronousState = YES;

    NSLog(@"sdfasdfasdfasdfasdfasdfa");
}

- (void)didFailLogin
{
    STFail(@"login失败");
}

@end
