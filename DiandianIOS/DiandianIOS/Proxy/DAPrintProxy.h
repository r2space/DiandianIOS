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
- (int)printText:(NSString *)ip addTextSize:(long) addTextSize TextHeight:(long)TextHeight;


+(void) addOrderPrintWithOrderList:(DAMyOrderList *)orderList deskName:(NSString *)deskName orderNum:(NSString * )orderNum now:(NSString *)now takeout:(NSString *) takeout tips:(NSString *)tips;

+(void) printBill: (NSString *) serviceId off:(NSString *)off pay:(NSString *)pay type:(NSInteger * )type reduce :(NSString *)reduce;

+(void) testPrinter;

@end
