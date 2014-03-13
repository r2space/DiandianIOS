//
//  DARightSideMenuViewController.h
//  DiandianIOS
//
//  Created by 罗浩 on 14-3-10.
//  Copyright (c) 2014年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DARightSideMenuViewController : UIViewController {
    id _target;
    SEL _hideAction;
    SEL _openAction;
    SEL _addAction;
    SEL _backAction;
    SEL _checkAction;
    SEL _changeAction;
}
- (void)setTarget:(id)target
   withHideAction:(SEL)action1
       openAction:(SEL)action2
        addAction:(SEL)action3
       backAction:(SEL)action4
      checkAction:(SEL)action5
     changeAction:(SEL)action6;
- (void)changeMode:(BOOL)isEmpty;
@end
