//
//  DAProcession.h
//  DiandianIOS
//
//  Created by Xu Yang on 11/18/13.
//  Copyright (c) 2013 DAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"

@interface DATakeout : Jastor

@property(retain, nonatomic) NSString *takeoutId;
@property(retain, nonatomic) NSString *num;
@property(retain, nonatomic) NSString *type;
@property(retain, nonatomic) NSString *phoneNumber;
@property(retain, nonatomic) NSString *state;
@property(retain, nonatomic) NSString *menuId;
@end
