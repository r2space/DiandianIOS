//
//  DANotice.m
//  TribeSDK
//
//  Created by LI LIN on 2013/09/05.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAYiNotice.h"

@implementation DAYiNotice

+(Class) touser_class {
    return [NSString class];
}

+(Class) togroup_class {
    return [NSString class];
}

@end

@implementation DAYiNoticeList

@synthesize items;
+(Class) items_class {
    return [DAYiNotice class];
}

@end