//
//  DAAppDelegate.h
//  MenuBook
//
//  Created by Antony on 13-11-4.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DASocketIO.h"


@interface DAAppDelegate : UIResponder <UIApplicationDelegate,SocketIODelegate>

@property (strong, nonatomic) UIWindow *window;



@end
