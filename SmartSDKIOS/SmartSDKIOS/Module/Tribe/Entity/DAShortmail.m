//
//  DAShortmail.m
//  TribeSDK
//
//  Created by LI LIN on 2013/04/26.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAShortmail.h"

@implementation ShortmailAttach
@end

@implementation DAShortmail
@synthesize id, _id;

+(Class) attach_class {
    return [ShortmailAttach class];
}
@end
