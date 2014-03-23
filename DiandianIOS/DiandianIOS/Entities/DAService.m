//
//  DAService.m
//  DiandianIOS
//
//  Created by Antony on 13-11-21.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAService.h"

@implementation DAService


-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self._id   forKey:@"_id"];
    [aCoder encodeObject:self.deskId   forKey:@"deskId"];
    [aCoder encodeObject:self.type  forKey:@"type"];
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeObject:self.people forKey:@"people"];
    
    [aCoder encodeObject:self.unfinishedCount   forKey:@"unfinishedCount"];
    [aCoder encodeObject:self.billNum  forKey:@"billNum"];
    [aCoder encodeObject:self.orderNo forKey:@"orderNo"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.takeout   forKey:@"takeout"];
    [aCoder encodeObject:self.amount  forKey:@"amount"];
    [aCoder encodeObject:self.profit forKey:@"profit"];
    [aCoder encodeObject:self.agio forKey:@"agio"];
    [aCoder encodeObject:self.preferential   forKey:@"preferential"];
    [aCoder encodeObject:self.payType  forKey:@"payType"];
    [aCoder encodeObject:self.createat forKey:@"createat"];
    [aCoder encodeObject:self.createby forKey:@"createby"];
    [aCoder encodeObject:self.editat forKey:@"editat"];
    [aCoder encodeObject:self.editby forKey:@"editby"];
    [aCoder encodeObject:self.deskName forKey:@"deskName"];
    [aCoder encodeObject:self.userPay forKey:@"userPay"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self._id = [aDecoder decodeObjectForKey:@"_id"];
    self.deskId = [aDecoder decodeObjectForKey:@"deskId"];
    self.type = [aDecoder decodeObjectForKey:@"type"];
    self.status = [aDecoder decodeObjectForKey:@"status"];
    self.people = [aDecoder decodeObjectForKey:@"people"];
    self.unfinishedCount = [aDecoder decodeObjectForKey:@"unfinishedCount"];
    self.billNum = [aDecoder decodeObjectForKey:@"billNum"];
    self.orderNo = [aDecoder decodeObjectForKey:@"orderNo"];
    self.phone = [aDecoder decodeObjectForKey:@"phone"];
    self.takeout = [aDecoder decodeObjectForKey:@"takeout"];
    self.amount = [aDecoder decodeObjectForKey:@"amount"];
    self.profit = [aDecoder decodeObjectForKey:@"profit"];
    self.agio = [aDecoder decodeObjectForKey:@"agio"];
    self.preferential = [aDecoder decodeObjectForKey:@"preferential"];
    self.payType = [aDecoder decodeObjectForKey:@"payType"];
    self.createat = [aDecoder decodeObjectForKey:@"createat"];
    self.createby = [aDecoder decodeObjectForKey:@"createby"];
    self.editat = [aDecoder decodeObjectForKey:@"editat"];
    self.editby = [aDecoder decodeObjectForKey:@"editby"];
    self.deskName = [aDecoder decodeObjectForKey:@"deskName"];
    self.userPay = [aDecoder decodeObjectForKey:@"userPay"];
    return self;
}



@end

