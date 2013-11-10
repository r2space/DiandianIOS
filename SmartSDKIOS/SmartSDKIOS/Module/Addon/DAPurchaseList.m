//
//  DAPurchaseList.m
//  TribeSDK
//
//  Created by LI LIN on 2013/06/03.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAPurchase.h"
#import "DAPurchaseList.h"

@implementation DAPurchaseList

+(Class) items_class {
    return [DAPurchase class];
}

@end
