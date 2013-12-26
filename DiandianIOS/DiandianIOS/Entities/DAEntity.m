//
//  DAEntity.m
//  DiandianIOS
//
//  Created by Antony on 13-11-21.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAEntity.h"

@implementation DAEntity



-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self._id   forKey:@"_id"];
    [aCoder encodeObject:self.createat forKey:@"createat"];
    [aCoder encodeObject:self.createby forKey:@"createby"];
    [aCoder encodeObject:self.editat forKey:@"editat"];
    [aCoder encodeObject:self.editby forKey:@"editby"];
    [aCoder encodeObject:self.valid forKey:@"valid"];
    
    
    [aCoder encodeObject:self._status forKey:@"_status"];
    [aCoder encodeObject:self._error forKey:@"_error"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self._id = [aDecoder decodeObjectForKey:@"_id"];
    self.createat = [aDecoder decodeObjectForKey:@"createat"];
    self.createby = [aDecoder decodeObjectForKey:@"createby"];
    self.editat = [aDecoder decodeObjectForKey:@"editat"];
    self.editby = [aDecoder decodeObjectForKey:@"editby"];
    self.valid = [aDecoder decodeObjectForKey:@"valid"];
    
    self._status = [aDecoder decodeObjectForKey:@"_status"];
    self._error = [aDecoder decodeObjectForKey:@"_error"];
    
    return self;
}





-(BOOL ) archiveRootObjectWithName :(NSString *) withName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentDir = [paths objectAtIndex:0];
    NSString *sContentsDir = [documentDir stringByAppendingPathComponent:@"entity"];
    if(![[NSFileManager defaultManager] fileExistsAtPath:sContentsDir]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:sContentsDir withIntermediateDirectories:NO attributes:nil error:&error];
    }
    NSString *fileName = [NSString stringWithFormat:@"%@/%@", sContentsDir, withName];
    return [NSKeyedArchiver archiveRootObject:self toFile:fileName];
}

-(id ) unarchiveObjectWithFileWithName :(NSString *) withName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentDir = [paths objectAtIndex:0];
    NSString *sContentsDir = [documentDir stringByAppendingPathComponent:@"entity"];
    if(![[NSFileManager defaultManager] fileExistsAtPath:sContentsDir]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:sContentsDir withIntermediateDirectories:NO attributes:nil error:&error];
    }
    NSString *fileName = [NSString stringWithFormat:@"%@/%@", sContentsDir, withName];
    return [NSKeyedUnarchiver unarchiveObjectWithFile: fileName];
}



-(BOOL ) archiveRootObjectWithPath:(NSString *) withPath withName :(NSString *)withName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentDir = [paths objectAtIndex:0];
    NSString *sContentsDir = [documentDir stringByAppendingPathComponent:withPath];
    if(![[NSFileManager defaultManager] fileExistsAtPath:sContentsDir]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:sContentsDir withIntermediateDirectories:NO attributes:nil error:&error];
    }
    NSString *fileName = [NSString stringWithFormat:@"%@/%@", sContentsDir, withName];
    return [NSKeyedArchiver archiveRootObject:self toFile:fileName];
}

-(id ) unarchiveObjectWithFileWithPath:(NSString *) withPath withName :(NSString *)withName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentDir = [paths objectAtIndex:0];
    NSString *sContentsDir = [documentDir stringByAppendingPathComponent:withPath];
    if(![[NSFileManager defaultManager] fileExistsAtPath:sContentsDir]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:sContentsDir withIntermediateDirectories:NO attributes:nil error:&error];
    }
    NSString *fileName = [NSString stringWithFormat:@"%@/%@", sContentsDir, withName];
    return [NSKeyedUnarchiver unarchiveObjectWithFile: fileName];
}


@end
