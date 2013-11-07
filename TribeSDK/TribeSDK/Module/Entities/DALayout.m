//
//  DALayout.m
//  TribeSDK
//
//  Created by kita on 13-8-30.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DALayout.h"
@implementation Layout
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.comment forKey:@"comment"];
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.comment = [aDecoder decodeObjectForKey:@"comment"];
    return self;
}
@end

@implementation DALayout
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self._id forKey:@"_id"];
    [aCoder encodeObject:self.company forKey:@"cpmpany"];
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeObject:self.publish forKey:@"publish"];
    [aCoder encodeObject:self.layout forKey:@"layout"];
    [aCoder encodeObject:self.user forKey:@"user"];
    [aCoder encodeObject:self.editat forKey:@"editat"];
    [aCoder encodeObject:self.openStart forKey:@"openStart"];
    [aCoder encodeObject:self.openEnd forKey:@"openEnd"];
    [aCoder encodeObject:self.hasUpdate forKey:@"hasUpdate"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self._id = [aDecoder decodeObjectForKey:@"_id"];
    self.company = [aDecoder decodeObjectForKey:@"company"];
    self.status = [aDecoder decodeObjectForKey:@"status"];
    self.publish = [aDecoder decodeObjectForKey:@"publish"];
    self.layout = [aDecoder decodeObjectForKey:@"layout"];
    self.user = [aDecoder decodeObjectForKey:@"user"];
    self.editat = [aDecoder decodeObjectForKey:@"editat"];
    self.openStart = [aDecoder decodeObjectForKey:@"openStart"];
    self.openEnd = [aDecoder decodeObjectForKey:@"openEnd"];
    self.hasUpdate = [aDecoder decodeObjectForKey:@"hasUpdate"];
    return self;
}
@end
