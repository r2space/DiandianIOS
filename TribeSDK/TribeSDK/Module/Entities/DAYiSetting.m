//
//  DAYiSetting.m
//  TribeSDK
//
//  Created by Antony on 13-9-25.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAYiSetting.h"

@implementation DAYiSetting
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.key forKey:@"key"];
    [aCoder encodeObject:self.val forKey:@"val"];
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.key = [aDecoder decodeObjectForKey:@"key"];
    self.val = [aDecoder decodeObjectForKey:@"val"];
    return self;
}
@end
