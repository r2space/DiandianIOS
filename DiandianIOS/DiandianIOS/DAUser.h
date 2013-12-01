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

@interface UserName : Jastor <NSCoding>

@property (retain, nonatomic) NSString *name_zh;
@property (retain, nonatomic) NSString *letter_zh;

@end

@interface UserPhoto : Jastor <NSCoding>

@property (retain, nonatomic) NSString *small;
@property (retain, nonatomic) NSString *middle;
@property (retain, nonatomic) NSString *big;
@property (retain, nonatomic) NSString *fid;
@property (retain, nonatomic) NSString *x;
@property (retain, nonatomic) NSString *y;
@property (retain, nonatomic) NSString *width;

@end

@interface UserCustom : Jastor <NSCoding>
@property (retain, nonatomic) NSString *memo;
@end

@interface UserTel : Jastor <NSCoding>
@property (retain, nonatomic) NSString *telephone;
@property (retain, nonatomic) NSString *mobile;
@end

@interface UserAddress : Jastor <NSCoding>
@property (retain, nonatomic) NSString *country;
@property (retain, nonatomic) NSString *state;
@property (retain, nonatomic) NSString *province;
@property (retain, nonatomic) NSString *city;
@property (retain, nonatomic) NSString *county;
@property (retain, nonatomic) NSString *district;
@property (retain, nonatomic) NSString *township;
@property (retain, nonatomic) NSString *village;
@property (retain, nonatomic) NSString *street;
@property (retain, nonatomic) NSString *road;
@property (retain, nonatomic) NSString *zip;
@end

@interface UserAuthority : Jastor <NSCoding>
@property (retain, nonatomic) NSNumber *approve;
@property (retain, nonatomic) NSNumber *notice;
@property (retain, nonatomic) NSNumber *contents;
@end

@interface DAUser : Jastor <NSCoding>
// TODO 服务器返回的JSON结构中有的地方是id有的地方是_id，需要进行统一
@property (retain, nonatomic) NSString *id;
@property (retain, nonatomic) NSString *_id;
@property (retain, nonatomic) NSDictionary *extend;
@property (retain, nonatomic) NSString *name;
@property (retain, nonatomic) NSArray *following;
@property (retain, nonatomic) NSArray *follower;
@property (retain, nonatomic) NSString *uid;

@property (retain, nonatomic) NSString *lang;
@property (retain, nonatomic) UserAuthority *authority;
@property (retain, nonatomic) NSString *title;


-(BOOL ) hasApproveAuthority;
-(BOOL ) hasContentsAuthority;

@end




