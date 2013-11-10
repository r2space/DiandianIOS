//
//  DASortmailList.m
//  TribeSDK
//
//  Created by LI LIN on 2013/04/26.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAShortmailList.h"
#import "DAShortmail.h"

@implementation DAShortmailList
+(Class) items_class {
    return [DAShortmail class];
}
@end
