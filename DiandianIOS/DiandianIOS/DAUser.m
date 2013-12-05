//
//  DAUser.m
//  tribe
//
//  Created by kita on 13-4-10.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DAUser.h"


@implementation DAUser
@synthesize  _id;


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    return self;
}






-(UIImage *) getUserDefaultPhotoImage
{
    return [UIImage imageNamed:@"user_thumb.png"];
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self._id forKey:@"_id"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.extend forKey:@"extend"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    [self set_id:[aDecoder decodeObjectForKey:@"_id"]];
    self.name = [aDecoder decodeObjectForKey:@"name"];
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
