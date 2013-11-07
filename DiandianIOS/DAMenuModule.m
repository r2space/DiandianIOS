//
//  DAMenuModule.m
//  DiandianIOS
//
//  Created by Antony on 13-11-6.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAMenuModule.h"

@implementation DAMenuModule
@synthesize name,image,type,price,index;

-(id)initWithDictionary:(NSDictionary *)aDict{
    self = [self init];
    if (self){
        self.name = [aDict objectForKey:@"name"];
        self.image = [aDict objectForKey:@"image"];
        self.price = [aDict objectForKey:@"price"];
        self.type = [aDict objectForKey:@"type"];
        self.index = [aDict objectForKey:@"index"];
    }
    return self;
}
@end
