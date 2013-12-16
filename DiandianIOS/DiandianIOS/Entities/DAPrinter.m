//
//  DAPrinter.m
//  DiandianIOS
//
//  Created by Antony on 13-12-13.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAPrinter.h"

@implementation DAPrinter

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.name   forKey:@"name"];
    [aCoder encodeObject:self.printerIP forKey:@"printerIP"];
    [aCoder encodeObject:self.type forKey:@"type"];
    

    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.printerIP = [aDecoder decodeObjectForKey:@"printerIP"];
    self.type = [aDecoder decodeObjectForKey:@"type"];
    
    return self;
}


@end
