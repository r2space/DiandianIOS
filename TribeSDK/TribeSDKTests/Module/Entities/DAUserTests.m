//
//  DAUserTests.m
//  TribeSDK
//
//  Created by LI LIN on 2013/04/19.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "DAUserTests.h"

@implementation DAUserTests


- (void)testSear
{
    
    DAUser *u = [[DAUser alloc] init];
    u.following = [NSArray arrayWithObjects:@"東京", @"名古屋", @"大阪", nil];
    u.name = [[UserName alloc] init];
    u.name.name_zh = @"lalala";
    
    NSData *d = [NSKeyedArchiver archivedDataWithRootObject:u];
    
    
    DAUser *newu = [NSKeyedUnarchiver unarchiveObjectWithData:d];
    _printf(@"%@", newu.following);
    _printf(@"%@", newu.name.name_zh);
    
    
}

@end
