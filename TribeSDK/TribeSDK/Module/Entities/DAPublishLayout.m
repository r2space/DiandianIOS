//
//  DAPublishLayout.m
//  TribeSDK
//
//  Created by kita on 13-8-31.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAPublishLayout.h"

@implementation DAPublishLayout
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.valid forKey:@"valid"];
    [aCoder encodeObject:self.active forKey:@"active"];
    [aCoder encodeObject:self._id forKey:@"_id"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self._id = [aDecoder decodeObjectForKey:@"_id"];
    self.active = [aDecoder decodeObjectForKey:@"active"];
    self.valid = [aDecoder decodeObjectForKey:@"valid"];
    return self;
}
@end
