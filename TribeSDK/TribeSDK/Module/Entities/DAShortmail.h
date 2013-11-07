//
//  DAShortmail.h
//  TribeSDK
//
//  Created by LI LIN on 2013/04/26.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "Jastor.h"

@interface ShortmailAttach : Jastor
@property (retain, nonatomic) NSString *name;
@property (retain, nonatomic) NSString *path;
@end

@interface DAShortmail : Jastor
@property (retain, nonatomic) NSString *id;
@property (retain, nonatomic) NSString *_id;
@property (retain, nonatomic) NSString *contact;
@property (retain, nonatomic) NSString *message;
@property (retain, nonatomic) NSString *read;
@property (retain, nonatomic) NSString *to;
@property (retain, nonatomic) NSArray *attach;
@property (retain, nonatomic) NSString *createby;
@property (retain, nonatomic) NSString *createat;
@property (retain, nonatomic) NSString *editby;
@property (retain, nonatomic) NSString *editat;
@end
