//
//  DAOrder.m
//  DiandianIOS
//
//  Created by Antony on 13-11-22.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAOrder.h"

@implementation DAOrder


-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.deskId   forKey:@"deskId"];
    [aCoder encodeObject:self.serviceId forKey:@"serviceId"];
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.itemId forKey:@"itemId"];
    [aCoder encodeObject:self.orderSeq forKey:@"orderSeq"];
    [aCoder encodeObject:self.service forKey:@"service"];
    [aCoder encodeObject:self.item forKey:@"item"];
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeObject:self.back forKey:@"back"];
    [aCoder encodeObject:self.valid forKey:@"valid"];
    [aCoder encodeObject:self.remark forKey:@"remark"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    self.deskId = [aDecoder decodeObjectForKey:@"deskId"];
    self.serviceId = [aDecoder decodeObjectForKey:@"serviceId"];
    self.userId = [aDecoder decodeObjectForKey:@"userId"];
    self.itemId = [aDecoder decodeObjectForKey:@"itemId"];
    self.orderSeq = [aDecoder decodeObjectForKey:@"orderSeq"];
    self.service = [aDecoder decodeObjectForKey:@"service"];
    self.item = [aDecoder decodeObjectForKey:@"item"];
    self.type = [aDecoder decodeObjectForKey:@"type"];
    self.back = [aDecoder decodeObjectForKey:@"back"];
    self.valid = [aDecoder decodeObjectForKey:@"valid"];
    self.remark = [aDecoder decodeObjectForKey:@"remark"];
    
    return self;
}

@end
