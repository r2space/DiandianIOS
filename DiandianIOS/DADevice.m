//
//  DADevice.m
//  RenrakuNote
//
//  Created by ドリームアーツ on 2013/01/08.
//  Copyright (c) 2013年 ドリームアーツ. All rights reserved.
//

#import "DADevice.h"
#import "DADelegateUtil.h"

@implementation DADevice

- (id)initWithDelegate:(id)delegateObj {
    
    self = [super init];
    
    if (self) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didRotate:)
                                                     name:@"UIDeviceOrientationDidChangeNotification" object:nil];
        _delegate = delegateObj;
    }
    return self;
}

- (void)didRotate:(NSNotification *)notification {
    
    // 画面の向きが不明の場合はコールバックしない
    if (UIDeviceOrientationUnknown != [[UIDevice currentDevice] orientation]) {
        [DADelegateUtil callbackDelegate:self.delegate withSelector:@selector(deviceDidRotate:) withParameter:notification];
    }
}

+ (CGRect)getScreenFrameForCurrentOrientation {
    
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    
    // Portrait
    CGRect frame = screenFrame;
    
    // Landscapeの場合は、縦横変換
    if ([self isLandscapeAfterRotation]) {
        frame.size.width = screenFrame.size.height;
        frame.size.height = screenFrame.size.width;
    }
    
    return frame;
}

+ (CGRect)getScreenFrameForCurrentOrientation:(UIInterfaceOrientation)orientation {
    
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    
    // Portrait
    CGRect frame = screenFrame;
    
    // Landscapeの場合は、縦横変換
    if ([self isLandscape:orientation]) {
        frame.size.width = screenFrame.size.height;
        frame.size.height = screenFrame.size.width;
    }
    
    return frame;
}

+ (BOOL)isLandscapeAfterRotation {
    
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if (UIDeviceOrientationLandscapeLeft == orientation || UIDeviceOrientationLandscapeRight == orientation) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)isLandscape:(UIInterfaceOrientation)orientation {
    
    if (UIInterfaceOrientationLandscapeLeft == orientation || UIInterfaceOrientationLandscapeRight == orientation) {
        return YES;
    } else {
        return NO;
    }
}

@end
