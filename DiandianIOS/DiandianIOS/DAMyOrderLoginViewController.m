//
//  DAMyOrderLoginViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-13.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAMyOrderLoginViewController.h"

@interface DAMyOrderLoginViewController ()

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
    // Do any additional setup after loading the view from its nib.
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(confirmOrderButtonClicked:)]) {
        [self.delegate confirmOrderButtonClicked:self];
    }
}

- (IBAction)cancelOrderTouched:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelOrderButtonClicked:)]) {
        [self.delegate cancelOrderButtonClicked:self];
    }
}

- (IBAction)backOrderTouched:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(backmenuButtonClicked:)]) {
        [self.delegate backmenuButtonClicked:self];
    }

}

- (IBAction)actionBackTouched:(id)sender {
}
- (IBAction)fdfd:(id)sender {
}
@end
