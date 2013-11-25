//
//  DADispatch.m
//  DiandianIOS
//
//  Created by Antony on 13-11-25.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DADispatch.h"
#import "DAOrderProxy.h"
#import "DAMyTableViewController.h"

@implementation DADispatch


+(void )dealWithAction:(NSString *)action data:(id)data
{
    
    if ([@"refreshOrder" isEqualToString:action]) {
        
        [DAOrderProxy refreshOrderList:data];
        
    } else {
        
        
        
        [DAOrderProxy refreshOrderList:data];
    }
 
    if ([@"refresh_desk" isEqualToString:action]) {
        [DAMyTableViewController receive:action data:data];
    }
    
}

@end
