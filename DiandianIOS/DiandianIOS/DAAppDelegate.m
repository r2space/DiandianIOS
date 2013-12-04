//
//  DAAppDelegate.m
//  MenuBook
//
//  Created by Antony on 13-11-4.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAAppDelegate.h"
#import "DASettings.h"
#import "DACommon.h"
#import "SmartSDK.h"
#import "SocketIOPacket.h"
#import "SocketIOJSONSerialization.h"

#import "DADispatch.h"




#define kInfoPlistKeyServerAddress  @"ServerAddress"
#define kInfoPlistKeyServerPort     @"ServerPort"


@implementation DAAppDelegate
{
    NSTimer         *daemonIO;         // 涮新用计时器
    BOOL            puaseTimer;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [DASettings registerDefaultsFromSettingsBundle];
    
    NSString *s = [[NSUserDefaults standardUserDefaults] objectForKey:kServerAddress];
    NSLog(@"%@",s);
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kServerAddress] == nil) {
        NSString *serverAddress = [[NSBundle mainBundle] objectForInfoDictionaryKey:kInfoPlistKeyServerAddress];
        NSNumber *serverPort = [[NSBundle mainBundle] objectForInfoDictionaryKey:kInfoPlistKeyServerPort];
        NSLog(@"kServerAddress  : %@  conn   host %@  port  %@" ,kServerAddress,serverAddress ,serverPort);
        [[NSUserDefaults standardUserDefaults] setObject:serverAddress forKey:kServerAddress];
        [[NSUserDefaults standardUserDefaults] setInteger:serverPort.integerValue forKey:kServerPort];
    }
    NSString *_username = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.diandian.username"];
    
    NSString *_password = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.diandian.password"];
    
    [[NSUserDefaults standardUserDefaults]  setObject:@"NO" forKey:@"jp.co.dreamarts.smart.diandian.isLogin"];

    
    if (_username.length == 0 || _password.length == 0) {
 
    } else {
        [[DALoginModule alloc]yukarilogin:_username password:_password code:nil callback:^(NSError *error, DAUser *user) {
            NSLog(@"login success  user %@",user);
            [[NSUserDefaults standardUserDefaults]  setObject:@"YES" forKey:@"jp.co.dreamarts.smart.diandian.isLogin"];
            [[NSUserDefaults standardUserDefaults] setValue:user._id forKey:@"jp.co.dreamarts.smart.diandian.userId"];
        }];
    }
    
    
    
    
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    
    [[DASocketIO sharedClient:self] conn];
    [self initDaemon];
    return YES;
}

-(void)initDaemon
{
    // 创建定时器
    puaseTimer = NO;
    daemonIO = [NSTimer scheduledTimerWithTimeInterval:0.5
                                             target:self
                                           selector:@selector(daemonEvent:)
                                           userInfo:nil
                                            repeats:YES];
    // 启动定时器
    [daemonIO fire];
}

- (void)daemonEvent:(NSTimer *)timer
{
    if ([[DASocketIO sharedClient:self] isConnected]) {
        return;
    }
    
    NSLog(@"DASocketIO restart "  );
    [[DASocketIO sharedClient:self] conn];
    
}


# pragma mark -
# pragma mark socket.IO-objc delegate methods

- (void) socketIODidConnect:(SocketIO *)socket
{
    NSLog(@"socket.io connected.");
}

- (void) socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{
    @try {
        NSDictionary *dic = [packet dataAsJSON];
        NSArray *args = [dic objectForKey:@"args"];
        for (NSDictionary *argDic in args) {
            
            NSString *action = [argDic objectForKey:@"action"];
            id data = [argDic objectForKey:@"data"];
            [DADispatch dealWithAction:action data:data];
            
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }

    
}

- (void) socketIO:(SocketIO *)socket onError:(NSError *)error
{
    NSLog(@"\n\n\n\n\n\n  onError() %@", error);
}


- (void) socketIODidDisconnect:(SocketIO *)socket disconnectedWithError:(NSError *)error
{
    NSLog(@"\n\n\n\n\n\n   socket.io disconnected. did error occur? %@", error);
    if (![[DASocketIO sharedClient:self]  isConnected]) {
        [[DASocketIO sharedClient:self] conn];
    }
    
}

# pragma mark -

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSLog(@"后台 applicationWillResignActive");
    if (![[DASocketIO sharedClient:self] isConnected]) {
        [[DASocketIO sharedClient:self] conn];
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"后台 applicationDidEnterBackground");
    if (![[DASocketIO sharedClient:self] isConnected]) {
        [[DASocketIO sharedClient:self] conn];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSLog(@"后台 applicationWillEnterForeground");
    if (![[DASocketIO sharedClient:self] isConnected]) {
        [[DASocketIO sharedClient:self] conn];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"后台 applicationDidBecomeActive");
    if (![[DASocketIO sharedClient:self] isConnected]) {
        [[DASocketIO sharedClient:self] conn];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"后台 applicationWillTerminate");
    if (![[DASocketIO sharedClient:self] isConnected]) {
        [[DASocketIO sharedClient:self] conn];
    }
}

void uncaughtExceptionHandler(NSException *exception) {
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
    // Internal error reporting
}

@end
