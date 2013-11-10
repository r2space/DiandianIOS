//
//  DAFileList.m
//  tribe
//
//  Created by kita on 13-4-13.
//  Copyright (c) 2013年 dac. All rights reserved.
//

#import "DAFileList.h"
#import "DAFile.h"

@implementation DAFileList
@synthesize total,items;
+(Class)items_class
{
    return [DAFile class];
}
@end
