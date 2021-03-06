//
//  ZenKeyboard.h
//  ZenKeyboard
//
//  Created by Kevin Nick on 2012-11-9.
//  Copyright (c) 2012年 com.zen. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KEYBOARD_NUMERIC_KEY_WIDTH 80
#define KEYBOARD_NUMERIC_KEY_HEIGHT 69

@protocol ZenKeyboardDelegate <NSObject>

- (void)numericKeyDidPressed:(int)key;
- (void)backspaceKeyDidPressed;

@end

@interface ZenKeyboard : UIView

@property (nonatomic, assign) UITextField *textField;

@property (retain, nonatomic) NSMutableString *num;

@end
