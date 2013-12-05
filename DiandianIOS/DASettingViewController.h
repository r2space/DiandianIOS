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

@interface DASettingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *labUsername;
@property (weak, nonatomic) IBOutlet UITextField *labPassword;
@property (weak, nonatomic) IBOutlet UITextField *labPrintIP;

@property (nonatomic, copy) StartUpBlock startupBlock;

@property (weak, nonatomic) IBOutlet UILabel *labLoginstatus;

-(void)dismissVC;


@end
