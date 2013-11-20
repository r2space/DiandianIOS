//
//  DAMyMenuList.m
//  TribeSDK
//
//  Created by Antony on 13-11-9.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAMenuList.h"
#import "DAMenu.h"

@implementation DAMenuList
@synthesize items;

+(Class) items_class {
    return [DAMenu class];
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.items forKey:@"items"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.items = [aDecoder decodeObjectForKey:@"items"];
    return  self;
}
@end
