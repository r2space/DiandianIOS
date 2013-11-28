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
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:self.itemName   forKey:@"itemName"];
    [aCoder encodeObject:self.itemPriceNormal  forKey:@"itemPriceNormal"];
    [aCoder encodeObject:self.itemPriceHalf forKey:@"itemPriceHalf"];
    [aCoder encodeObject:self.itemPriceDiscount forKey:@"itemPriceDiscount"];
    [aCoder encodeObject:self.itemType  forKey:@"itemType"];
    [aCoder encodeObject:self.itemComment forKey:@"itemComment"];
    [aCoder encodeObject:self.itemMaterial  forKey:@"itemMaterial"];
    [aCoder encodeObject:self.itemMethod forKey:@"itemMethod"];
    [aCoder encodeObject:self.bigimage forKey:@"bigimage"];
    [aCoder encodeObject:self.smallimage forKey:@"smallimage"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    self.itemName = [aDecoder decodeObjectForKey:@"itemName"];
    self.itemPriceNormal = [aDecoder decodeObjectForKey:@"itemPriceNormal"];
    self.itemPriceHalf = [aDecoder decodeObjectForKey:@"itemPriceHalf"];
    self.itemPriceDiscount = [aDecoder decodeObjectForKey:@"itemPriceDiscount"];
    self.itemType = [aDecoder decodeObjectForKey:@"itemType"];
    self.itemComment = [aDecoder decodeObjectForKey:@"itemComment"];
    self.itemMaterial = [aDecoder decodeObjectForKey:@"itemMaterial"];
    self.itemMethod = [aDecoder decodeObjectForKey:@"itemMethod"];
    self.bigimage = [aDecoder decodeObjectForKey:@"bigimage"];
    self.smallimage = [aDecoder decodeObjectForKey:@"smallimage"];
    
    return self;
}

@end
