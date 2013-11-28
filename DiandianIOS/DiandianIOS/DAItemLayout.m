//
//  DAItemLayout.m
//  DiandianIOS
//
//  Created by Antony on 13-11-26.
//  Copyright (c) 2013年 DAC. All rights reserved.
//


#import "DAItemLayout.h"

@implementation DAItemLayout



-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.itemId   forKey:@"itemId"];
    [aCoder encodeObject:self.column forKey:@"column"];
    [aCoder encodeObject:self.row forKey:@"row"];
    [aCoder encodeObject:self.index forKey:@"index"];
    [aCoder encodeObject:self.item forKey:@"item"];
    
    [aCoder encodeObject:self.amount forKey:@"amount"];
    
    
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    self.itemId = [aDecoder decodeObjectForKey:@"itemId"];
    self.column = [aDecoder decodeObjectForKey:@"column"];
    self.row = [aDecoder decodeObjectForKey:@"row"];
    self.index = [aDecoder decodeObjectForKey:@"index"];
    self.item = [aDecoder decodeObjectForKey:@"item"];
    
    return self;
}


@end
