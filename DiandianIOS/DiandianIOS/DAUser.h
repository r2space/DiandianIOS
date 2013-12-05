//
//  DAUser.h
//  tribe
//
//  Created by kita on 13-4-10.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DACommon.h"
#import "DAGroup.h"

#define UserLanguageJP  @"jp"
#define UserLanguageZH  @"zh"
#define UserLanguageEN  @"en"


@interface DAUser : Jastor <NSCoding>
// TODO 服务器返回的JSON结构中有的地方是id有的地方是_id，需要进行统一
@property (retain, nonatomic) NSString *_id;
@property (retain, nonatomic) NSDictionary *extend;
@property (retain, nonatomic) NSString *name;
@property (retain, nonatomic) NSString *userName;
@property (retain, nonatomic) NSString *uid;



@end




