//
//  DATakeoutLoginViewController.h
//  DiandianIOS
//
//  Created by Antony on 13-12-3.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DABaseViewController.h"

typedef void(^ConfirmCallback)();

@interface DATakeoutLoginViewController :DABaseViewController

@property (nonatomic, copy) ConfirmCallback confirmCallback;
@property (weak, nonatomic) IBOutlet UITextField *textPhone;

@end
