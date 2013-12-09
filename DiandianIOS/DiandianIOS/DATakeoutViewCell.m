//
//  DATakeoutViewCell.m
//  DiandianIOS
//
//  Created by Xu Yang on 11/19/13.
//  Copyright (c) 2013 DAC. All rights reserved.
//

#import "DATakeoutViewCell.h"
#import "DATakeoutViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "DAPopTableViewController.h"


#import "DARootViewController.h"
#import "DABillViewController.h"

#import "NSString+Util.h"
#import "Util.h"
#import "Tool.h"


@interface DATakeoutViewCell()
@property (strong, nonatomic) IBOutlet UITextField *type;

@property (weak, nonatomic) IBOutlet UILabel *labelCreateAt;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumber;

@property (weak, nonatomic) IBOutlet UILabel *unFinish;

@property (strong, nonatomic) IBOutlet UITextField *state;

@property (strong, nonatomic) IBOutlet UIPopoverController *popover;

@end


@implementation DATakeoutViewCell
{
    UIViewController *parentVC;
    DAService* takeoutService;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void) initData:(DAService*) service parentViewController:(UIViewController*)parent
{
    parentVC = parent;
    takeoutService = service;
    
    self.delegate = (id)parentVC;
    
    // Num
//    self.num.text = takeout.num;
    // Type
    
    
    // Phone Number
    self.phoneNumber.text = takeoutService.phone;
    self.unFinish.text = [NSString stringWithFormat:@"%@",takeoutService.unfinishedCount];
    self.labelCreateAt.text = [ Tool stringFromISODateString:takeoutService.createat];
    
    // State
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)onMenuBookTouched:(id)sender {
    UIStoryboard *menubookStoryboard = [UIStoryboard storyboardWithName:@"DARootView" bundle:nil];
    DARootViewController *menubookVC = [menubookStoryboard instantiateViewControllerWithIdentifier:@"menubookVC"];
    menubookVC.curService = takeoutService;
    [parentVC.navigationController pushViewController:menubookVC animated:YES];
    [parentVC dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

- (IBAction)onOrderListTouched:(id)sender {
    
}

- (IBAction)onBillTouched:(id)sender {
    DABillViewController *viewController = [[DABillViewController alloc]
                                            initWithNibName:@"DABillViewController" bundle:nil];
    viewController.curService = takeoutService;
    
    [parentVC.navigationController pushViewController:viewController animated:YES];
    [parentVC dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

@end
