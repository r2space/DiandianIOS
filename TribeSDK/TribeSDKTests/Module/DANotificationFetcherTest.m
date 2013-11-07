//
//  DANotificationFetcherTest.m
//  TribeSDK
//
//  Created by mac on 13-4-25.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DANotificationFetcherTest.h"

@implementation DANotificationFetcherTest
{
    BOOL asynchronousLoginState;
    BOOL asynchronousNotificationState;
}

- (void)setUp
{
    [super setUp];
    [[DALoginModule alloc] login:self name:@"smart@dreamarts.co.jp" password:@"smart"];;
    
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


- (void)testGetList
{
  
    [[DANotificationListFetcher alloc] getNotificationList:0 count:10 type:@"at" withDelegate:self];
    asynchronousNotificationState = NO;
    NSRunLoop *theRL = [NSRunLoop currentRunLoop];
    while (!asynchronousNotificationState && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    
    NSLog(@"success");
    _prints(@"testGetList----------------");
    
}
-(void) didFinishFetchingNotificationList:(DANotificationList *)notificationList
{
    asynchronousNotificationState = YES;
    
    DANotificationList *g = notificationList;
    DANotification *obj = [notificationList.items objectAtIndex:0];
    _printf(@"\n\n\n\n\nname: %@ \n\n\n\n\n ", g.items);
    _printf(@"\n\n\n\n\ncontent: %@ \n\n\n\n\n ", obj.content);
}


@end
