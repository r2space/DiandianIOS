//
//  DAKeyboardObserver.h
//  Angel
//
//  Created by ドリームアーツ on 2012/12/06.
//  Copyright (c) 2012年 ドリームアーツ. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DAKeyboardObserverDelegate
- (void)resizeViews:(CGRect)keyboardFrame;
@end

@interface DAKeyboardObserver : NSObject

@property (strong, nonatomic) id delegate;
@property (strong, nonatomic) NSArray *resizableViews;
@property (strong, nonatomic) NSMutableArray *originalFrames;
@property BOOL isKeyboardVisible;

- (void)registerKeyboardObserverWithDelegate:(id)delegateObj;
- (void)unregisterKeyboardObserver;
- (void)saveOriginalDesign:(NSArray *)views;

@end
