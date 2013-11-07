//
//  DAUserUpdatePosterTests.m
//  TribeSDK
//
//  Created by LI LIN on 2013/04/22.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAUserUpdatePosterTests.h"

@implementation DAUserUpdatePosterTests
{
    BOOL asynchronousLoginState;
    BOOL asynchronousUpdateState;
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


- (void)testUpload
{
    
    NSDictionary *name = [NSDictionary dictionaryWithObjectsAndKeys:@"非ノン語", @"name_zh", nil];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"51626d2c32db46000000002b", @"_id",
                         name, @"name", 
                         @"address@dreamarts.co.jp", @"email", 
                         @"12345678909", @"tel", 
                         @"5174d250c87cbf000000001d", @"fid", 
                         nil];
    
    [[DAUserUpdatePoster alloc] update:dic delegateObj:self];
    
    asynchronousUpdateState = NO;
    NSRunLoop *theRL = [NSRunLoop currentRunLoop];
    while (!asynchronousUpdateState && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    
    _prints(@"success upload");
}

- (void)didFinishUpdate
{
    asynchronousUpdateState = YES;
}

@end




//JSONString
//
//
//NSData *jsonData = [@"{\"a\":{\"b\":\"bbbbb\", \"c\":0}}" dataUsingEncoding:NSUnicodeStringEncoding];
//NSError *error;
//
//id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
//NSLog(@"jsonObj: %@", jsonObj);
//
//



