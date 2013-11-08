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
        self.name = [aDict objectForKey:@"name"];
        self.image = [aDict objectForKey:@"image"];
        self.price = [aDict objectForKey:@"price"];
        self.type = [aDict objectForKey:@"type"];
        self.index = [aDict objectForKey:@"index"];
        self.amount = [aDict objectForKey:@"amount"];
        self._id = [aDict objectForKey:@"_id"];
        
        
    }
    return self;
}

@end
