//
//  DANotice.h
//  TribeSDK
//
//  Created by LI LIN on 2013/09/05.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import <TribeSDK/TribeSDK.h>
#import "DAUser.h"
#import "Jastor.h"

@interface DAYiNotice : Jastor

@property (retain, nonatomic) NSString *_id;
@property (retain, nonatomic) NSString *title;
@property (retain, nonatomic) NSArray *touser;
@property (retain, nonatomic) NSArray *togroup;
@property (retain, nonatomic) NSString *notice;

@property (retain, nonatomic) NSString *createat;
@property (retain, nonatomic) NSString *createby;
@property (retain, nonatomic) DAUser    *user;

@end

@interface DAYiNoticeList : Jastor
@property (retain, nonatomic) NSArray *items;
@end
