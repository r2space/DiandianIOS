//
//  DAAnimation.m
//  DiandianIOS
//
//  Created by Xu Yang on 11/14/13.
//  Copyright (c) 2013 DAC. All rights reserved.
//

#import "DAAnimation.h"

@implementation DAAnimation

+ (void) addFlickerShadow:(UIView*)view shadowColor:(UIColor*)color
{
    view.layer.shadowColor = color.CGColor;
    view.layer.shadowOffset = CGSizeMake(0, 0);
    view.layer.masksToBounds = NO;
    
    view.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(-5 , -5, view.bounds.size.width + 10, view.bounds.size.height + 10)].CGPath;
    
    
    CAKeyframeAnimation *keyframe = [CAKeyframeAnimation animationWithKeyPath:@"shadowOpacity"];
    keyframe.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:1.0],
                       [NSNumber numberWithFloat:0.9],
                       [NSNumber numberWithFloat:0.8],
                       [NSNumber numberWithFloat:0.7],
                       [NSNumber numberWithFloat:0.6],
                       [NSNumber numberWithFloat:0.5],
                       [NSNumber numberWithFloat:0.4],
                       [NSNumber numberWithFloat:0.3],
                       [NSNumber numberWithFloat:0.2],
                       [NSNumber numberWithFloat:0.1],
                       [NSNumber numberWithFloat:0.2],
                       [NSNumber numberWithFloat:0.3],
                       [NSNumber numberWithFloat:0.4],
                       [NSNumber numberWithFloat:0.5],
                       [NSNumber numberWithFloat:0.6],
                       [NSNumber numberWithFloat:0.7],
                       [NSNumber numberWithFloat:0.8],
                       [NSNumber numberWithFloat:0.9],
                       [NSNumber numberWithFloat:1.0],nil];
    keyframe.repeatCount = MAXFLOAT;
    keyframe.autoreverses = YES;
    keyframe.duration = 0.8;
    [view.layer addAnimation:keyframe forKey:@"flickerShadow"];
}

+ (void) removeFlickerShadow:(UIView*)view
{
    [view.layer removeAnimationForKey:@"flickerShadow"];
    
    view.layer.shadowOpacity = 0;
}
@end
