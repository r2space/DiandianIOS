//
//  DAYiWorkStation.m
//  TribeSDK
//
//  Created by kita on 13-9-15.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAYiWorkStation.h"
#import "DAYiWorkStationMenu.h"

@implementation DAYiWorkStation
+(Class) items_class {
    return [DAYiWorkStationMenu class];
}
@end
