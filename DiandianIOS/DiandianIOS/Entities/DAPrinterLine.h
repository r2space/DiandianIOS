//
//  DAPrinterLine.h
//  DiandianIOS
//
//  Created by Antony on 14-1-22.
//  Copyright (c) 2014年 DAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAPrinterLine : NSObject

@property (retain, nonatomic) NSString  *printerName;
@property (retain, nonatomic) NSString  *printerIp;
@property (retain, nonatomic) NSArray   *printerLines;
@property (retain, nonatomic) NSString  *printerType;
@property (retain, nonatomic) NSString  *printerStatus;
@property (retain, nonatomic) NSString  *printerTextSize;
@property (retain, nonatomic) NSString  *printerTextHeight;


@end
