//
//  DAMyMenu.m
//  TribeSDK
//
//  Created by Antony on 13-11-7.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAMyMenu.h"

@implementation DAMyMenu


@synthesize name,image,type,price,index,amount;

-(id)initWithDictionary:(NSDictionary *)aDict{
    self = [self init];
    if (self){
        self.name   = [aDict objectForKey:@"name"];
        self.image  = [aDict objectForKey:@"image"];
        self.price  = [aDict objectForKey:@"price"];
        self.type   = [aDict objectForKey:@"type"];
        self.index  = [aDict objectForKey:@"index"];
        self.amount = [aDict objectForKey:@"amount"];
        self.status = [aDict objectForKey:@"status"];
        
        self._id    = [aDict objectForKey:@"_id"];
        
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name  forKey:@"name"];
    [aCoder encodeObject:self.image forKey:@"image"];
    [aCoder encodeObject:self.price forKey:@"price"];
    [aCoder encodeObject:self.type  forKey:@"type"];
    [aCoder encodeObject:self.index forKey:@"index"];
    [aCoder encodeObject:self.amount    forKey:@"amount"];
    [aCoder encodeObject:self.status    forKey:@"status"];
    [aCoder encodeObject:self._id   forKey:@"_id"];

}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.image = [aDecoder decodeObjectForKey:@"image"];
    self.price = [aDecoder decodeObjectForKey:@"price"];
    self.type = [aDecoder decodeObjectForKey:@"type"];
    self.index = [aDecoder decodeObjectForKey:@"index"];
    self.amount = [aDecoder decodeObjectForKey:@"amount"];
    self.status = [aDecoder decodeObjectForKey:@"status"];
    self._id = [aDecoder decodeObjectForKey:@"_id"];

    return self;
}

@end
