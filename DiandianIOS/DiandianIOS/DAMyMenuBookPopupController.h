//
//  DAMyMenuBookPopupController.h
//  DiandianIOS
//
//  Created by Antony on 13-11-12.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAMyMenu.h"


@protocol DAMyMenuBookPopupDelegate;
@interface DAMyMenuBookPopupController : UIViewController

@property (assign, nonatomic) id <DAMyMenuBookPopupDelegate>delegate;
- (IBAction)backTouched:(id)sender;
- (IBAction)orderTouched:(id)sender;
- (IBAction)backThumbTouched:(id)sender;

@property (retain, nonatomic) NSString *tableNO;
@property (retain, nonatomic) DAMyMenu *menuData;

@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
@property (weak, nonatomic) IBOutlet UIImageView *viewImage;
@property (weak, nonatomic) IBOutlet UILabel *labelMaterial;
@property (weak, nonatomic) IBOutlet UILabel *labelAmount;

@end

@protocol DAMyMenuBookPopupDelegate<NSObject>

@optional
- (void)cancelButtonClicked:(DAMyMenuBookPopupController*) popupViewController;
@end
