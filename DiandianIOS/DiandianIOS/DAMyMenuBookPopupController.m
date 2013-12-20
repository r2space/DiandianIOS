//
//  DAMyMenuBookPopupController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-12.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAMyMenuBookPopupController.h"
#import "DAMenuProxy.h"
#import "ProgressHUD.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = YES;
    
    self.btnClose.layer.cornerRadius = 20;
    self.btnClose.layer.masksToBounds = YES;
    
    [self initUI];
    // Do any additional setup after loading the view from its nib.
}
- (void) initUI
{
    
    self.labelName.text = self.curItem.itemName;
    

    
    self.textItemMethod.text = [NSString stringWithFormat:@"%@", self.curItem.itemMethod];
    self.textItemComment.text = [NSString stringWithFormat:@"%@",self.curItem.itemComment];
    self.textItemMaterial.text = [NSString stringWithFormat:@"%@" ,self.curItem.itemMaterial];
    
    [self.viewImage setImage:[DAMenuProxy getImageFromDisk:self.curItem.bigimage]];
    
    
    if ( self.curItem.itemPriceHalf!=nil&&self.curItem.itemPriceHalf.length >0 ) {
        self.labelPrice.text = [NSString stringWithFormat:@"大%@元/小%@元",self.curItem.itemPriceNormal,self.curItem.itemPriceHalf];
        [self.btnSmallAdd setHidden:NO];
    } else {
        self.labelPrice.text = [NSString stringWithFormat:@"%@元",self.curItem.itemPriceNormal];
        [self.btnSmallAdd setHidden:YES];
    }
    
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
    NSNotification *orderReloadNotification = [NSNotification notificationWithName:@"orderReload" object:self.curItem];
    [[NSNotificationCenter defaultCenter] postNotification:orderReloadNotification];
}

//点菜机能
- (IBAction)onAddTouched:(id)sender {
    NSNotification *addOrderNotification = [NSNotification notificationWithName:@"menu_addOrder" object:self.curItem];
    
    [[NSNotificationCenter defaultCenter] postNotification:addOrderNotification];
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
        [ProgressHUD showSuccess:@"点菜成功"];
    }
}

- (IBAction)onAddSmallTouched:(id)sender {
    NSNotification *notice = [NSNotification notificationWithName:@"menu_addSmallItem" object:self.curItem];
    
    [[NSNotificationCenter defaultCenter] postNotification:notice];
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
        [ProgressHUD showSuccess:@"点菜成功"];
    }
}

- (IBAction)backThumbTouched:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
    }
}
@end
