//
//  DAPickAmountViewController.m
//  DiandianIOS
//
//  Created by Antony on 14-1-11.
//  Copyright (c) 2014年 DAC. All rights reserved.
//

#import "DAPickAmountViewController.h"

@interface DAPickAmountViewController ()

@end

@implementation DAPickAmountViewController

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

#pragma mark -

#pragma mark UIPickerViewDataSource



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView

{
    
    return 2;     //这个picker里的组键数
    
}



- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    
    return 10;  //数组个数
    
}

#pragma mark -

#pragma mark UIPickerViewDelegate

/************************重头戏来了************************/

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view

{
    
    UILabel *myView = nil;
    
    if (component == 0) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 30, 30)];
        myView.text = [NSString stringWithFormat:@"%d",row];

    }else {
        
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 30, 30)];
        myView.text = [NSString stringWithFormat:@"%d",row];
        
    }
    myView.tag = 20;
    return myView;
    
}



- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component

{
    
    CGFloat componentWidth = 0.0;
    
    
    if (component == 0)
        
        componentWidth = 30.0; // 第一个组键的宽度
    
    else
        
        componentWidth = 30.0; // 第2个组键的宽度
    
    
    return componentWidth;
    
}



- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0;
    
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{

    int rowOfFontComponent = [pickerView selectedRowInComponent:0];

    int rowOfColorComponent = [pickerView selectedRowInComponent:1];

    UIView *ViewOfFontComponent = (UILabel *)[pickerView viewForRow:rowOfFontComponent forComponent:0];
    UIView *ViewOfColorComponent =(UILabel *) [pickerView viewForRow:rowOfColorComponent forComponent:1];
    UILabel *viewOnViewofFontComponent=(UILabel *)[ViewOfFontComponent viewWithTag:20];
    UILabel *viewOnViewOfColorComponent=(UILabel *)[ViewOfColorComponent viewWithTag:20];
    NSLog(@"view %@   %@ " ,viewOnViewofFontComponent.text,viewOnViewOfColorComponent.text);
    self.selectedNum(viewOnViewofFontComponent.text,viewOnViewOfColorComponent.text);
}

@end
