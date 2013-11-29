//
//  DAUser.m
//  tribe
//
//  Created by kita on 13-4-10.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DAUser.h"

@implementation UserName
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name_zh forKey:@"name_zh"];
    [aCoder encodeObject:self.letter_zh forKey:@"letter_zh"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.name_zh = [aDecoder decodeObjectForKey:@"name_zh"];
    self.letter_zh = [aDecoder decodeObjectForKey:@"letter_zh"];
    return self;
}
@end


@implementation UserPhoto
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.small forKey:@"small"];
    [aCoder encodeObject:self.middle forKey:@"middle"];
    [aCoder encodeObject:self.big forKey:@"big"];
    [aCoder encodeObject:self.fid forKey:@"fid"];
    [aCoder encodeObject:self.x forKey:@"x"];
    [aCoder encodeObject:self.y forKey:@"y"];
    [aCoder encodeObject:self.width forKey:@"width"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.small = [aDecoder decodeObjectForKey:@"small"];
    self.middle = [aDecoder decodeObjectForKey:@"middle"];
    self.big = [aDecoder decodeObjectForKey:@"big"];
    self.fid = [aDecoder decodeObjectForKey:@"fid"];
    self.x = [aDecoder decodeObjectForKey:@"x"];
    self.y = [aDecoder decodeObjectForKey:@"y"];
    self.width = [aDecoder decodeObjectForKey:@"width"];
    return self;
}
@end

@implementation UserCustom

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.memo forKey:@"memo"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.memo = [aDecoder decodeObjectForKey:@"memo"];
    return self;
}

@end

@implementation UserTel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.telephone forKey:@"telephone"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.telephone = [aDecoder decodeObjectForKey:@"telephone"];
    self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
    return self;
}

@end

@implementation UserAddress

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.country forKey:@"country"];
    [aCoder encodeObject:self.state forKey:@"state"];
    [aCoder encodeObject:self.province forKey:@"province"];
    [aCoder encodeObject:self.city forKey:@"city"];
    [aCoder encodeObject:self.county forKey:@"county"];
    [aCoder encodeObject:self.district forKey:@"district"];
    [aCoder encodeObject:self.township forKey:@"township"];
    [aCoder encodeObject:self.village forKey:@"village"];
    [aCoder encodeObject:self.street forKey:@"street"];
    [aCoder encodeObject:self.road forKey:@"road"];
    [aCoder encodeObject:self.zip forKey:@"zip"];

    
    

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.country = [aDecoder decodeObjectForKey:@"country"];
    self.state = [aDecoder decodeObjectForKey:@"state"];
    self.province = [aDecoder decodeObjectForKey:@"province"];
    self.city = [aDecoder decodeObjectForKey:@"city"];
    self.county = [aDecoder decodeObjectForKey:@"county"];
    self.district = [aDecoder decodeObjectForKey:@"district"];
    self.township = [aDecoder decodeObjectForKey:@"township"];
    self.village = [aDecoder decodeObjectForKey:@"village"];
    self.street = [aDecoder decodeObjectForKey:@"street"];
    self.road = [aDecoder decodeObjectForKey:@"road"];
    self.zip = [aDecoder decodeObjectForKey:@"zip"];

    return self;
}

@end


@implementation UserAuthority

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.approve forKey:@"approve"];
    [aCoder encodeObject:self.contents forKey:@"contents"];
    [aCoder encodeObject:self.notice forKey:@"notice"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.approve = [aDecoder decodeObjectForKey:@"approve"];
    self.contents = [aDecoder decodeObjectForKey:@"contents"];
    self.notice = [aDecoder decodeObjectForKey:@"notice"];
    
    return self;
}

@end


@implementation DAUser
@synthesize id, _id;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self._id == nil || [@"" isEqualToString:self._id]) {
        self._id = self.id;
    }
    return self;
}

-(BOOL ) hasApproveAuthority
{
    if ([self.authority.approve intValue] == 1 ) {
        return YES;
    } else {
        return NO;
    }
}

-(BOOL ) hasContentsAuthority
{

    if ([self.authority.contents intValue] == 1) {
        return YES;
    } else {
        return NO;
    }
}

-(NSString *)getUserName
{
    return self.name.name_zh;
}

-(NSString *) getUserPhotoId
{
    return self.photo.big;
}

-(UIImage *) getUserDefaultPhotoImage
{
    return [UIImage imageNamed:@"user_thumb.png"];
}

-(UIImage *) getUserPhotoImage
{
    return [DACommon getCatchedImage: [self getUserPhotoId] defaultImage:[self getUserDefaultPhotoImage]];
}

-(BOOL) isUserPhotoCatched
{
    return [DACommon isImageCatched:[self getUserPhotoId]];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.id forKey:@"id"];
    [aCoder encodeObject:self._id forKey:@"_id"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.photo forKey:@"photo"];
    [aCoder encodeObject:self.following forKey:@"following"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.tel forKey:@"tel"];
    [aCoder encodeObject:self.lang forKey:@"lang"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.authority forKey:@"authority"];
    [aCoder encodeObject:self.extend forKey:@"extend"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.id = [aDecoder decodeObjectForKey:@"id"];
    [self set_id:[aDecoder decodeObjectForKey:@"_id"]];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.photo = [aDecoder decodeObjectForKey:@"photo"];
    self.following = [aDecoder decodeObjectForKey:@"following"];
    self.address = [aDecoder decodeObjectForKey:@"address"];
    self.tel = [aDecoder decodeObjectForKey:@"tel"];
    self.lang = [aDecoder decodeObjectForKey:@"lang"];
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.authority = [aDecoder decodeObjectForKey:@"authority"];
    self.extend = [aDecoder decodeObjectForKey:@"extend"];
    
    return self;
}

+(Class) following_class {
    return [NSString class];
}

+(Class) follower_class {
    return [NSString class];
}

@end
