//
//  DAPickAmountViewController.h
//  DiandianIOS
//
//  Created by Antony on 14-1-11.
//  Copyright (c) 2014年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^selectedNum)(NSString *first ,NSString *secend);
@interface DAPickAmountViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *picker1;

@property (nonatomic, copy) selectedNum selectedNum;

@end
