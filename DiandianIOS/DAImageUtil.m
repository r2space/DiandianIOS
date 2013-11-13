//
//  DAImageUtil.m
//  Report
//
//  Created by 李 林 on 12/05/17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DAImageUtil.h"
#import "DASettings.h"

@implementation DAImageUtil

// 画像サイズに合わせて、UIImageViewのサイズを調整する。ただ、一定の枠内で収まるようにする。
+ (void) changeImageViewSize:(UIView *)imgView originalImageSize:(CGSize)imageSize frame:(CGRect)frame {    
    float imgHeight;
    float imgWidth;
    float shiftImgX;
    float shiftImgY;

    if (frame.size.width / imageSize.width >= frame.size.height / imageSize.height) {
        imgHeight = frame.size.height;
        imgWidth  = frame.size.height * imageSize.width / imageSize.height;
        shiftImgX = abs(frame.size.width - imgWidth) / 2.0f + frame.origin.x;
        shiftImgY = frame.origin.y;
    } else {
        imgHeight = frame.size.width * imageSize.height / imageSize.width;
        imgWidth  = frame.size.width;
        shiftImgX = frame.origin.x;
        shiftImgY = abs(frame.size.height - imgHeight) / 2.0f + frame.origin.y;
    }

    // 描画時の画像変形を防ぐため、高さを幅を整数にする
    imgView.frame = CGRectMake(ceilf(shiftImgX), ceilf(shiftImgY), ceilf(imgWidth), ceilf(imgHeight));
    _printf(@"frame x:%f, y:%f, width:%f, height:%f", imgView.frame.origin.x, imgView.frame.origin.y, 
                                                      imgView.frame.size.width, imgView.frame.size.height);
}

+ (void) changeImageBackgroundViewSize:(UIView *)backgroundImgView
                               imgView:(UIView *)imgView
                                 shift:(CGFloat)shift
                                border:(CGFloat)border {
    float imgHeight = imgView.frame.size.height + border;
    float imgWidth = imgView.frame.size.width + border;
    float shiftImgX = imgView.frame.origin.x - shift;
    float shiftImgY = imgView.frame.origin.y - shift;
    
    backgroundImgView.frame = CGRectMake(shiftImgX, shiftImgY, imgWidth, imgHeight);
}

// 画像ファイルを生成
+ (NSString *)generateImageFile {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYYMMddhhmmss"];
    return [NSString stringWithFormat:@"%@.jpg", [formatter stringFromDate:[NSDate date]]];
}

// 画像のリサイズ
//   originalImage : オリジナル画像
//   frameSize     : 画像を入れるフレームのサイズ
//   imageSize     : 変換後の画像のサイズ
+ (UIImage *) resizeImage:(UIImage *)originalImage frameSize:(CGSize)frameSize imageSize:(CGSize)imageSize {
    [UIView commitAnimations];
    
    // グラフィックスコンテキストを作る
    UIGraphicsBeginImageContext(frameSize);
    
    // 画像を縮小して描画する
    CGRect rect;
    rect.origin = CGPointZero;
    rect.size = imageSize;
    [originalImage drawInRect:rect];
    
    // 描画した画像を取得する
    UIImage *shrinkedImage;
    shrinkedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return shrinkedImage;
}

// 画像に合わせて調整した、画像を表示するImageViewのサイズを取得
// 縦の画像の場合、立て一杯で横幅を調整
+ (CGSize) shrinkedImageSize:(UIImage *)image ownerView:(UIView *)imageView {
    _printf(@"width:%f, height:%f", image.size.width, image.size.height);
    
    CGSize ctx = imageView.frame.size;
    CGSize img = image.size;
    
    if (img.width >= img.height) {
        return CGSizeMake(ctx.width,    ctx.width * img.height / img.width);
    }
    
    return CGSizeMake(ctx.height * img.width / img.height, ctx.height);
}


// 画像の解像度を落とす
+ (NSData *)jpegResolutionDown:(UIImage *)image {
    return [self jpegResolutionDown:image maxSize:kMaxImageSize];
}

+ (NSData *)jpegResolutionDown:(UIImage *)image maxSize:(NSUInteger)maxSize {
    CGFloat compressionQuality = 1;
    NSData *jpegData = [[NSData alloc] initWithData: UIImageJPEGRepresentation( image, compressionQuality )];
    
    while (jpegData.length > maxSize) {
        compressionQuality -=  0.2f;
        jpegData = [[NSData alloc] initWithData: UIImageJPEGRepresentation( image, compressionQuality )];
    }
    
    return jpegData;
}

@end
