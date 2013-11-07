//
//  DATurnover.m
//  TribeSDK
//
//  Created by LI LIN on 2013/05/14.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DATurnover.h"

@implementation DATurnoverItem
@end

@implementation DATurnover

@synthesize id, _id;

+(Class) category_class {
    return [DATurnoverItem class];
}

+(Class) user_class {
    return [DAUser class];
}

@end
