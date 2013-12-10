//
//  DADispatch.h
//  DiandianIOS
//
//  Created by Antony on 13-11-25.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DADispatch : NSObject


+(void )dealWithAction:(NSString *)action data:(id)data;

+(void )dealBecomeActiveAction:(NSString *)action data:(id)data;

@end
