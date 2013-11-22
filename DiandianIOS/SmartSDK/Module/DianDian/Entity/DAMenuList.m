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
    [aCoder encodeObject:self.total forKey:@"total" ];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.items = [aDecoder decodeObjectForKey:@"items"];
    self.total = [aDecoder decodeObjectForKey:@"total"];
    
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
    NSLog(@"%@" ,fileName);
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

@end
