
//  DAMenuModule.h
//  DiandianIOS
//
//  Created by Antony on 13-11-6.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAMenuModule : NSObject
{
    NSString *name;
    NSString *price;
    NSString *type;
    NSString *image;
    NSString *index;
}

-(id)initWithDictionary:(NSDictionary *)aDict;

@property (strong)      NSString *name;
@property (strong)  NSString *price;
@property (strong) NSString *type;
@property (strong)  NSString *image;
@property (strong)  NSString *index;

@end
