//
//  DAProcession.m
//  DiandianIOS
//
//  Created by Xu Yang on 11/18/13.
//  Copyright (c) 2013 DAC. All rights reserved.
//

#import "DAProcession.h"

@implementation DAProcession
@synthesize processionId, num, numOfPeople, order;

-(id)initWithDictionary:(NSDictionary *)aDict{
    self = [self init];
    if (self){
        [self fromDictionary:aDict];
    }
    return self;
}
-(id)fromDictionary:(NSDictionary *)aDict{
    self.processionId  = [aDict objectForKey:@"processionId"];
    self.num  = [aDict objectForKey:@"num"];
    self.numOfPeople  = [aDict objectForKey:@"numOfPeople"];
    self.order   = [aDict objectForKey:@"order"];
    return self;
}
-(NSDictionary*)toDictionary{
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithCapacity:8];
    [dict setValue:self.processionId forKey:@"processionId"];
    [dict setValue:self.num forKey:@"num"];
    [dict setValue:self.numOfPeople forKey:@"numOfPeople"];
    [dict setValue:self.order forKey:@"order"];
    return dict;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.processionId   forKey:@"processionId"];
    [aCoder encodeObject:self.num  forKey:@"num"];
    [aCoder encodeObject:self.numOfPeople  forKey:@"numOfPeople"];
    [aCoder encodeObject:self.order forKey:@"order"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.processionId = [aDecoder decodeObjectForKey:@"processionId"];
    self.num = [aDecoder decodeObjectForKey:@"num"];
    self.numOfPeople = [aDecoder decodeObjectForKey:@"numOfPeople"];
    self.order = [aDecoder decodeObjectForKey:@"order"];
    return self;
}
@end
