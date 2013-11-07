//
//  DAWebAccess.m
//  tribe
//
//  Created by kita on 13-4-11.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DAWebAccess.h"

@implementation DAWebAccess
- (void)sendRequest:(NSURLRequest *)request
{
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    [fetcher beginFetchWithDelegate:self didFinishSelector:@selector(didFinishLoading:finishedWithData:error:)];
}

- (void)sendPostRequest:(NSURLRequest *)request withPostData:(NSDictionary *)postData
{
    // fetch実行
    GTMHTTPFetcher *fetcher = [GTMHTTPFetcher fetcherWithRequest:request];
    
    NSDictionary *dic = postData == nil ? [NSDictionary dictionaryWithObject:@"" forKey:@""] : postData;
    
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&error];
    [fetcher setPostData:data];
    [fetcher beginFetchWithDelegate:self didFinishSelector:@selector(didFinishLoading:finishedWithData:error:)];
}

- (void)didFinishLoading:(GTMHTTPFetcher*)fetcher finishedWithData:(NSData*)data error:(NSError*)error
{
    if (fetcher.statusCode != 200) {

        // 尝试解析错误内容，如果不是Web服务器返回的错误，可以解析成json格式。
        NSError *jsonError = nil;
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        
        // 从JSON里提取错误信息，生成错误对象
        NSDictionary *errInfo = (jsonError == nil) ? [DAJsonHelper objectAtPath:result path:@"error"] : nil;
        NSError *err = [[NSError alloc] initWithDomain:@"DATribeSDKErrorDomain" code:fetcher.statusCode userInfo:errInfo];
        
        _printf(@"error code : %d", fetcher.statusCode);
        [self didFailLoading:err]; return;
    }

    // Save the cookie and csrf token
    self.csrftoken = [[fetcher responseHeaders] objectForKey:@"csrftoken"];
    self.cookie = [[fetcher responseHeaders] objectForKey:@"Set-Cookie"];
    self.userid = [[fetcher responseHeaders] objectForKey:@"userid"];

    NSLog(@"cookie: %@, csrf : %@, userid : %@", self.cookie, self.csrftoken, self.userid);
    
    // 正常処理
    [self didFinishLoading:data];
}

// abstract methods
- (void)didFinishLoading:(NSData *)data {}
- (void)didFailLoading:(NSError *)error {}

@end
