//
//  DAAFHttpOperation.h
//  TribeSDK
//
//  Created by LI LIN on 2013/05/16.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"

@interface DAAFHttpOperation : AFHTTPRequestOperation

- (id)initWithRequestPath:(NSString *)path;

@end
