//
//  DACategory.m
//  TribeSDK
//
//  Created by LI LIN on 2013/05/21.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DACategory.h"

@implementation DACategoryItem
@end

@implementation DACategory
@synthesize id, _id;

+(Class) items_class {
    return [DACategoryItem class];
}

@end
