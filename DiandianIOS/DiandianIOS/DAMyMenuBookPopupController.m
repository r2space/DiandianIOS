//
//  DAMyMenuBookPopupController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-12.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAMyMenuBookPopupController.h"

@interface DAMyMenuBookPopupController ()<DAMyMenuBookPopupDelegate>

@end

@implementation DAMyMenuBookPopupController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//@property (weak, nonatomic) IBOutlet UILabel *labelName;
//@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
//@property (weak, nonatomic) IBOutlet UIImageView *viewImage;
//@property (weak, nonatomic) IBOutlet UILabel *labelMaterial;
//@property (weak, nonatomic) IBOutlet UILabel *labelAmount;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
    // Do any additional setup after loading the view from its nib.
}
- (void) initUI
{
    self.labelName.text = self.menuData.name;
    self.labelAmount.text = self.menuData.amount;
    [self.viewImage setImage:[UIImage imageNamed:self.menuData.image]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backTouched:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
    }
}

- (IBAction)orderTouched:(id)sender {
    NSLog(@"dfdaf  data  %@  " ,self.menuData.name);
    NSNotification *orderReloadNotification = [NSNotification notificationWithName:@"orderReload" object:self.menuData];
    [[NSNotificationCenter defaultCenter] postNotification:orderReloadNotification];
}

- (IBAction)backThumbTouched:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
    }
}
@end
