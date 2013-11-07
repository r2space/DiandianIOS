//
//  DAContact.h
//  TribeSDK
//
//  Created by LI LIN on 2013/06/12.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "Jastor.h"
#import "DAUser.h"

@interface DAContactPhoto : Jastor

@property (retain, nonatomic) NSString *small;
@property (retain, nonatomic) NSString *middle;
@property (retain, nonatomic) NSString *big;

@end

@interface DAContact : Jastor

@property (retain, nonatomic) NSString *id;
@property (retain, nonatomic) NSString *_id;
@property (retain, nonatomic) NSString *title;
@property (retain, nonatomic) NSArray *member;
@property (retain, nonatomic) DAContactPhoto *photo;
@property (retain, nonatomic) NSString *lastMessage;
@property (retain, nonatomic) NSString *createby;
@property (retain, nonatomic) NSString *createat;
@property (retain, nonatomic) NSString *editby;
@property (retain, nonatomic) NSString *editat;
@property (retain, nonatomic) DAUser *user;

@end
