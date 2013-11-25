//
//  DAOrderList.m
//  DiandianIOS
//
//  Created by Antony on 13-11-22.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "SmartSDK.h"

@implementation DAMyOrderList

+(Class) items_class {
    return [DAOrder class];
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.items forKey:@"items" ];
    [aCoder encodeObject:self.totalItems forKey:@"totalItems" ];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.items = [aDecoder decodeObjectForKey:@"items"];
    self.totalItems = [aDecoder decodeObjectForKey:@"totalItems"];
    
    return  self;
}

-(NSMutableArray*)toArray{
    NSMutableArray *tmpList = [[NSMutableArray alloc]init];
    
    for (DAOrder *order in self.items) {
        NSDictionary *orderDic = [order toDictionary];
//        if (order.isNew !=nil ) {
            [tmpList addObject:orderDic];
//        }

    }
    return tmpList;
}


@end
