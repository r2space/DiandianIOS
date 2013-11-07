//
//  DAYiWorkstationModule.h
//  TribeSDK
//
//  Created by Antony on 13-9-18.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAAFHttpClient.h"
#import "DAYiWorkStationMenu.h"
#import "DAYiWorkStation.h"

@interface DAYiWorkstationModule : NSObject

-(void)getWorkstationList:(void (^)(NSError *, DAYiWorkStation *))callback;

@end
