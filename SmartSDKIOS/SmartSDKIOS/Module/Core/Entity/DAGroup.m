//
//  DAGroup.m
//  tribe
//
//  Created by kita on 13-4-11.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DAGroup.h"

@implementation GroupName
@end

@implementation GroupPhoto
@end

@implementation DAGroup
@synthesize id, _id;

+(Class) member_class {
    return [NSString class];
}

-(UIImage *) getGroupPhotoImage
{
    return [DACommon getCatchedImage: self.photo.small defaultImage:[UIImage imageNamed:@"group_gray.png"]];
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self._id == nil || [@"" isEqualToString:self._id]) {
        self._id = self.id;
    }
    return self;
}

@end
