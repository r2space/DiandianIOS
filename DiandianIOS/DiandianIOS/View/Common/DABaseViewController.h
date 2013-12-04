//
//  DABaseViewController.h
//  DiandianIOS
//
//  Created by Antony on 13-12-3.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartSDK.h"
#import "DrawPatternLockViewController.h"
#import "ProgressHUD.h"

@interface DABaseViewController : UIViewController
{
    DrawPatternLockViewController *lockVC;
    BOOL lockStatus;
}

@end
