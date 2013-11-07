//
//  DASortmailUserFetcherTests.m
//  TribeSDK
//
//  Created by LI LIN on 2013/04/26.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAShortmailUserFetcherTests.h"

@implementation DAShortmailUserFetcherTests
{
    BOOL asynchronousLoginState;
    BOOL asynchronousShrotmailState;
}


- (void)setUp
{
    [super setUp];
    
    [[DALoginModule alloc] login:self name:@"l_li@dreamarts.co.jp" password:@"l_li"];
    
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


- (void)testGetSortmailUsers
{
    
    [[DAShortmailUserFetcher alloc] getSortmailUsers:0 count:20 withDelegate:self];
    
    // 等待非同期代码结束
    asynchronousShrotmailState = NO;
    NSRunLoop *theRL = [NSRunLoop currentRunLoop];
    while (!asynchronousShrotmailState && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    
    NSLog(@"lalala");
}

- (void)didFinishFetchingShortmailUser:(DAUserList *)users
{
    asynchronousShrotmailState = YES;
    _printf(@"name: %d", users.items.count);
}

@end
