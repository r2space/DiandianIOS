//
//  DAError.h
//  TribeSDK
//
//  Created by LI LIN on 2013/04/16.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "Jastor.h"

@interface DAError : Jastor

@property (retain, nonatomic) NSString *code;
@property (retain, nonatomic) NSString *message;

@end
