//
//  DASoldoutList.m
//  DiandianIOS
//
//  Created by Antony on 13-12-24.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DASoldoutList.h"

@implementation DASoldoutList


+(Class) items_class {
    return [DASoldout class];
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
