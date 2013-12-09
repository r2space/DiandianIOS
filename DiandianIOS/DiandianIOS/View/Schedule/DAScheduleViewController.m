//
//  DAScheduleViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-12-6.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAScheduleViewController.h"
#import "ProgressHUD.h"

@interface DAScheduleViewController ()

@end

@implementation DAScheduleViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onCloseTouched:(id)sender {
    self.closeCallback();
}

- (IBAction)onConfirmTouched:(id)sender {
    
    [ProgressHUD show:nil];
    NSString *people = self.textPeople.text;
    NSString *phone = self.textPhone.text;
    NSString *time  = self.textTime.text;
    NSString *desk  = self.textDesk.text;
    if (people.length == 0 ) {
        [ProgressHUD showError:@"请选择人数"];
        return;
    }
    if (phone.length == 0 ) {
        [ProgressHUD showError:@"请填写电话"];
        return;
    }
    if (time.length == 0 ) {
        [ProgressHUD showError:@"请填写时间"];
        return;
    }
    if (desk.length == 0 ) {
        [ProgressHUD showError:@"请填写桌台"];
        return;
    }
    [[DAScheduleModule alloc]addSchedule:people phone:phone time:time desk:desk callback:^(NSError *err, DASchedule *schedule) {
        
        self.closeCallback();
        [ProgressHUD dismiss];
    }];
    
}

- (IBAction)onStepperFieldTouched:(id)sender {
    UIStepper *actualStepper = (UIStepper *)sender;
    
    self.textPeople.text = [NSString stringWithFormat:@"%d",(int)[actualStepper value]];
}

@end
