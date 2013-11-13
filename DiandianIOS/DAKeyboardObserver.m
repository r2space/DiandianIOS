//
//  DAKeyboardObserver.m
//  Angel
//
//  Created by ドリームアーツ on 2012/12/06.
//  Copyright (c) 2012年 ドリームアーツ. All rights reserved.
//
#import "DAKeyboardObserver.h"
#import "DADelegateUtil.h"

@implementation DAKeyboardObserver

BOOL mRegisteredFlag = NO;
BOOL mResized = NO;
/*------------------------------------------------------------------------------------------------*/
#pragma mark - 通知の登録
/*------------------------------------------------------------------------------------------------*/
- (void)registerKeyboardObserverWithDelegate:(id)delegateObj {
    
    self.delegate = delegateObj;
    self.originalFrames = [NSMutableArray array];
    mResized = NO;
    
    if (!mRegisteredFlag) {
        
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        
        // iPad3対応（iPad3以降では、KeyboardWillShow, DidShow, WillHideなどは呼ばれない。）
        [center addObserver:self
                   selector:@selector(keyboardWillChange:)
                       name:UIKeyboardWillChangeFrameNotification
                     object:nil];
        
        [center addObserver:self
                   selector:@selector(keyboardWillShow:)
                       name:UIKeyboardWillShowNotification
                     object:nil];
        [center addObserver:self
                   selector:@selector(keyboardDidShow:)
                       name:UIKeyboardDidShowNotification
                     object:nil];
        [center addObserver:self
                   selector:@selector(keyboardWillHide:)
                       name:UIKeyboardWillHideNotification
                     object:nil];
        
        mRegisteredFlag = YES;
        self.isKeyboardVisible = NO;
    }
}

- (void)unregisterKeyboardObserver {
    
    self.resizableViews = nil;
    self.delegate = nil;
    
    if (mRegisteredFlag) {
        
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        
        [center removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
        [center removeObserver:self name:UIKeyboardDidShowNotification object:nil];
        [center removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [center removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        
        mRegisteredFlag = NO;
    }
}

/*------------------------------------------------------------------------------------------------*/
#pragma mark - キーボードが出入りした際の処理
/*------------------------------------------------------------------------------------------------*/

- (void)keyboardWillChange:(NSNotification *)notification {
    
    if (self.isKeyboardVisible) {
        [self keyboardWillHide:notification];
    } else {
        [self keyboardWillShow:notification];
        [self keyboardDidShow:notification];
    }
    
    self.isKeyboardVisible = !self.isKeyboardVisible;
}

- (void)keyboardWillShow:(NSNotification *)notification {
    
    if (!mResized) {
        NSDictionary *userInfo = [notification userInfo];
        NSTimeInterval duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        UIViewAnimationCurve animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
        
        void (^animations)(void);
        animations = ^(void) {
            
            // キーボードが出現した際のデザインは、各画面で異なるため、デザインの変更処理は呼び元で行う。
            if (self.delegate) {
                if ([self.delegate respondsToSelector:@selector(resizeViews:)]) {
                    [self.delegate resizeViews:[self getKeyboardSize:notification]];
                }
            }
        };
        
        [UIView animateWithDuration:duration
                              delay:0.0
                            options:(animationCurve << 16)
                         animations:animations
                         completion:nil];
    }
    
    mResized = YES;
}

- (void)keyboardDidShow:(NSNotification *)notification {
    [DADelegateUtil callbackDelegate:self.delegate withSelector:@selector(keyboardDidShow)];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    
    if (mResized) {
        
        NSTimeInterval duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        UIViewAnimationCurve animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
        
        void (^animations)(void);
        animations = ^(void) {
            
            // 元のデザインに復帰
            [self restoreOriginalDesign];
        };
        [UIView animateWithDuration:duration
                              delay:0.0
                            options:(animationCurve << 16)
                         animations:animations
                         completion:nil];
        
        mResized = NO;
    }
}

/*------------------------------------------------------------------------------------------------*/
#pragma mark - ビューのリサイズのためのユーティリティ
/*------------------------------------------------------------------------------------------------*/
- (void)saveOriginalDesign:(NSArray *)views {
    
    self.resizableViews = views;
    
    for (UIView *resizableView in self.resizableViews) {
        
        CGRect originalFrame = resizableView.frame;
        // 元のデザイン情報を保持
        [self.originalFrames addObject:[NSValue valueWithCGRect:originalFrame]];
        
    }
}

- (void)restoreOriginalDesign {
    
    NSInteger index = 0;
    for (UIView *view in self.resizableViews) {
        
        CGRect originalFrame = [[self.originalFrames objectAtIndex:index] CGRectValue];
        index++;
        
        // 元の場所・サイズに戻す
        view.frame = originalFrame;
    }
}

- (CGRect)getKeyboardSize:(NSNotification *)notification {
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    UIWindow *window = [[[UIApplication sharedApplication] windows]objectAtIndex:0];
    UIView *mainSubviewOfWindow = window.rootViewController.view;
    CGRect keyboardFrameConverted = [mainSubviewOfWindow convertRect:keyboardFrame fromView:window];
    return keyboardFrameConverted;
}

@end
