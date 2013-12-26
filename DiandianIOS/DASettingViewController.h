//
//  DASettingViewController.h
//  DiandianIOS
//
//  Created by Antony on 13-11-28.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartSDK.h"
typedef void (^StartUpBlock)();
typedef void (^MenuViewBlock)();

@interface DASettingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *labUsername;
@property (weak, nonatomic) IBOutlet UITextField *labPassword;
@property (weak, nonatomic) IBOutlet UITextField *labPrintIP;
@property (weak, nonatomic) IBOutlet UILabel *labLoginStatus;

@property (nonatomic, copy) StartUpBlock startupBlock;
@property (nonatomic, copy) MenuViewBlock menuViewBlock;



-(void)dismissVC;


@end
