//
//  DAGroupList.m
//  tribe
//
//  Created by kita on 13-4-11.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DAGroup.h"
#import "DAGroupList.h"

@implementation DAGroupList
@synthesize items;
+(Class) items_class {
    return [DAGroup class];
}
@end
