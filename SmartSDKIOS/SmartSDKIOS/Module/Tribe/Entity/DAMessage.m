//
//  DAMessage.m
//  tribe
//
//  Created by kita on 13-4-10.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DAMessage.h"

@implementation MessageAt

@synthesize groups,users;
+(Class)groups_class{
    return [NSString class];
}
+(Class)users_class{
    return [NSString class];
}
@end

@implementation MessagePart

@synthesize createby, replyNums, forwardNums;

+(Class)atusers_class
{
    return [DAUser class];
}

+(Class)atgroups_class
{
    return [DAGroup class];
}
@end

@implementation MessageAttach
@synthesize fileid,filename,_id;
@end
@implementation MessageThumb
@synthesize fileid,width    ,height;
@end
@implementation DAMessage

@synthesize _id, type, content, range, contentType, createat, createby, editat, editby, part ,thumb;
+(Class)attach_class{
    return [MessageAttach class];
}

+(Class)likers_class{
    return [NSString class];
}


-(DAUser *)getCreatUser
{
    return self.part.createby;
}

-(DAGroup *)getPublicRange
{
    return self.part.range;
}

-(NSNumber *)getForwardCount
{
    return self.part.forwardNums;
}

-(NSNumber *)getReplyCount
{
    return self.part.replyNums;
}

-(BOOL) hasAt
{
    return self.part.atusers.count > 0 || self.part.atgroups.count > 0;
}

-(NSString *) getAtString
{
    NSString *at = @"";
    for (DAUser *user in self.part.atusers) {
        at = [at stringByAppendingFormat:@"@%@ ",[user getUserName]];
    }

    for (DAGroup *group in self.part.atgroups) {
        at = [at stringByAppendingFormat:@"@%@ ",group.name.name_zh];
    }
    return at;
}
@end
