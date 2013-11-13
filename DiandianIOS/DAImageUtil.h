//
//  DAImageUtil.h
//  Report
//
//  Created by 李 林 on 12/05/17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kMaxImageSize       300 * 1024

@interface DAImageUtil : NSObject

+ (void) changeImageViewSize:(UIView *)imgView
           originalImageSize:(CGSize)imageSize
                       frame:(CGRect)frame;

+ (void) changeImageBackgroundViewSize:(UIView *)backgroundImgView
                               imgView:(UIView *)imgView
                                 shift:(CGFloat)shift
                                border:(CGFloat)border;

+ (NSString *)generateImageFile;
+ (UIImage *)resizeImage:(UIImage *)originalImage frameSize:(CGSize)frameSize imageSize:(CGSize)imageSize;
+ (CGSize)shrinkedImageSize:(UIImage *)image ownerView:(UIView *)imageView;
+ (NSData *)jpegResolutionDown:(UIImage *)image;
+ (NSData *)jpegResolutionDown:(UIImage *)image maxSize:(NSUInteger)maxSize;

@end
