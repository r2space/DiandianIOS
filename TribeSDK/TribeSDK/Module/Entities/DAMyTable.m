//
//  DAMyMenu.m
//  TribeSDK
//
//  Created by Antony on 13-11-7.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAMyTable.h"

@implementation DAMyTable


@synthesize tableId, name, type, state, numOfPepole, waitterId, durationTime, unfinishedCount;

-(id)initWithDictionary:(NSDictionary *)aDict{
    self = [self init];
    if (self){
        self.tableId  = [aDict objectForKey:@"tableId"];
        self.type  = [aDict objectForKey:@"type"];
        self.name   = [aDict objectForKey:@"name"];
        self.state  = [aDict objectForKey:@"state"];
        self.numOfPepole  = [aDict objectForKey:@"numOfPepole"];
        self.waitterId  = [aDict objectForKey:@"waitterId"];
        self.durationTime  = [aDict objectForKey:@"durationTime"];
        self.unfinishedCount  = [aDict objectForKey:@"unfinishedCount"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.tableId   forKey:@"tableId"];
    [aCoder encodeObject:self.name  forKey:@"name"];
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeObject:self.state forKey:@"state"];
    [aCoder encodeObject:self.numOfPepole forKey:@"numOfPepole"];
    [aCoder encodeObject:self.waitterId forKey:@"waitterId"];
    [aCoder encodeObject:self.durationTime forKey:@"durationTime"];
    [aCoder encodeObject:self.unfinishedCount forKey:@"unfinishedCount"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.tableId = [aDecoder decodeObjectForKey:@"tableId"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.type = [aDecoder decodeObjectForKey:@"type"];
    self.state = [aDecoder decodeObjectForKey:@"state"];
    self.numOfPepole = [aDecoder decodeObjectForKey:@"numOfPepole"];
    self.waitterId = [aDecoder decodeObjectForKey:@"waitterId"];
    self.durationTime = [aDecoder decodeObjectForKey:@"durationTime"];
    self.unfinishedCount = [aDecoder decodeObjectForKey:@"unfinishedCount"];

    return self;
}

@end
