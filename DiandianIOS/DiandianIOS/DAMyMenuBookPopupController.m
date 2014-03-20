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
#import "NSString+Util.h"

@interface DAMyMenuBookPopupController ()<DAMyMenuBookPopupDelegate>{
    NSArray *opsBtns;
    UIColor *ios7BlueColor ;
}

@end

@implementation DAMyMenuBookPopupController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        ios7BlueColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    opsBtns = [NSArray arrayWithObjects:self.optBtn1,self.optBtn2,self.optBtn3,self.optBtn4, nil];

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
    
    [self.viewImage setImage:[DAMenuProxy getImageFromDisk:self.curItem.smallimage]];
    
    
    if ( self.curItem.itemPriceHalf!=nil&&self.curItem.itemPriceHalf.length >0 ) {
        self.labelPrice.text = [NSString stringWithFormat:@"大%@元/小%@元",self.curItem.itemPriceNormal,self.curItem.itemPriceHalf];
        [self.btnSmallAdd setHidden:NO];
    } else {
        self.labelPrice.text = [NSString stringWithFormat:@"%@元",self.curItem.itemPriceNormal];
        [self.btnSmallAdd setHidden:YES];
    }




    if([self.from isEqualToString:@"menubook"]){
        self.btnBigAdd.hidden = NO;
        self.btnConfirm.hidden = YES;
    }else{
        self.btnBigAdd.hidden = YES;
        self.btnSmallAdd.hidden = YES;
        self.btnConfirm.hidden = NO;
    }



    NSArray  *opts= [self.curItem.selectedOption componentsSeparatedByString:@" "];


    for (int j = 0; j < [opsBtns count]; j++) {
         if(j < [self.curItem.option count]){
             //((UIButton *)[opsBtns objectAtIndex:j]).titleLabel.text = [self.curItem.option objectAtIndex:j];
             UIButton *btn = [opsBtns objectAtIndex:j];
             [btn setTitle: [self.curItem.option objectAtIndex:j] forState:UIControlStateNormal];
             [btn setHidden:NO];

             for(id opt in opts){
                 if([btn.titleLabel.text isEqualToString:opt]){
                     btn.backgroundColor = ios7BlueColor;
                     [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                 }
             }
         }else{
             [((UIButton *) [opsBtns objectAtIndex:j]) setHidden:YES];
         }
    }

    if([NSString isNotEmpty:self.curItem.noteName]){
        self.optInputLabel.text = self.curItem.noteName;
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
    [self appendOptionToOrder];
    NSNotification *addOrderNotification = [NSNotification notificationWithName:@"menu_addOrder" object:self.curItem];
    
    [[NSNotificationCenter defaultCenter] postNotification:addOrderNotification];
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
        [ProgressHUD showSuccess:@"点菜成功"];
    }
}

- (IBAction)onAddSmallTouched:(id)sender {
    [self appendOptionToOrder];
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
- (IBAction)optBtnTouched:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if([btn.backgroundColor isEqual:ios7BlueColor]){
         btn.backgroundColor = [UIColor clearColor];
        [btn setTitleColor:ios7BlueColor forState:UIControlStateNormal];
    }else{
        btn.backgroundColor = ios7BlueColor;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }

    
}
- (IBAction)optAddBtnTouched:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"输入备注信息" message:@"描述菜品口味,名称等" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
          self.optInputLabel.text = [alertView textFieldAtIndex:0].text;
    }
}

- (void)appendOptionToOrder{
    NSMutableString *str = [[NSMutableString alloc] init];
    for (int j = 0; j < opsBtns.count; j++) {
        UIButton *btn = [opsBtns objectAtIndex:j];

        if([[btn titleColorForState:UIControlStateNormal] isEqual:[UIColor whiteColor]] && !btn.hidden){
            [str appendString:[NSString stringWithFormat:@" %@",btn.titleLabel.text]];
        }
    }
    self.curItem.selectedOption = str;

    NSMutableString *noteName = [[NSMutableString alloc] init];
    if([NSString isNotEmpty:self.optInputLabel.text]){
        [noteName appendString:[NSString stringWithFormat:@" %@",self.optInputLabel.text]];
        self.curItem.noteName = noteName;
    }
}
- (IBAction)confirmTouched:(id)sender {
    [self appendOptionToOrder];
    NSNotification *notice = [NSNotification notificationWithName:@"menu_modifyMenuItem" object:self.curItem];
    [[NSNotificationCenter defaultCenter] postNotification:notice];
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
        [ProgressHUD showSuccess:@"修改成功"];
    }
}

@end
