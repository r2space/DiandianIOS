//
//  DATakeoutLoginViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-12-3.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DATakeoutLoginViewController.h"

@interface DATakeoutLoginViewController ()

@end

@implementation DATakeoutLoginViewController

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
    
    
}

- (IBAction)onStartTakeoutTouched:(id)sender {
    if (self.textPhone.text.length == 0) {
        [ProgressHUD showError:@"请输入外面电话号码"];
        return;
    }
    [lockVC setTarget:self withAction:@selector(lockEntered:)];
    lockVC.view.frame = CGRectMake(0, 0, 300, 300);
    [self addChildViewController:lockVC];
    [self.view addSubview:lockVC.view];
}


- (void)lockEntered:(NSString*)key {
    NSLog(@"key: %@", key);
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.diandian.userId"];
    [[DALoginModule alloc]checkPattern:key userId:userId callback:^(NSError *error, NSDictionary *user) {
        NSNumber *isRight = [user objectForKey:@"isRight"];
        
        if (![isRight boolValue]) {
            
            [ProgressHUD showError:@"手势密码验证错误。"];
            
            
        } else {
            [[DAServiceModule alloc] startService:@"-1" userId:userId type:@"3" people:@"1" phone:self.textPhone.text callback:^(NSError *err, DAService *service) {
                self.confirmCallback();
                lockStatus = NO;
                [lockVC.view removeFromSuperview];
                
            }];

        }
    }];
    
    if([@"090807" isEqualToString:key]){
        [lockVC.view removeFromSuperview];
    }

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
