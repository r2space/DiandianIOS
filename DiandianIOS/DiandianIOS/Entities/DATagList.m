//
//  DATagList.m
//  DiandianIOS
//
//  Created by Antony on 13-12-24.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DATagList.h"

@implementation DATagList

+(Class) items_class {
    return [DATag class];
}


-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.items forKey:@"items" ];

    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.items = [aDecoder decodeObjectForKey:@"items"];
    
    return  self;
}

@end
