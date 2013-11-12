//
//  DAMyMenu.m
//  TribeSDK
//
//  Created by Antony on 13-11-7.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAMyTable.h"

@implementation DAMyTable


@synthesize _id,name,type,state,numOfPepole,waitterId;

-(id)initWithDictionary:(NSDictionary *)aDict{
    self = [self init];
    if (self){
        self._id  = [aDict objectForKey:@"_id"];
        self.type  = [aDict objectForKey:@"type"];
        self.name   = [aDict objectForKey:@"name"];
        self.state  = [aDict objectForKey:@"state"];
        self.numOfPepole  = [aDict objectForKey:@"numOfPepole"];
        self.waitterId  = [aDict objectForKey:@"waitterId"];
        //self.waitterName  = [aDict objectForKey:@"waitterName"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self._id   forKey:@"_id"];
    [aCoder encodeObject:self.name  forKey:@"name"];
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeObject:self.state forKey:@"state"];
    [aCoder encodeObject:self.numOfPepole forKey:@"numOfPepole"];
    [aCoder encodeObject:self.waitterId forKey:@"waitterId"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self._id = [aDecoder decodeObjectForKey:@"_id"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.type = [aDecoder decodeObjectForKey:@"type"];
    self.state = [aDecoder decodeObjectForKey:@"state"];
    self.numOfPepole = [aDecoder decodeObjectForKey:@"numOfPepole"];
    self.waitterId = [aDecoder decodeObjectForKey:@"waitterId"];

    return self;
}

@end
