//
//  DADevice.h
//  RenrakuNote
//
//  Created by ドリームアーツ on 2013/01/08.
//  Copyright (c) 2013年 ドリームアーツ. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DADeviceDelegate
- (void)deviceDidRotate:(NSNotification *)notification;
@end

@interface DADevice : NSObject

@property (strong) id delegate;

- (id)initWithDelegate:(id)delegateObj;
+ (CGRect)getScreenFrameForCurrentOrientation;
+ (CGRect)getScreenFrameForCurrentOrientation:(UIInterfaceOrientation)orientation;
+ (BOOL)isLandscapeAfterRotation;
+ (BOOL)isLandscape:(UIInterfaceOrientation)orientation;

@end
