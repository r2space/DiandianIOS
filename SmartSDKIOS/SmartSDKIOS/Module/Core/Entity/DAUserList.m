//
//  DAUserList.m
//  tribe
//
//  Created by kita on 13-4-11.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DAUserList.h"
#import "DAUser.h"


@implementation DAUserList
@synthesize items;
+(Class) items_class {
    return [DAUser class];
}
@end
