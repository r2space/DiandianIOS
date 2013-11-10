//
//  DAYiWorkStationMenu.h
//  TribeSDK
//
//  Created by kita on 13-9-15.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "Jastor.h"

@interface DAYiWorkStationMenu : Jastor

@property (retain, nonatomic) NSString *icon;
@property (retain, nonatomic) NSString *title;
@property (retain, nonatomic) NSString *url;
@property (retain, nonatomic) NSString *type;
@property (retain, nonatomic) NSString *authType;

@property (retain, nonatomic) NSString *open;
@property (retain, nonatomic) NSString *editby;
@property (retain, nonatomic) NSString *createby;
@property (retain, nonatomic) NSString *_id;

@property (retain, nonatomic) NSString *valid;
@property (retain, nonatomic) NSString *createat;
@property (retain, nonatomic) NSString *editat;
@property (retain, nonatomic) NSString *sort_level;
//@property (retain, nonatomic) NSArray *togroup;
//@property (retain, nonatomic) NSArray *touser;

@end
