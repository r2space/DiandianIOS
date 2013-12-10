//
//  DAMyMenu.m
//  TribeSDK
//
//  Created by Antony on 13-11-7.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "SmartSDK.h"


@implementation DAMenu


@synthesize items,name,image,type,price,index,amount;


+(Class) items_class {
    return [DAItemLayout class];
}

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
        self.page  = [aDict objectForKey:@"page"];
        self.items  = [aDict objectForKey:@"items"];
        
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self._id   forKey:@"_id"];
    [aCoder encodeObject:self.name  forKey:@"name"];
    [aCoder encodeObject:self.page forKey:@"page"];
    [aCoder encodeObject:self.items forKey:@"items"];

}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self._id = [aDecoder decodeObjectForKey:@"_id"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.page = [aDecoder decodeObjectForKey:@"page"];
    self.items = [aDecoder decodeObjectForKey:@"items"];

    return self;
}

@end
