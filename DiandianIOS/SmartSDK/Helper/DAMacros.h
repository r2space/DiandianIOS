//
//  DAMacros.h
//  TribeSDK
//
//  Created by 李 林 on 2012/12/05.
//  Copyright (c) 2012年 dac. All rights reserved.
//

#ifndef smart_message_DAMacros_h
#define smart_message_DAMacros_h

#define kServerAddress      @"jp.co.dreamarts.smart.sdk.server.address"
#define kServerPort         @"jp.co.dreamarts.smart.sdk.server.port"
#define kHTTPCookie         @"jp.co.dreamarts.smart.sdk.cookie"
#define kHTTPCsrfToken      @"jp.co.dreamarts.smart.sdk.csrftoken"
#define kHTTPUser           @"jp.co.dreamarts.smart.sdk.userid"

#define kNoticeNotReachable @"jp.co.dreamarts.smart.sdk.NoticeNotReachable"

// ログ関連
//////////////////////////////////////////////////////////////////////////////////////
#define _printd(data) \
    NSLog(@"### [%@:(%d):%p] %@", \
    [[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
    __LINE__, \
    self, \
    [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding])
#define _prints(str) \
    NSLog(@"### [%@:(%d):%p] %@", \
    [[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
    __LINE__, \
    self, \
    str)
#define _printf(str, ...) \
    NSLog(@"### [%@:(%d):%p] %@", \
    [[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
    __LINE__, \
    self, \
    [NSString stringWithFormat:(str), ##__VA_ARGS__])

// 色関連
//////////////////////////////////////////////////////////////////////////////////////
#define RGB(r, g, b) \
    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) \
    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]


#endif
