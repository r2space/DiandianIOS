//
//  DACategory.h
//  TribeSDK
//
//  Created by LI LIN on 2013/05/21.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "Jastor.h"

@interface DACategoryItem : Jastor

@property (retain, nonatomic) NSString *name;
@property (retain, nonatomic) NSString *value;
@property (retain, nonatomic) NSString *image;
@property (retain, nonatomic) NSString *description;

@end


@interface DACategory : Jastor

@property (retain, nonatomic) NSString *id;
@property (retain, nonatomic) NSString *_id;
@property (retain, nonatomic) NSString *project;
@property (retain, nonatomic) NSString *group;
@property (retain, nonatomic) NSString *parent;
@property (retain, nonatomic) NSString *description;
@property (retain, nonatomic) NSArray  *items;

@property (retain, nonatomic) NSString *createby;
@property (retain, nonatomic) NSString *createat;
@property (retain, nonatomic) NSString *editby;
@property (retain, nonatomic) NSString *editat;

@end
