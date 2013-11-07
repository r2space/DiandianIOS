//
//  DAWebAccess.h
//  tribe
//
//  Created by kita on 13-4-11.
//  Copyright (c) 2013年 dac. All rights reserved.
//


#import "DACommon.h"
#import "DAError.h"

@protocol DAWebAccessProtocol

// 通信に成功した際に呼ばれる
- (void)didFinishLoading:(NSData *)data;

// 通信に失敗した際に呼ばれる
- (void)didFailLoading:(NSError *)error;

@end

@interface DAWebAccess : NSObject <DAWebAccessProtocol>
@property (strong, nonatomic) id delegate;

@property (retain, nonatomic) NSString *csrftoken;
@property (retain, nonatomic) NSString *userid;
@property (retain, nonatomic) NSString *cookie;

- (void)sendRequest:(NSURLRequest *)request;
- (void)sendPostRequest:(NSURLRequest *)request withPostData:(NSDictionary *)postData;

@end
