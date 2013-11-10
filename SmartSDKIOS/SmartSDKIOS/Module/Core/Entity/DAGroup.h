//
//  DAGroup.h
//  tribe
//
//  Created by kita on 13-4-11.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DACommon.h"

#define GroupSecureTypePrivate  @"1"
#define GroupSecureTypePublic   @"2"
#define GroupTypeNormal         @"1"
#define GroupTypeOrganization   @"2"


@interface GroupName : Jastor
@property(retain, nonatomic) NSString* letter_zh;
@property(retain, nonatomic) NSString* name_zh;
@end


@interface GroupPhoto : Jastor
@property (retain, nonatomic) NSString *small;
@property (retain, nonatomic) NSString *middle;
@property (retain, nonatomic) NSString *big;
@property (retain, nonatomic) NSString *fid;
@property (retain, nonatomic) NSString *x;
@property (retain, nonatomic) NSString *y;
@property (retain, nonatomic) NSString *width;
@end


@interface DAGroup : Jastor

// TODO 服务器返回的JSON结构中有的地方是id有的地方是_id，需要进行统一
@property (retain, nonatomic) NSString* _id;
@property (retain, nonatomic) NSString* id;
@property (retain, nonatomic) GroupName* name;
@property (retain, nonatomic) NSArray* member;
@property (retain, nonatomic) GroupPhoto* photo;
@property (retain, nonatomic) NSString* description;
@property (retain, nonatomic) NSString* type;
@property (retain, nonatomic) NSString* secure;
@property (retain, nonatomic) NSString* category;

-(UIImage *) getGroupPhotoImage;

@end

