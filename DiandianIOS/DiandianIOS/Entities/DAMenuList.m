//
//  DAMyMenuList.m
//  TribeSDK
//
//  Created by Antony on 13-11-9.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "SmartSDK.h"


@implementation DAMenuList
@synthesize items;

+(Class) items_class {
    return [DAMenu class];
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

-(BOOL ) archiveRootObject
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentDir = [paths objectAtIndex:0];
    NSString *sContentsDir = [documentDir stringByAppendingPathComponent:@"menudata"];
    if(![[NSFileManager defaultManager] fileExistsAtPath:sContentsDir]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:sContentsDir withIntermediateDirectories:NO attributes:nil error:&error];
    }
    NSString *fileName = [NSString stringWithFormat:@"%@/%@", sContentsDir, @"__data_menu_list"];
    return [NSKeyedArchiver archiveRootObject:self toFile:fileName];
}

-(DAMenuList *) unarchiveObjectWithFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentDir = [paths objectAtIndex:0];
    NSString *sContentsDir = [documentDir stringByAppendingPathComponent:@"menudata"];
    if(![[NSFileManager defaultManager] fileExistsAtPath:sContentsDir]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:sContentsDir withIntermediateDirectories:NO attributes:nil error:&error];
    }
    NSString *fileName = [NSString stringWithFormat:@"%@/%@", sContentsDir, @"__data_menu_list"];
    return [NSKeyedUnarchiver unarchiveObjectWithFile: fileName];
}

-(NSMutableArray*)toArray{
    NSMutableArray *tmpList = [[NSMutableArray alloc]init];
    
    for (DAMenu *order in self.items) {
        NSDictionary *orderDic = [order toDictionary];
        [tmpList addObject:orderDic];
    }
    return tmpList;
}


@end
