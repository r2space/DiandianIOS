//
//  DASettingViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-28.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DASettingViewController.h"
#import "DrawPatternLockViewController.h"
#import "DAMenuProxy.h"
#import "ProgressHUD.h"
#import "OpenUDID.h"
#import "DAPrintProxy.h"
#import "DARootViewController.h"

@interface DASettingViewController ()
{
    DrawPatternLockViewController *lockVC;
    
    BOOL lockStatus;
    BOOL setLock1;
    BOOL setLock2;
    BOOL isLogin;
    NSString *setPassword1;
    NSString *setPassword2;
    NSString *setPassword;
}

@end

@implementation DASettingViewController

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
    lockStatus = NO;
    setLock1 = NO;
    setLock2 = NO;
    isLogin = NO;
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    self.labVersion.text = version;
    NSString *_username = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.diandian.username"];
    
    NSString *_password = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.diandian.password"];
    
    NSString *_isLogin = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.diandian.isLogin"];
    
    if (_username != nil && _username.length >0 ) {
        self.labUsername.text = _username;
    } else {
        self.labUsername.text = @"";
    }
    
    if(_password != nil && _password.length > 0) {
        self.labPassword.text = _password;
    } else {
        self.labPassword.text = @"";
    }
    
    if (_isLogin != nil && [@"YES" isEqualToString:_isLogin]) {
        isLogin = YES;
    }
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    self.labLoginStatus.text = @"";
    //检查用户手势密码
//    [[NSUserDefaults standardUserDefaults] setValue:user._id forKey:@"jp.co.dreamarts.smart.diandian.curWaitterUserId"];
    NSString *curWaitterUserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.diandian.curWaitterUserId"];
    
    NSString *curWaitterKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.diandian.curWaitterKey"];
    
    
    if (curWaitterKey !=nil && curWaitterKey.length > 0 && curWaitterUserId != nil && curWaitterUserId.length > 0) {
        
        [[DALoginModule alloc]checkPattern:curWaitterKey userId:curWaitterUserId callback:^(NSError *error, NSDictionary *user) {
            
            NSNumber *isRight = [user objectForKey:@"isRight"];
            
            if ([isRight integerValue] == -1) {
                
                [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"jp.co.dreamarts.smart.diandian.curWaitterKeyStatus"];
                
                return ;
            }
            
            if (![isRight boolValue]) {
                
                [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"jp.co.dreamarts.smart.diandian.curWaitterKeyStatus"];
                
            } else {
                [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"jp.co.dreamarts.smart.diandian.curWaitterKeyStatus"];
                
            }
            
        }];
    } else {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"jp.co.dreamarts.smart.diandian.curWaitterKeyStatus"];
        
    }

    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onBackTouched:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)onLoginTouched:(id)sender {
    NSString *userName = self.labUsername.text;
    NSString *password = self.labPassword.text;
    if (userName.length == 0) {
        [ProgressHUD showError:@"请输入用户名。"];
        return;
    }
    if (password.length == 0) {
        [ProgressHUD showError:@"请输入密码。"];
        return;
    }
    [[DALoginModule alloc]yukarilogin:userName password:password code:nil callback:^(NSError *error, DAUser *user) {
        
        if (error != nil) {
            isLogin = NO;
            [ProgressHUD showError:@"登录失败"];
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"jp.co.dreamarts.diandian.isLogin"];
            return;
        }
        
        isLogin = YES;
        self.labLoginStatus.text = @"登录成功";
        [ProgressHUD showSuccess:@"登录成功"];
        
        [[NSUserDefaults standardUserDefaults] setValue:userName forKey:@"jp.co.dreamarts.smart.diandian.username"];
        [[NSUserDefaults standardUserDefaults] setValue:password forKey:@"jp.co.dreamarts.smart.diandian.password"];
        
        [[NSUserDefaults standardUserDefaults] setValue:user._id forKey:@"jp.co.dreamarts.smart.diandian.userId"];
        
        [[NSUserDefaults standardUserDefaults] setValue:user._id forKey:@"jp.co.dreamarts.smart.diandian.curWaitterUserId"];
        
        [[NSUserDefaults standardUserDefaults] setValue:user.userName forKey:@"jp.co.dreamarts.smart.diandian.curWaitterUserName"];
        
        [[NSUserDefaults standardUserDefaults] setValue:user.cash forKey:@"jp.co.dreamarts.smart.diandian.curWaitterHasCash"];
        
        
        [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:@"jp.co.dreamarts.smart.diandian.isLogin"];
        
        
    }];
}



- (IBAction)onUpdateMenuTouched:(id)sender {
    
    if (isLogin) {
        [DAMenuProxy getMenuListApiList];
    } else {
        [ProgressHUD showSuccess:@"请登录"];
    }
    
}

- (IBAction)onSetPasswordTouched:(id)sender {
    // Do any additional setup after loading the view from its nib.
    if (isLogin) {
        lockStatus = NO;
        setLock1 = NO;
        setLock2 = NO;
        setPassword1 = @"";
        setPassword2 = @"";
        [lockVC setTarget:self withAction:@selector(lockEntered:)];
        lockVC.view.frame = CGRectMake(0,44, 540, 620);
        [self addChildViewController:lockVC];
        [self.view addSubview:lockVC.view];
    } else {
        [ProgressHUD showSuccess:@"请登录"];
    }
    
}
- (IBAction)onTestPrintTouched:(id)sender {
    
    
    if (isLogin) {
        //测试打印机
        [DAPrintProxy testPrinter];
    } else {
        [ProgressHUD showError:@"请登录"];
    }
    

}

- (void)lockEntered:(NSString*)key {
    
    if (isLogin) {
        NSLog(@"key: %@", key);
        NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"jp.co.dreamarts.smart.diandian.userId"];
        if (!setLock1 && !setLock2 && !lockStatus) {
            setPassword1 = key;
            setLock1 = YES;
            [ProgressHUD showSuccess:@"请确认你的设置。"];
            return;
        }
        if (setLock1 && !setLock2 && !lockStatus) {
            if ([setPassword1 isEqualToString:key]) {
                setPassword2 = key;
                setLock2 = YES;
                [[DALoginModule alloc]updatePattern:key userId:userId callback:^(NSError *error, DAUser *user) {
                    [lockVC.view removeFromSuperview];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:key forKey:@"jp.co.dreamarts.smart.diandian.curWaitterKey"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"jp.co.dreamarts.smart.diandian.curWaitterKeyStatus"];
                    
                    [ProgressHUD showSuccess:@"手势密码设置成功。"];
                    setPassword = key;
                    lockStatus = YES;
                }];
                
            } else {
                setPassword1 = @"";
                setLock1 = NO;
                [ProgressHUD showError:@"两次密码不同，请重新设置。"];
            }
        }
    }
    
    
}

- (IBAction)onStartTouched:(id)sender {
    
    if (isLogin) {
        //TODO:检查打印机链接
        DAPrinterList *printList = [[DAPrinterList alloc] unarchiveObjectWithFileWithPath:@"printer" withName:@"printer"];
        if (printList == nil || [printList.items count] == 0) {
            [ProgressHUD showError:@"打印机未设置"];
            return;
        }
        
        NSNumber *printerMaster = [[NSUserDefaults standardUserDefaults] objectForKey:@"com.diandain.printer.master"];
        if ([printerMaster boolValue]) {
            for (DAPrinter *printSet in printList.items) {
                if ([printSet.valid isEqualToNumber:[NSNumber numberWithInt:0]]) {
                    [ProgressHUD showError:[NSString stringWithFormat:@"请检查打印机 ：%@ 的状态" ,printSet.name]];
                    return;
                }
            }
        }

        
        NSString *keyStatus = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.diandian.curWaitterKeyStatus"];
        if (![@"YES" isEqualToString:keyStatus]) {
            [ProgressHUD showError:@"请设置手势密码"];
            return;
        }
        
        self.startupBlock();
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [ProgressHUD showError:@"请登录"];
    }
    
}


- (IBAction)onDeviceApplyTouched:(id)sender {
    if (isLogin) {
        
        NSString *userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"jp.co.dreamarts.smart.diandian.userId"];;
        NSString *uuid = [OpenUDID value];
        NSString *deviceId = uuid;
        NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:@"jp.co.dreamarts.smart.message.devicetoken"];
        
        [[DALoginModule alloc] addDevice:deviceId userId:userId token:token callback:^(NSError *error, DAMyDevice *device) {
            [ProgressHUD showSuccess:@"设备申请成功  可以使用"];
        }];
    } else {
        [ProgressHUD showError:@"请登录"];
    }
}
-(void)dismissVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onMenuViewTouched:(id)sender {
    self.menuViewBlock();
}

@end
