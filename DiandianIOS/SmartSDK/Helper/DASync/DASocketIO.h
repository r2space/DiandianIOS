//
//  DASocketIO.h
//  DiandianIOS
//
//  Created by Antony on 13-11-21.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "SocketIO.h"

@interface DASocketIO : SocketIO<SocketIODelegate>

+ (DASocketIO *)sharedClient:(id<SocketIODelegate>)delegate;
-(void)conn;


-(void)sendEvent:(NSString *)event data:(NSObject *)data;
@end
