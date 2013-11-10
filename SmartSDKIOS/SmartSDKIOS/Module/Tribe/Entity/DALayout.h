//
//  DALayout.h
//  TribeSDK
//
//  Created by kita on 13-8-30.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "Header.h"
#import "Jastor.h"

@interface Layout : Jastor <NSCoding>
@property (retain, nonatomic) NSString *name;
@property (retain, nonatomic) NSString *comment;

@end

@interface DALayout : Jastor <NSCoding>
@property (retain, nonatomic) NSString *_id;
@property (retain, nonatomic) NSString *company;
@property (retain, nonatomic) NSNumber *status;
@property (retain, nonatomic) NSNumber *publish;
@property (retain, nonatomic) Layout *layout;
@property (retain, nonatomic) DAUser *user;
@property (retain, nonatomic) NSString *editat;
@property (retain, nonatomic) NSString *openStart;
@property (retain, nonatomic) NSString *openEnd;
@property (retain, nonatomic) NSNumber *hasUpdate;
@end
