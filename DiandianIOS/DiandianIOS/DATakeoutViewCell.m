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
#import "NSString+Util.h"
#import "Util.h"

@interface DATakeoutViewCell()
@property (strong, nonatomic) IBOutlet UITextField *type;
@property (strong, nonatomic) IBOutlet UILabel *num;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumber;
@property (strong, nonatomic) IBOutlet UITextField *state;

@property (strong, nonatomic) IBOutlet UIPopoverController *popover;

@end


@implementation DATakeoutViewCell
{
    UIViewController *parentVC;
    DATakeout* takeout;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void) initData:(DATakeout*)t parentViewController:(UIViewController*)parent
{
    parentVC = parent;
    takeout = t;
    
    self.delegate = (id)parentVC;
    
    // Num
    self.num.text = takeout.num;
    // Type
    [self showType];
    
    // Phone Number
    self.phoneNumber.text = takeout.phoneNumber;
    
    // State
    [self showState];
}

- (void) showType
{
    self.type.delegate = self;
    if ([@"takeout" isEqualToString:takeout.type]) {
        self.type.text = @"打包";
        self.type.backgroundColor = [Util colorWithHexString:@"#8CD5DC"];
    } else if([@"deliver" isEqualToString:takeout.type]) {
        self.type.backgroundColor = [Util colorWithHexString:@"#E23B38"];
        self.type.text = @"外送";
    }
}
- (void) showState
{
    self.state.delegate = self;
    if ([@"nothing" isEqualToString:takeout.state]) {
        self.state.backgroundColor = [Util colorWithHexString:@"#8CD5DC"];
        self.state.text = @"无";
    } else if ([@"delivering" isEqualToString:takeout.state]) {
        self.state.backgroundColor = [Util colorWithHexString:@"#E23B38"];
        self.state.text = @"外送中";
    }
    
    if ([@"takeout" isEqualToString:takeout.type]) {
        [self.state setHidden:YES];
    } else if([@"deliver" isEqualToString:takeout.type]) {
        [self.state setHidden:NO];
    }
}

- (BOOL) textFieldShouldBeginEditing: (UITextField *)textField
{
    if ([textField isEqual:self.type]) {
        DAPopTableViewController *vc = [[DAPopTableViewController alloc] initWithNibName:@"DAPopTableViewController" bundle:nil];
        
        NSMutableArray *wList = [NSMutableArray array];
        [wList addObject:[NSString stringWithFormat:@"打包"]];
        [wList addObject:[NSString stringWithFormat:@"外送"]];
        
        [vc initData:@"type" list:wList];
        vc.delegate = self;
        
        self.popover = [[UIPopoverController alloc]initWithContentViewController:vc];
        self.popover.popoverContentSize = CGSizeMake(100, 400);
        [self.popover presentPopoverFromRect:textField.frame inView: self permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
        return NO;
    }
    if ([textField isEqual:self.state]) {
        DAPopTableViewController *vc = [[DAPopTableViewController alloc] initWithNibName:@"DAPopTableViewController" bundle:nil];
        
        NSMutableArray *wList = [NSMutableArray array];
        [wList addObject:[NSString stringWithFormat:@"无"]];
        [wList addObject:[NSString stringWithFormat:@"送餐中"]];
        
        [vc initData:@"state" list:wList];
        vc.delegate = self;
        
        self.popover = [[UIPopoverController alloc]initWithContentViewController:vc];
        self.popover.popoverContentSize = CGSizeMake(100, 400);
        [self.popover presentPopoverFromRect:textField.frame inView: self permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
        return NO;
    }
	
    return YES;
}
- (void)popTableViewSelectRow:(NSString *)tag value:(NSString *)value
{
    if ([@"type" isEqualToString:tag]) {
        self.type.text = value;
    }
    if ([@"state" isEqualToString:tag]) {
        self.state.text = value;
    }
    
    [self.popover dismissPopoverAnimated:YES];
}
- (IBAction)takeoutOrder:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(takeoutOrder:)]) {
        [self.delegate takeoutOrder:takeout];
    }
}

- (IBAction)takeoutOrderList:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(takeoutOrderList:)]) {
        [self.delegate takeoutOrderList:takeout];
    }
}
- (IBAction)takeoutPay:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(takeoutPay:)]) {
        [self.delegate takeoutPay:takeout];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
