//
//  DAPrintProxy.h
//  DiandianIOS
//
//  Created by Antony on 13-11-29.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ePOS-Print.h"

@interface DAPrintProxy : NSObject

- (void)addLine:(NSString *)text;
- (void)addLineBreak;
- (void)addSplit;
- (void)addSplit:(int)length;
- (int)printText;

@end
