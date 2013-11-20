//
//  DAAFHttpClient.h
//  TribeSDK
//
//  Created by LI LIN on 2013/05/03.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DACommon.h"

@interface DAAFHttpClient : AFHTTPClient

+ (DAAFHttpClient *)sharedClient;
@property(nonatomic) BOOL isReachable;
- (NSString*)uriEncodeForString:(NSString *)string;
-(void)setCookie :(NSString *)cookie;

@end
