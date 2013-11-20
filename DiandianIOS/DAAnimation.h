//
//  DAAnimation.h
//  DiandianIOS
//
//  Created by Xu Yang on 11/14/13.
//  Copyright (c) 2013 DAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAAnimation : NSObject

//增加订单效果
+(void) addOrderAnimation :(UIButton*)button withSupview:(id)withSupview;

// UIView追加闪烁阴影效果
+ (void) addFlickerShadow:(UIView*)view shadowColor:(UIColor*)color shadowRadius:(float)shadowRadius;
// UIView移除闪烁阴影效果
+ (void) removeFlickerShadow:(UIView*)view;
@end
