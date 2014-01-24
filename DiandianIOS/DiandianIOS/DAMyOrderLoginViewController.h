//
//  DAMyOrderLoginViewController.h
//  DiandianIOS
//
//  Created by Antony on 13-11-13.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAPopTableViewController.h"
#import "SmartSDK.h"
#import "DAPosIO.h"
#import "ePOS-Print.h"

@class EposPrint;
@protocol OpenPrinterDelegate
- (void)onOpenPrinter:(EposPrint*)prn
            ipaddress:(NSString*)ipaddress
          printername:(NSString*)printername
             language:(int)language;
@end

@protocol DAMyOrderLoginDelegate;

@interface DAMyOrderLoginViewController : UIViewController<DAPopTableViewDelegate,UITextFieldDelegate,OpenPrinterDelegate>
{
    id<OpenPrinterDelegate> delegate_;
}
@property (weak, nonatomic) IBOutlet UITextField *labelName;

@property (weak, nonatomic) IBOutlet UITextField *labelTips;
@property (retain, nonatomic) NSString *curUserId;
@property (nonatomic, retain) DAService *curService;

@property (nonatomic, retain) EposPrint *printer;
@property (nonatomic, retain) EposPrint *printer121;
@property (nonatomic, retain) EposPrint *printer120;

@property (assign, nonatomic) id <DAMyOrderLoginDelegate>delegate;
@property (assign, nonatomic) id <DAPosIODelegate> posDelegate;
@property (assign, nonatomic) id <OpenPrinterDelegate> openDelegate;


@property (weak, nonatomic) IBOutlet UILabel *lblPrinter;




@end

@protocol DAMyOrderLoginDelegate<NSObject>

@optional
- (void)backmenuButtonClicked:(DAMyOrderLoginViewController*)loginViewViewController;
- (void)cancelOrderButtonClicked:(DAMyOrderLoginViewController*)loginViewViewController;
- (void)confirmOrderButtonClicked:(DAMyOrderLoginViewController*)loginViewViewController;
@end
