//
//  DAUser.h
//  tribe
//
//  Created by kita on 13-4-10.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DACommon.h"



@interface DAUser : Jastor <NSCoding>

@property (retain, nonatomic) NSString *_id;
@property (retain, nonatomic) NSDictionary *extend;
@property (retain, nonatomic) NSString *name;
@property (retain, nonatomic) NSString *userName;
@property (retain, nonatomic) NSString *uid;
@property (retain, nonatomic) NSNumber *cash;

@end




