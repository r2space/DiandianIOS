//
//  DAPublishLayoutList.m
//  TribeSDK
//
//  Created by kita on 13-8-31.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAPublishLayoutList.h"
#import "DAPublishLayout.h"

@implementation DAPublishLayoutList
@synthesize items;
+(Class) items_class {
    return [DAPublishLayout class];
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.items forKey:@"items"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.items = [aDecoder decodeObjectForKey:@"items"];
    return  self;
}

-(BOOL)contains:(NSString *)publishLayoutId
{
    for (DAPublishLayout *publishLayout in self.items) {
        if ([publishLayout._id isEqualToString:publishLayoutId]) {
            return YES;
        }
    }
    return NO;
}

-(void)replacePublishLayout:(DAPublishLayout *)publishLayout appendWhenNotFind:(BOOL)append
{
    NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithArray:self.items];
    for (int i=0; i<tmpArray.count; i++) {
        DAPublishLayout *tmpLayout = [tmpArray objectAtIndex:i];
        if ([tmpLayout._id isEqualToString:publishLayout._id]) {
            [tmpArray replaceObjectAtIndex:i withObject:publishLayout];
            self.items = tmpArray;
            return;
        }
    }
    if (append) {
        [tmpArray addObject:publishLayout];
        self.items = tmpArray;
    }
}

-(void)removePublishLayoutById:(NSString *)layoutId
{
    NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithArray:self.items];
    for (int i=0; i<tmpArray.count; i++) {
        DAPublishLayout *tmpLayout = [tmpArray objectAtIndex:i];
        if ([tmpLayout._id isEqualToString:layoutId]) {
            [tmpArray removeObjectAtIndex:i];
            self.items = tmpArray;
            return;
        }
    }
}
@end
