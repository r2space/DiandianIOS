//
//  DAPrintProxy.h
//  DiandianIOS
//
//  Created by Antony on 13-11-29.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ePOS-Print.h"
#import "SmartSDK.h"
@class  DAMyOrderList;

@interface DAPrintProxy : NSObject

- (void)addLine:(NSString *)text;
- (void)addLineBreak;
- (void)addSplit;
- (void)addSplit:(int)length;
- (int)printText;


+(void) addOrderPrintWithOrderList:(DAMyOrderList *)orderList deskName:(NSString *)deskName orderNum:(NSString * )orderNum;
@end
