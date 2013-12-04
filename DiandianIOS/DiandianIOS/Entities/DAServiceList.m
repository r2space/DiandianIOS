//
//  DAServiceList.m
//  DiandianIOS
//
//  Created by Antony on 13-12-3.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAServiceList.h"

@implementation DAServiceList

+(Class) items_class {
    return [DAService class];
}


-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.items forKey:@"items" ];
    [aCoder encodeObject:self.totalItems forKey:@"totalItems" ];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.items = [aDecoder decodeObjectForKey:@"items"];
    self.totalItems = [aDecoder decodeObjectForKey:@"totalItems"];
    
    return  self;
}

@end
