//
//  DADelegateUtil.h
//  Angel
//
//  Created by ドリームアーツ on 2012/12/06.
//  Copyright (c) 2012年 ドリームアーツ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DADelegateUtil : NSObject

+ (void)callbackDelegate:(id)delegateObj withSelector:(SEL)selector;
+ (void)callbackDelegate:(id)delegateObj withSelector:(SEL)selector withParameter:(id)parm;
+ (void)callbackDelegate:(id)delegateObj withSelector:(SEL)selector withParameter1:(id)parm1 withParameter2:(id)parm2;

@end
