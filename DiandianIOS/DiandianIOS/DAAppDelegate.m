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
    NSTimer         *daemonIO;         // 定时检查socketio连接情况，在需要的时候重新连接
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [DASettings registerDefaultsFromSettingsBundle];
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kServerAddress] == nil) {
        NSString *serverAddress = [[NSBundle mainBundle] objectForInfoDictionaryKey:kInfoPlistKeyServerAddress];
        NSNumber *serverPort = [[NSBundle mainBundle] objectForInfoDictionaryKey:kInfoPlistKeyServerPort];
        [[NSUserDefaults standardUserDefaults] setObject:serverAddress forKey:kServerAddress];
        [[NSUserDefaults standardUserDefaults] setInteger:serverPort.integerValue forKey:kServerPort];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openIOSocket:) name:@"ioSocketOpen" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeIOSocket:) name:@"ioSocketClose" object:nil];
    
    
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    

    
    // 消息推送注册
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge];
    return YES;
}

-(void) openIOSocket : (NSNotification*) notification
{
    [[DASocketIO sharedClient:self] conn];
    [self initDaemon];
}

-(void) closeIOSocket : (NSNotification*) notification
{
    NSLog(@"=====socket io disconnecting======");
    [[DASocketIO sharedClient:self] disconnectForced];
    [self distoryDaemon];
}

// 获取终端设备标识，这个标识需要通过接口发送到服务器端，服务器端推送消息到APNS时需要知道终端的标识，APNS通过注册的终端标识找到终端设备。
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"jp.co.dreamarts.smart.message.devicetoken"];
    NSLog(@"device token is:%@", token);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSString *error_str = [NSString stringWithFormat: @"%@", error];
    NSLog(@"Failed to get token, error:%@", error_str);
}


// 处理收到的消息推送
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    if (UIApplicationStateInactive == application.applicationState) {
        
        // 由用户点击通知的消息，而启动时
        NSLog(@"2. Receive remote notification : %@", userInfo);
        NSDictionary *aps = [userInfo objectForKey:@"aps"];
        NSDictionary *alert = [aps objectForKey:@"alert"];
        NSString *action = [alert objectForKey:@"action"];
        NSString *data = [aps objectForKey:@"data"];
        
        [DADispatch dealBecomeActiveAction:action data:data];

        return;
    }
    
    if (UIApplicationStateActive == application.applicationState) {
        
        // 应用程序正在运行时，接受消息
        NSLog(@"3. Receive remote notification : %@", userInfo);
        return;
    }
    
    NSLog(@"1. Receive remote notification : %@", userInfo);
}


-(void)initDaemon
{
    // 创建定时器
    daemonIO = [NSTimer scheduledTimerWithTimeInterval:3
                                             target:self
                                           selector:@selector(daemonEvent:)
                                           userInfo:nil
                                            repeats:YES];
    // 启动定时器
    [daemonIO fire];
    NSLog(@"====timer start====");
}

-(void)distoryDaemon
{
    [daemonIO invalidate];
    daemonIO = nil;
    NSLog(@"====timer stop====");
}

- (void)daemonEvent:(NSTimer *)timer
{
    //NSLog(@"====timer tick====");
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
    NSLog(@"socket error : %@", error);
}


- (void) socketIODidDisconnect:(SocketIO *)socket disconnectedWithError:(NSError *)error
{
    if(error == nil){
        NSLog(@"socket disconnected");
    }else{
        NSLog(@"socket disconnected with error : %@", error);
    }
}

# pragma mark -

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

void uncaughtExceptionHandler(NSException *exception) {
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
    // Internal error reporting
}

@end
