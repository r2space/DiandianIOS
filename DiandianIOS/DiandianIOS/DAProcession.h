//
//  DAProcession.h
//  DiandianIOS
//
//  Created by Xu Yang on 11/18/13.
//  Copyright (c) 2013 DAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"

@interface DAProcession : Jastor<NSCoding>

@property(retain, nonatomic) NSString *processionId;
@property(retain, nonatomic) NSString *num;
@property(retain, nonatomic) NSString *numOfPeople;
@property(retain, nonatomic) NSString *order;
@end
