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
    [aCoder encodeObject:self.orderNum forKey:@"orderNum"];
    [aCoder encodeObject:self.service forKey:@"service"];
    [aCoder encodeObject:self.item forKey:@"item"];
    [aCoder encodeObject:self.itemType forKey:@"itemType"];
    
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeObject:self.back forKey:@"back"];
    [aCoder encodeObject:self.valid forKey:@"valid"];
    [aCoder encodeObject:self.remark forKey:@"remark"];
    
    [aCoder encodeObject:self.amount forKey:@"amount"];
    [aCoder encodeObject:self.amountNum forKey:@"amountNum"];

    [aCoder encodeObject:self.isNew forKey:@" isNew"];
    
   
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    self.deskId = [aDecoder decodeObjectForKey:@"deskId"];
    self.serviceId = [aDecoder decodeObjectForKey:@"serviceId"];
    self.userId = [aDecoder decodeObjectForKey:@"userId"];
    self.itemId = [aDecoder decodeObjectForKey:@"itemId"];
    self.itemType = [aDecoder decodeObjectForKey:@"itemType"];
    self.item = [aDecoder decodeObjectForKey:@"item"];
    
    self.orderSeq = [aDecoder decodeObjectForKey:@"orderSeq"];
    self.orderNum = [aDecoder decodeObjectForKey:@"orderNum"];
    self.service = [aDecoder decodeObjectForKey:@"service"];

    self.type = [aDecoder decodeObjectForKey:@"type"];
    self.back = [aDecoder decodeObjectForKey:@"back"];
    self.valid = [aDecoder decodeObjectForKey:@"valid"];
    self.remark = [aDecoder decodeObjectForKey:@"remark"];
    
    self.amount = [aDecoder decodeObjectForKey:@"amount"];
    self.amountNum = [aDecoder decodeObjectForKey:@"amountNum"];
    
    self.isNew = [aDecoder decodeObjectForKey:@"isNew"];
    
    
    
    return self;
}

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self.amount == nil || [self.amount intValue] ==0) {
        self.amount = [NSNumber numberWithInt:1];
    }
    return self;
}

//-(NSDictionary*)toDictionary{
//    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
//    [dict setValue:self.deskId forKey:@"deskId"];
//    [dict setValue:self.serviceId forKey:@"serviceId"];
//    [dict setValue:self.userId forKey:@"userId"];
//    [dict setValue:self.itemId forKey:@"itemId"];
//    [dict setValue:self.orderSeq forKey:@"orderSeq"];
//    [dict setValue:self.type forKey:@"type"];
//    [dict setValue:self.back forKey:@"back"];
//    [dict setValue:self.valid forKey:@"valid"];
//    [dict setValue:self.remark forKey:@"remark"];
//    
//    [dict setValue:self.isNew forKey:@"isNew"];
//
//    
//    return dict;
//}



@end
