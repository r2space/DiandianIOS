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
    
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = YES;
    
    
}

- (IBAction)onStartTakeoutTouched:(id)sender {
    if (self.textPhone.text.length == 0) {
        [ProgressHUD showError:@"请输入外面电话号码"];
        return;
    }
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.diandian.userId"];
    [ProgressHUD show:nil];
    [[DAServiceModule alloc] startService:@"-1" userId:userId type:@"3" people:@"1" phone:self.textPhone.text callback:^(NSError *err, DAService *service) {
        self.confirmCallback();
        [ProgressHUD dismiss];
        
    }];
    
}
- (IBAction)onBackTouched:(id)sender {
    self.confirmCallback();
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    DDLogWarn(@"didReceiveMemoryWarning  :  %@" ,[self class]);
}

@end
