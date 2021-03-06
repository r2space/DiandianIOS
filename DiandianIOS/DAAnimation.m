//
//  DAAnimation.m
//  DiandianIOS
//
//  Created by Xu Yang on 11/14/13.
//  Copyright (c) 2013 DAC. All rights reserved.
//

#import "DAAnimation.h"
#import "DAMyMenuBookViewController.h"
#import "DAMenuProxy.h"

#define MENU_FRAME_WIDTH    876
#define MENU_FRAME_HEIGHT   694

@implementation DAAnimation

//广告的动画
+(void) addAdAnimation :(UIImageView *)imageView imageList: (NSArray *) imageList
{
//    int count = [imageList count];
//    ImageUpBlock imageupBlock;
//    int it = 0;
//    imageupBlock = ^(NSString *image,int i){
//        [DAAnimation changeImage:imageView image:image it:i callback:^(int imageIt) {
//            if (imageIt == count) {
//                imageIt = 0;
//            }
//            NSString *imageStr =  [imageList objectAtIndex:imageIt];
//            imageupBlock(imageStr ,imageIt);
//        }];
//    };
//    imageupBlock([imageList objectAtIndex:it],1);

}
+(void)changeImage:(UIImageView *)imageView image:(NSString *)image it:(int)it callback:(void (^)(int imageIt ))callback
{
    
    
}

// 增加来一份的动画
+(void) addSmallOrderAnimation :(UIButton*)button withSupview:(DAMyMenuBookViewController *)withSupview
{
    
    UIView *buttonSuperview = [button superview];
    UIView *cellSuperview  = [button superview];
    UIImageView *subimage = (UIImageView *)[buttonSuperview viewWithTag:102];
    CGRect markRect = [cellSuperview convertRect:subimage.bounds toView:withSupview.view];
    UIImageView *tempView = [[UIImageView alloc]initWithFrame:markRect];
    tempView.image = subimage.image;
    
    //    [tempView didMoveToWindow];
    [withSupview.view.superview addSubview:tempView];
    
    [UIView animateWithDuration:0.5 animations:^{
        tempView.frame = CGRectMake(0, 0, 70, 50);
        //        tempView.center = CGPointMake(20, 66);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            tempView.frame = CGRectMake(-110, 0, 70, 50);
            //        tempView.center = CGPointMake(20, 66);
        } completion:^(BOOL finished) {
            
            
        }];
        
    }];
}
// 增加来一份的动画
+(void) addOrderAnimation :(UIButton*)button withSupview:(DAMyMenuBookViewController *)withSupview
{
    
    UIView *buttonSuperview = [button superview];
    UIView *cellSuperview  = [buttonSuperview superview];
    UIImageView *subimage = (UIImageView *)[buttonSuperview viewWithTag:102];
    CGRect markRect = [cellSuperview convertRect:subimage.bounds toView:withSupview.view];
    UIImageView *tempView = [[UIImageView alloc]initWithFrame:markRect];
    tempView.image = subimage.image;
    
    //    [tempView didMoveToWindow];
    [withSupview.view.superview addSubview:tempView];
    
    [UIView animateWithDuration:0.5 animations:^{
        tempView.frame = CGRectMake(0, 0, 70, 50);
        //        tempView.center = CGPointMake(20, 66);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            tempView.frame = CGRectMake(-110, 0, 70, 50);
            //        tempView.center = CGPointMake(20, 66);
        } completion:^(BOOL finished) {
            
            
        }];
        
    }];
}

// 追加UIView闪烁效果
// 因为圆脚效果和阴影不能很好的同时存在，所以通过在superview中追加阴影层来实现
+ (void) addFlickerShadow:(UIView*)view shadowColor:(UIColor*)color shadowRadius:(float)shadowRadius
{
    // 取得当前UIView的阴影层
    CALayer *sublayer;
    for (CALayer *l in view.superview.layer.sublayers) {
        if ([l.name isEqualToString:@"ViewShadowPath"]) {
            sublayer = l;
            break;
        }
    }

    if(sublayer == nil) { // 生成阴影层
        sublayer = [CALayer layer];
        sublayer.name = @"ViewShadowPath";
        sublayer.frame = CGRectMake(view.frame.origin.x -2, view.frame.origin.y + 2, view.frame.size.width, view.frame.size.height);
        sublayer.backgroundColor = [UIColor clearColor].CGColor;
        sublayer.shadowColor = color.CGColor;
        sublayer.shadowOffset = CGSizeMake(0, 0);
        sublayer.shadowRadius = shadowRadius;
        sublayer.masksToBounds = NO;
        sublayer.cornerRadius = shadowRadius;
        sublayer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(-5 , -5, view.bounds.size.width + 10, view.bounds.size.height + 10)].CGPath;
        //将该层添加在当前UIView的layer下面
        [view.superview.layer insertSublayer:sublayer below:view.layer];
    }
    
    // 为这个阴影层追加动画效果
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
    [sublayer addAnimation:keyframe forKey:@"flickerShadow"];
}

// 取消UIView闪烁效果
+ (void) removeFlickerShadow:(UIView*)view
{
    // 取得当前UIView的阴影层
    CALayer *sublayer;
    for (CALayer *l in view.superview.layer.sublayers) {
        if ([l.name isEqualToString:@"ViewShadowPath"]) {
            sublayer = l;
            break;
        }
    }
    
    if(sublayer != nil) { // 移除动画效果
        [sublayer removeAnimationForKey:@"flickerShadow"];
        sublayer.shadowOpacity = 0;
    }
}
@end
