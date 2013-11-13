//
//  DADelegateUtil.m
//  Angel
//
//  Created by ドリームアーツ on 2012/12/06.
//  Copyright (c) 2012年 ドリームアーツ. All rights reserved.
//

#import "DADelegateUtil.h"

@implementation DADelegateUtil

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
+ (void)callbackDelegate:(id)delegateObj withSelector:(SEL)selector {
    if (delegateObj) {
        if ([delegateObj respondsToSelector:selector]) {
            
            [delegateObj performSelector:selector];
        }
    }
}
#pragma clang diagnostic pop

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
+ (void)callbackDelegate:(id)delegateObj withSelector:(SEL)selector withParameter:(id)parm {
    if (delegateObj) {
        if ([delegateObj respondsToSelector:selector]) {
            
            [delegateObj performSelector:selector withObject:parm];
        }
    }
}
#pragma clang diagnostic pop

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
+ (void)callbackDelegate:(id)delegateObj withSelector:(SEL)selector withParameter1:(id)parm1 withParameter2:(id)parm2 {
    if (delegateObj) {
        if ([delegateObj respondsToSelector:selector]) {
            
            [delegateObj performSelector:selector withObject:parm1 withObject:parm2];
        }
    }
}
#pragma clang diagnostic pop

@end
