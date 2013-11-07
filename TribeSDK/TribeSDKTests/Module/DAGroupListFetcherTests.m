//
//  DAGroupListFetcherTests.m
//  TribeSDK
//
//  Created by LI LIN on 2013/04/16.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAGroupListFetcherTests.h"

@implementation DAGroupListFetcherTests
{
    BOOL asynchronousLoginState;
    BOOL asynchronousGroupState;
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


- (void)testGetGroupListWithDelegate
{
    
    [[DAGroupListFetcher alloc] getGroupListWithDelegate:self];
    
    // 等待非同期代码结束
    asynchronousGroupState = NO;
    NSRunLoop *theRL = [NSRunLoop currentRunLoop];
    while (!asynchronousGroupState && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);

    NSLog(@"adsfadfasdf");
}

- (void)didFinishFetchingGroupList:(DAGroupList *)groupList
{
    asynchronousGroupState = YES;
    
    DAGroup *g = [groupList.items objectAtIndex:1];
    _printf(@"name: %@", g.photo.small);
}

@end
