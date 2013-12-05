//
//  DAMyOrderLoginViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-13.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAMyOrderLoginViewController.h"
#import "DrawPatternLockViewController.h"
#import "ProgressHUD.h"
#import "SmartSDK.h"


@interface DAMyOrderLoginViewController ()
{
    DrawPatternLockViewController *lockVC;
    NSString *willSave;
    int errorCount;
}
@end

@implementation DAMyOrderLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    lockVC = [[DrawPatternLockViewController alloc] init];
    willSave = [NSString stringWithFormat:@"confirm"];
    //判断输入三次返回
    errorCount = 0 ;
    self.labelName.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.diandian.curWaitterUserName"];
}



- (void)lockEntered:(NSString*)key {
    NSLog(@"key: %@", key);
    
    NSString *WaitterId = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.diandian.curWaitterUserId"];
    
    [[DALoginModule alloc]checkPattern:key userId:WaitterId callback:^(NSError *error, NSDictionary *user) {
        NSLog(@"user key %@" ,user);
        NSNumber *isRight = [user objectForKey:@"isRight"];
        
        if (![isRight boolValue]) {
            errorCount++;
            [ProgressHUD showError:@"手势密码验证错误。"];
            if (errorCount == 3) {
                [lockVC.view removeFromSuperview];
            }

        } else {

            if ([willSave isEqualToString:@"confirm"]) {
                //验证后直接开台
                if (self.delegate && [self.delegate respondsToSelector:@selector(confirmOrderButtonClicked:)]) {
                    [self.delegate confirmOrderButtonClicked:self];
                }
                
            }
            if ([willSave isEqualToString:@"cancel"]) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(cancelOrderButtonClicked:)]) {
                    [self.delegate cancelOrderButtonClicked:self];
                }
                
            }
        }
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)confirmOrderTouched:(id)sender {
    willSave = [NSString stringWithFormat:@"confirm"];
    errorCount = 0 ;
    [ProgressHUD showError:@"请验证手势密码"];
    [lockVC setTarget:self withAction:@selector(lockEntered:)];
    lockVC.view.frame = CGRectMake(0, 0, 556, 349);
    [self addChildViewController:lockVC];
    [self.view addSubview:lockVC.view];
}

- (IBAction)cancelOrderTouched:(id)sender {
    
    willSave = [NSString stringWithFormat:@"cancel"];
    errorCount = 0;
    [ProgressHUD showError:@"请验证手势密码"];
    [lockVC setTarget:self withAction:@selector(lockEntered:)];
    lockVC.view.frame = CGRectMake(0, 0, 556, 349);
    [self addChildViewController:lockVC];
    [self.view addSubview:lockVC.view];
    
}

- (IBAction)backOrderTouched:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(backmenuButtonClicked:)]) {
        [self.delegate backmenuButtonClicked:self];
    }

}


@end
