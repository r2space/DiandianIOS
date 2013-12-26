//
//  DATag.m
//  DiandianIOS
//
//  Created by Antony on 13-12-24.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DATag.h"

@implementation DATag


-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.scope forKey:@"scope"];
    [aCoder encodeObject:self.name   forKey:@"name"];
    [aCoder encodeObject:self.counter forKey:@"counter"];

    
    
    
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    self.scope = [aDecoder decodeObjectForKey:@"scope"];
    self.counter = [aDecoder decodeObjectForKey:@"counter"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    
    
    return self;
}


@end
