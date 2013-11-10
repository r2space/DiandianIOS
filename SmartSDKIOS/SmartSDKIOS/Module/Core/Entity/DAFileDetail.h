//
//  DAFileDetail.h
//  TribeSDK
//
//  Created by mac on 13-5-6.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//
#import "Jastor.h"
#import "DAFile.h"
#import "DAUser.h"

@interface DAFileDetail : Jastor


@property (retain, nonatomic) DAFile * file;
@property (retain, nonatomic) DAUser * user;
@end
