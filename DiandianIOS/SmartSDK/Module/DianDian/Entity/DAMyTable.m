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

-(void)swap:(DAMyTable*)otherTable{
    if (otherTable == nil) {
        return;
    }
    
    NSDictionary * dictSelf = [self toDictionary];
    NSDictionary * dictOther = [otherTable toDictionary];
    [otherTable fromDictionary:dictSelf];
    [self fromDictionary:dictOther];
}

-(id)initWithDictionary:(NSDictionary *)aDict{
    self = [self init];
    if (self){
        [self fromDictionary:aDict];
    }
    return self;
}
-(id)fromDictionary:(NSDictionary *)aDict{
    self.tableId  = [aDict objectForKey:@"tableId"];
    self.type  = [aDict objectForKey:@"type"];
    self.name   = [aDict objectForKey:@"name"];
    self.state  = [aDict objectForKey:@"state"];
    self.numOfPepole  = [aDict objectForKey:@"numOfPepole"];
    self.waitterId  = [aDict objectForKey:@"waitterId"];
    self.durationTime  = [aDict objectForKey:@"durationTime"];
    self.unfinishedCount  = [aDict objectForKey:@"unfinishedCount"];
    return self;
}
-(NSDictionary*)toDictionary{
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithCapacity:8];
    [dict setValue:self.tableId forKey:@"tableId"];
    [dict setValue:self.type forKey:@"type"];
    [dict setValue:self.name forKey:@"name"];
    [dict setValue:self.state forKey:@"state"];
    [dict setValue:self.numOfPepole forKey:@"numOfPepole"];
    [dict setValue:self.waitterId forKey:@"waitterId"];
    [dict setValue:self.durationTime forKey:@"durationTime"];
    [dict setValue:self.unfinishedCount forKey:@"unfinishedCount"];
    return dict;
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
