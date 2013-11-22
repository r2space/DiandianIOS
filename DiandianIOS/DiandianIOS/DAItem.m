//
//  DAItem.m
//  DiandianIOS
//
//  Created by Antony on 13-11-20.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAItem.h"

@implementation DAItem



-(void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self._id   forKey:@"_id"];
    [aCoder encodeObject:self.name  forKey:@"name"];
    [aCoder encodeObject:self.price forKey:@"price"];
    [aCoder encodeObject:self.index forKey:@"index"];
    [aCoder encodeObject:self.row  forKey:@"row"];
    [aCoder encodeObject:self.column forKey:@"column"];
    [aCoder encodeObject:self.type  forKey:@"type"];
    [aCoder encodeObject:self.image forKey:@"image"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self._id = [aDecoder decodeObjectForKey:@"_id"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.price = [aDecoder decodeObjectForKey:@"price"];
    self.index = [aDecoder decodeObjectForKey:@"index"];
    self.row = [aDecoder decodeObjectForKey:@"row"];
    self.column = [aDecoder decodeObjectForKey:@"column"];
    self.type = [aDecoder decodeObjectForKey:@"type"];
    self.image = [aDecoder decodeObjectForKey:@"image"];
    
    return self;
}

@end
