//
//  DALayoutList.m
//  TribeSDK
//
//  Created by kita on 13-8-30.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DALayoutList.h"
#import "DALayout.h"

@implementation DALayoutList
@synthesize items;
+(Class) items_class {
    return [DALayout class];
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.items forKey:@"items"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.items = [aDecoder decodeObjectForKey:@"items"];
    return self;
}


-(BOOL)contains:(NSString *)layoutId
{
    for (DALayout *layout in self.items) {
        if ([layout._id isEqualToString:layoutId]) {
            return YES;
        }
    }
    return NO;
}

-(void)replaceLayout:(DALayout *)layout appendWhenNotFind:(BOOL)append
{
    NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithArray:self.items];
    for (int i=0; i<tmpArray.count; i++) {
        DALayout *tmpLayout = [tmpArray objectAtIndex:i];
        if ([tmpLayout._id isEqualToString:layout._id]) {
            [tmpArray replaceObjectAtIndex:i withObject:layout];
            self.items = tmpArray;
            return;
        }
    }
    if (append) {
        [tmpArray addObject:layout];
        self.items = tmpArray;
    }
}

-(void)removeLayoutById:(NSString *)layoutId
{
    NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithArray:self.items];
    for (int i=0; i<tmpArray.count; i++) {
        DALayout *tmpLayout = [tmpArray objectAtIndex:i];
        if ([tmpLayout._id isEqualToString:layoutId]) {
            [tmpArray removeObjectAtIndex:i];
            self.items = tmpArray;
            return;
        }
    }
}
@end
