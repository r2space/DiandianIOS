//
//  DARightSideMenuViewController.m
//  DiandianIOS
//
//  Created by 罗浩 on 14-3-10.
//  Copyright (c) 2014年 DAC. All rights reserved.
//

#import "DARightSideMenuViewController.h"

@interface DARightSideMenuViewController ()
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *openBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
@property (weak, nonatomic) IBOutlet UIButton *hidBtn;

@end

@implementation DARightSideMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.cornerRadius = 5;
    self.view.layer.masksToBounds = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    DDLogWarn(@"didReceiveMemoryWarning  :  %@" ,[self class]);
}

- (void)setTarget:(id)target
   withHideAction:(SEL)action1
       openAction:(SEL)action2
        addAction:(SEL)action3
       backAction:(SEL)action4
      checkAction:(SEL)action5
     changeAction:(SEL)action6 {
    _target = target;
    _hideAction = action1;
    _openAction = action2;
    _addAction = action3;
    _backAction = action4;
    _checkAction = action5;
    _changeAction = action6;
}
- (IBAction)hideTouched:(id)sender {
    [_target performSelector:_hideAction];
}
- (IBAction)openTouched:(id)sender {
    [_target performSelector:_openAction];
}
- (IBAction)addTouched:(id)sender {
    [_target performSelector:_addAction];
}
- (IBAction)backTouched:(id)sender {
    [_target performSelector:_backAction];
}
- (IBAction)checkTouched:(id)sender {
    [_target performSelector:_checkAction];
}
- (IBAction)changeTouched:(id)sender {
    [_target performSelector:_changeAction];
}

- (void)changeMode:(BOOL)isEmpty{
    if(!isEmpty){
        self.addBtn.hidden = NO;
        self.backBtn.hidden = NO;
        self.checkBtn.hidden = NO;
        self.changeBtn.hidden = NO;
        self.openBtn.hidden = YES;
    }else{
        self.addBtn.hidden = YES;
        self.backBtn.hidden = YES;
        self.checkBtn.hidden = YES;
        self.changeBtn.hidden = YES;
        self.openBtn.hidden = NO;
    }
}

@end
