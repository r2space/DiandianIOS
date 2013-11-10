//
//  DAPurchase.h
//  TribeSDK
//
//  Created by LI LIN on 2013/06/02.
//  Copyright (c) 2013年 LI LIN. All rights reserved.
//

#import "Jastor.h"

@interface DAPurchase : Jastor

@property (retain, nonatomic) NSString *_id;
@property (retain, nonatomic) NSString *date;               // 日期
@property (retain, nonatomic) NSString *category;           // 分类
@property (retain, nonatomic) NSString *name;               // 名称
@property (retain, nonatomic) NSString *amount;             // 数量
@property (retain, nonatomic) NSString *unit;               // 单位
@property (retain, nonatomic) NSString *inspection;         // 验货状态（拒收，有问题，合格）
@property (retain, nonatomic) NSString *order;              // 订货状态（未订，已订）
@property (retain, nonatomic) NSString *providerName;       // 供货商
@property (retain, nonatomic) NSString *providerPhone1;     // 供货商电话（主）
@property (retain, nonatomic) NSString *providerPhone2;     // 供货商电话（备用）
@property (retain, nonatomic) NSString *providerDescription;// 产品描述
@property (retain, nonatomic) NSString *realAmount;         // 实物数量
@property (retain, nonatomic) NSString *realDescription;    // 实物描述
@property (retain, nonatomic) NSString *realImage;          // 实物照片

@end

