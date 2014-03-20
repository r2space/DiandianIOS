//
//  DAMyMenuBookPopupController.h
//  DiandianIOS
//
//  Created by Antony on 13-11-12.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmartSDK.h"


@protocol DAMyMenuBookPopupDelegate;
@interface DAMyMenuBookPopupController : UIViewController<UIAlertViewDelegate>

@property (assign, nonatomic) id <DAMyMenuBookPopupDelegate>delegate;
- (IBAction)backTouched:(id)sender;
- (IBAction)orderTouched:(id)sender;
- (IBAction)backThumbTouched:(id)sender;


@property (retain, nonatomic) DAItem  *curItem;
@property (strong, nonatomic) NSString *from;

@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
@property (weak, nonatomic) IBOutlet UIImageView *viewImage;
@property (weak, nonatomic) IBOutlet UILabel *labelMaterial;
@property (weak, nonatomic) IBOutlet UILabel *labelAmount;

@property (weak, nonatomic) IBOutlet UIButton *btnClose;

@property (weak, nonatomic) IBOutlet UITextView *textItemMaterial;
@property (weak, nonatomic) IBOutlet UITextView *textItemComment;
@property (weak, nonatomic) IBOutlet UITextView *textItemMethod;

@property (weak, nonatomic) IBOutlet UIButton *btnSmallAdd;
@property (weak, nonatomic) IBOutlet UIButton *btnBigAdd;
@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;


@property (weak, nonatomic) IBOutlet UIButton *optBtn1;
@property (weak, nonatomic) IBOutlet UIButton *optBtn2;
@property (weak, nonatomic) IBOutlet UIButton *optBtn3;
@property (weak, nonatomic) IBOutlet UIButton *optBtn4;
@property (weak, nonatomic) IBOutlet UIButton *optBtnAdd;
@property (weak, nonatomic) IBOutlet UILabel *optInputLabel;

@end

@protocol DAMyMenuBookPopupDelegate<NSObject>

@optional
- (void)cancelButtonClicked:(DAMyMenuBookPopupController*) popupViewController;
@end
