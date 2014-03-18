//
//  DAItem.m
//  DiandianIOS
//
//  Created by Antony on 13-11-20.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAItem.h"

@implementation DAItem

+(Class) option_class {
    return [NSString class];
}


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
    [aCoder encodeObject:self.type forKey:@"type"];
    [aCoder encodeObject:self.soldout forKey:@"soldout"];
    
    [aCoder encodeObject:self.printerId forKey:@"printerId"];

    [aCoder encodeObject:self.option forKey:@"option"];

    [aCoder encodeObject:self.option forKey:@"selectedOption"];
    [aCoder encodeObject:self.option forKey:@"noteName"];
    
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
    self.type = [aDecoder decodeObjectForKey:@"type"];
    self.soldout = [aDecoder decodeObjectForKey:@"soldout"];

    self.printerId = [aDecoder decodeObjectForKey:@"printerId"];
    
    self.option = [aDecoder decodeObjectForKey:@"option"];
    self.option = [aDecoder decodeObjectForKey:@"selectedOption"];
    self.option = [aDecoder decodeObjectForKey:@"noteName"];

    return self;
}

@end
