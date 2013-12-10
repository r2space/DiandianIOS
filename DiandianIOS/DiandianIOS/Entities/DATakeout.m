//
//  DAProcession.m
//  DiandianIOS
//
//  Created by Xu Yang on 11/18/13.
//  Copyright (c) 2013 DAC. All rights reserved.
//

#import "DATakeout.h"

@implementation DATakeout
@synthesize takeoutId, num, type, phoneNumber, state, menuId;

-(id)initWithDictionary:(NSDictionary *)aDict{
    self = [self init];
    if (self){
        [self fromDictionary:aDict];
    }
    return self;
}
-(id)fromDictionary:(NSDictionary *)aDict{
    self.takeoutId  = [aDict objectForKey:@"takeoutId"];
    self.num  = [aDict objectForKey:@"num"];
    self.type  = [aDict objectForKey:@"type"];
    self.phoneNumber  = [aDict objectForKey:@"phoneNumber"];
    self.state   = [aDict objectForKey:@"state"];
    self.menuId   = [aDict objectForKey:@"menuId"];
    return self;
}
-(NSDictionary*)toDictionary{
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithCapacity:8];
    [dict setValue:self.takeoutId forKey:@"takeoutId"];
    [dict setValue:self.num forKey:@"num"];
    [dict setValue:self.type forKey:@"type"];
    [dict setValue:self.phoneNumber forKey:@"phoneNumber"];
    [dict setValue:self.state forKey:@"state"];
    [dict setValue:self.menuId forKey:@"menuId"];
    return dict;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.takeoutId   forKey:@"takeoutId"];
    [aCoder encodeObject:self.num  forKey:@"num"];
    [aCoder encodeObject:self.type  forKey:@"type"];
    [aCoder encodeObject:self.phoneNumber  forKey:@"phoneNumber"];
    [aCoder encodeObject:self.state forKey:@"state"];
    [aCoder encodeObject:self.menuId forKey:@"menuId"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.takeoutId = [aDecoder decodeObjectForKey:@"takeoutId"];
    self.num = [aDecoder decodeObjectForKey:@"num"];
    self.type = [aDecoder decodeObjectForKey:@"type"];
    self.phoneNumber = [aDecoder decodeObjectForKey:@"phoneNumber"];
    self.state = [aDecoder decodeObjectForKey:@"state"];
    self.menuId = [aDecoder decodeObjectForKey:@"menuId"];
    return self;
}
@end
