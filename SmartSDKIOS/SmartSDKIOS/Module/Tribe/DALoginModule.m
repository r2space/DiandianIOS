//
//  DALoginModule.m
//  TribeSDK
//
//  Created by LI LIN on 2013/04/13.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DALoginModule.h"

#define kHTTPHeaderCookieName   @"Set-Cookie"
#define kHTTPHeaderCsrftoken    @"csrftoken"
#define kHTTPHeaderUserID       @"userid"
#define kURLLogin               @"simplelogin?name=%@&pass=%@"
#define kURLYiLogin               @"simplelogin?name=%@&pass=%@&code=%@"
#define kURLLogout              @"simplelogout?token=%@"

@implementation DALoginModule

+ (NSString *)getLoginUserId
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kHTTPUser];
}

// 登陆。block回调函数版。
- (void)yukarilogin:(NSString *)name
     password:(NSString *)password
        code :(NSString *)code
      callback:(void (^)(NSError *error, DAUser *user))callback
{
    NSString *path = [NSString stringWithFormat:kURLYiLogin, name, password,code];
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSDictionary *headers = [operation.response allHeaderFields];
        NSString *cookie = [headers objectForKey:kHTTPHeaderCookieName];
        NSString *csrftoken = [headers objectForKey:kHTTPHeaderCsrftoken];
        NSString *userid = [headers objectForKey:kHTTPHeaderUserID];
        
        // Login信息保存到UserDefautls里
        if (cookie != nil) {
            [[NSUserDefaults standardUserDefaults] setObject:cookie forKey:kHTTPCookie];
            //重置cookie
            [[DAAFHttpClient sharedClient] setCookie:cookie];
        }
        if (csrftoken != nil) {
            [[NSUserDefaults standardUserDefaults] setObject:csrftoken forKey:kHTTPCsrfToken];
        }
        if (userid != nil) {
            [[NSUserDefaults standardUserDefaults] setObject:userid forKey:kHTTPUser];
        }
        
        // 调用回调函数
        if (callback) {
            callback(nil, [[DAUser alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        if (callback) {
            callback(error, nil);
        }
    }];
}

- (void)login:(NSString *)name
     password:(NSString *)password
     callback:(void (^)(NSError *error, DAUser *user))callback
{
    NSString *path = [NSString stringWithFormat:kURLLogin, name, password];
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSDictionary *headers = [operation.response allHeaderFields];
        NSString *cookie = [headers objectForKey:kHTTPHeaderCookieName];
        NSString *csrftoken = [headers objectForKey:kHTTPHeaderCsrftoken];
        NSString *userid = [headers objectForKey:kHTTPHeaderUserID];
        
        // Login信息保存到UserDefautls里
        if (cookie != nil) {
            [[NSUserDefaults standardUserDefaults] setObject:cookie forKey:kHTTPCookie];
            //重置cookie
            [[DAAFHttpClient sharedClient] setCookie:cookie];
        }
        if (csrftoken != nil) {
            [[NSUserDefaults standardUserDefaults] setObject:csrftoken forKey:kHTTPCsrfToken];
        }
        if (userid != nil) {
            [[NSUserDefaults standardUserDefaults] setObject:userid forKey:kHTTPUser];
        }
        
        // 调用回调函数
        if (callback) {
            callback(nil, [[DAUser alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        if (callback) {
            callback(error, nil);
        }
    }];
}

// 登陆。SEL回调函数版。
- (void)login:(NSString *)name
     password:(NSString *)password
       target:(id)target
      success:(SEL)success
      failure:(SEL)failure
{
    NSString *path = [NSString stringWithFormat:kURLLogin, name, password];
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSDictionary *headers = [operation.response allHeaderFields];
        NSString *cookie = [headers objectForKey:kHTTPHeaderCookieName];
        NSString *csrftoken = [headers objectForKey:kHTTPHeaderCsrftoken];
        NSString *userid = [headers objectForKey:kHTTPHeaderUserID];
        
        // Login信息保存到UserDefautls里
        if (cookie != nil) {
            [[NSUserDefaults standardUserDefaults] setObject:cookie forKey:kHTTPCookie];
        }
        if (csrftoken != nil) {
            [[NSUserDefaults standardUserDefaults] setObject:csrftoken forKey:kHTTPCsrfToken];
        }
        if (userid != nil) {
            [[NSUserDefaults standardUserDefaults] setObject:userid forKey:kHTTPUser];
        }
        
        // 调用回调函数
        if (success) {
            DAUser *user = [[DAUser alloc] initWithDictionary:[responseObject valueForKeyPath:@"data"]];
            
            NSInvocation *invoker =  [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:success]];
            [invoker setTarget:target];
            [invoker setSelector:success];
            [invoker setArgument:&user atIndex:2];
            [invoker invoke];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        if (failure) {
            NSInvocation *invoker =  [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:failure]];
            [invoker setTarget:target];
            [invoker setSelector:failure];
            [invoker setArgument:&error atIndex:2];
            [invoker invoke];
        }
    }];
}

// 注销
- (void)logout:(NSString *)token  callback:(void (^)(NSError *error))callback
{
    NSString *path = [NSString stringWithFormat:kURLLogout, token];    
    [[DAAFHttpClient sharedClient] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        // 删除UserDefautls信息
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kHTTPCookie];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kHTTPCsrfToken];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kHTTPUser];
        
        // 调用回调函数
        if (callback) {
            callback(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        if (callback) {
            callback(error);
        }
    }];
}


@end
