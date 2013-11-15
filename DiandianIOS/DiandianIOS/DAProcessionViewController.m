//
//  DAProcessionViewController.m
//  DiandianIOS
//
//  Created by Xu Yang on 11/15/13.
//  Copyright (c) 2013 DAC. All rights reserved.
//

#import "DAProcessionViewController.h"
#import "UIViewController+MJPopupViewController.h"

@interface DAProcessionViewController ()

@end

@implementation DAProcessionViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void) show:(UIViewController *) parentView
{
    DAProcessionViewController *vc = [[DAProcessionViewController alloc]initWithNibName:@"DAProcessionViewController" bundle:nil];
    vc.delegate = (id)parentView;
    [parentView  presentPopupViewController:vc animationType:MJPopupViewAnimationFade];
    
    //parentVC = (id)parentView;
}

- (IBAction)closePopup:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
    }
}
- (IBAction)addProcession:(id)sender {
}
- (IBAction)openMyTable:(id)sender {
}
- (IBAction)orderFool:(id)sender {
}
@end
