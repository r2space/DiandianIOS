//
//  DADesk.m
//  DiandianIOS
//
//  Created by Antony on 13-11-21.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DADesk.h"

@implementation DADesk

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    DADesk *data = [super initWithDictionary:dictionary];
    if(data.state == nil){
        data.state = @"empty";
    }
    
    return data;
}
- (BOOL)isEmpty
{
    return self.service == nil || self.service.status == 0;
}
- (BOOL)isHasUnfinished
{
    return (self.service != nil && self.service.unfinishedCount != nil && self.service.unfinishedCount != 0);
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self._id   forKey:@"_id"];
    [aCoder encodeObject:self.createat  forKey:@"createat"];
    [aCoder encodeObject:self.createby forKey:@"createby"];
    [aCoder encodeObject:self.editat forKey:@"editat"];
    [aCoder encodeObject:self.editby   forKey:@"editby"];
    [aCoder encodeObject:self.name  forKey:@"name"];
    [aCoder encodeObject:self.valid forKey:@"valid"];
    [aCoder encodeObject:self.capacity forKey:@"capacity"];
    [aCoder encodeObject:self.type   forKey:@"type"];
    [aCoder encodeObject:self.service   forKey:@"service"];
    
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
    self._id = [aDecoder decodeObjectForKey:@"_id"];
    self.createat = [aDecoder decodeObjectForKey:@"createat"];
    self.createby = [aDecoder decodeObjectForKey:@"createby"];
    self.editat = [aDecoder decodeObjectForKey:@"editat"];
    self.editby = [aDecoder decodeObjectForKey:@"editby"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.valid = [aDecoder decodeObjectForKey:@"valid"];
    self.capacity = [aDecoder decodeObjectForKey:@"capacity"];
    self.type = [aDecoder decodeObjectForKey:@"type"];
    self.service = [aDecoder decodeObjectForKey:@"service"];
    
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
