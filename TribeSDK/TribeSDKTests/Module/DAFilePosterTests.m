//
//  DAFilePosterTests.m
//  TribeSDK
//
//  Created by LI LIN on 2013/04/21.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAFilePosterTests.h"

@implementation DAFilePosterTests
{
    BOOL asynchronousLoginState;
    BOOL asynchronousFileState;
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
    UIImage *image = [[UIImage alloc]initWithContentsOfFile:@"/Users/lilin/Desktop/test.png"];
    [[DAFilePoster alloc] upload:image delegateObj:self];
    
    asynchronousFileState = NO;
    NSRunLoop *theRL = [NSRunLoop currentRunLoop];
    while (!asynchronousFileState && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
    
    _prints(@"success upload");

}



- (void)didFinishUpload:(DAFile *)file
{
    asynchronousFileState = YES;
    _printf(@"----------------%@", file._id);
}

@end
