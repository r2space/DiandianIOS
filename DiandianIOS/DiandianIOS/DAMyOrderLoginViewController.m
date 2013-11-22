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


@interface DAMyOrderLoginViewController ()
{
    DrawPatternLockViewController *lockVC;
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

    
}



- (void)lockEntered:(NSString*)key {
    NSLog(@"key: %@", key);
    
    if (![key isEqualToString:@"010509"]) {
        [ProgressHUD showError:@"手势密码验证错误。"];
    } else {
        self.labelStatus.text = @"通过";
        [lockVC.view removeFromSuperview];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (void)backmenuButtonClicked:(DAMyOrderLoginViewController*)loginViewViewController;
//- (void)cancelOrderButtonClicked:(DAMyOrderLoginViewController*)loginViewViewController;
//- (void)confirmOrderButtonClicked:(DAMyOrderLoginViewController*)loginViewViewController;
-(void) touchedConfirmOrder:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(confirmOrderButtonClicked:)]) {
        [self.delegate confirmOrderButtonClicked:self];
    }
}

-(void) touchedCancelOrder :(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelOrderButtonClicked:)]) {
        [self.delegate cancelOrderButtonClicked:self];
    }
}

- (IBAction)confirmOrderTouched:(id)sender {
    
    if ([self.labelName.text isEqualToString:@"嘀嗒嘀嗒"] && [self.labelStatus.text isEqualToString:@"通过"]) {

        if (self.delegate && [self.delegate respondsToSelector:@selector(confirmOrderButtonClicked:)]) {
            [self.delegate confirmOrderButtonClicked:self];
        }
        
    } else {
        [ProgressHUD showError:@"请验证手势密码"];
        
    }
}

- (IBAction)cancelOrderTouched:(id)sender {

    if ([self.labelName.text isEqualToString:@"嘀嗒嘀嗒"] && [self.labelStatus.text isEqualToString:@"通过"]){
        if (self.delegate && [self.delegate respondsToSelector:@selector(cancelOrderButtonClicked:)]) {
            [self.delegate cancelOrderButtonClicked:self];
        }
    }
    
}

- (IBAction)backOrderTouched:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(backmenuButtonClicked:)]) {
        [self.delegate backmenuButtonClicked:self];
    }

}
- (IBAction)passwordTouched:(id)sender {
    // Do any additional setup after loading the view from its nib.
    
    [lockVC setTarget:self withAction:@selector(lockEntered:)];
    lockVC.view.frame = CGRectMake(0, 0, 468, 300);
    [self addChildViewController:lockVC];
    [self.view addSubview:lockVC.view];
}

@end
