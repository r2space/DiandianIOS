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

-(void)swap:(DADesk *)otherTable{
    if (otherTable == nil) {
        return;
    }
    
    NSDictionary * dictSelf = [self toDictionary];
    NSDictionary * dictOther = [otherTable toDictionary];
    [otherTable fromDictionary:dictSelf];
    [self fromDictionary:dictOther];
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


-(id)fromDictionary:(NSDictionary *)aDict{
    self._id = [aDict objectForKey:@"_id"];
    self.createat = [aDict objectForKey:@"createat"];
    self.createby = [aDict objectForKey:@"createby"];
    self.editat = [aDict objectForKey:@"editat"];
    self.editby = [aDict objectForKey:@"editby"];
    self.name = [aDict objectForKey:@"name"];
    self.valid = [aDict objectForKey:@"valid"];
    self.capacity = [aDict objectForKey:@"capacity"];
    self.type = [aDict objectForKey:@"type"];
    
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
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithCapacity:17];
    [dict setValue:self._id   forKey:@"_id"];
    [dict setValue:self.createat  forKey:@"createat"];
    [dict setValue:self.createby forKey:@"createby"];
    [dict setValue:self.editat forKey:@"editat"];
    [dict setValue:self.editby   forKey:@"editby"];
    [dict setValue:self.name  forKey:@"name"];
    [dict setValue:self.valid forKey:@"valid"];
    [dict setValue:self.capacity forKey:@"capacity"];
    [dict setValue:self.type   forKey:@"type"];
    
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


@end
