//
//  DAMyLoginViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-8.
//  Copyright (c) 2013年 DAC. All rights reserved.
//



#import "DAMyTableConfirmController.h"
#import "DABillViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "DAMyTable.h"
#import "DAPopTableViewController.h"
#import "NSString+Util.h"
#import "DAMyBackOrderViewController.h"
#import "SmartSDK.h"
#import "DARootViewController.h"

#import "Tool.h"
#import "ProgressHUD.h"

UIViewController *parentVC;

@interface DAMyTableConfirmController ()
@property (strong, nonatomic) IBOutlet UITextField *tableName;
@property (strong, nonatomic) IBOutlet UITextField *numOfPepole;
@property (strong, nonatomic) IBOutlet UITextField *durationTime;
@property (strong, nonatomic) IBOutlet UITextField *unfinishedCount;

@property (strong, nonatomic) IBOutlet UIPopoverController *popover;

@property (retain, nonatomic) DADesk *myDesk;

@end

@implementation DAMyTableConfirmController
{
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.numOfPepole.delegate = self;
    
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = YES;
}
-(void) viewDidAppear:(BOOL)animated
{
    self.tableName.text = self.myDesk.name;
    self.numOfPepole.text = [self.curService.people stringValue];
    self.durationTime.text = [Tool stringFromISODateString:self.curService.createat];
    self.unfinishedCount.text = [self.curService.unfinishedCount stringValue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void) show:(DADesk *)thisDesk parentView :(UIViewController *) parentView
{
    DAMyTableConfirmController *vc = [[DAMyTableConfirmController alloc]initWithNibName:@"DAMyTableConfirmController" bundle:nil];
    vc.delegate = (id)parentView;
    [parentView  presentPopupViewController:vc animationType:MJPopupViewAnimationFade];
    
    parentVC = (id)parentView;
    [vc setTable:thisDesk];
}

- (void) setTable:(DADesk *)thisTable
{
    [self loadTableInfo:thisTable];
    self.curService = thisTable.service;

}

-(void) loadTableInfo:(DADesk *) defaultMyTable
{
    self.myDesk = nil;

    NSString *path = [self tableInfoPath];
    if(path != nil){
        // Get MyTable
        self.myDesk = [NSKeyedUnarchiver unarchiveObjectWithFile: path];
        if (self.myDesk == nil) {
            self.myDesk = defaultMyTable;
        }
        // Init waitterId
        NSString *lastWaitterId = [[NSUserDefaults standardUserDefaults] objectForKey: @"LastWaiterId"];
        if ([NSString isNotEmpty:lastWaitterId]) {
            //设置last  服务员id
        }
    }
}

-(NSString*) tableInfoPath
{
    NSArray*paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                        NSUserDomainMask, YES);
    if([paths count]>0){
        NSString *path =[[paths objectAtIndex:0]
                              stringByAppendingPathComponent:[NSString stringWithFormat:@"data_table_info_%@", self.myDesk._id]];
        return path;
    }
    return nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL) textFieldShouldBeginEditing: (UITextField *)textField
{
    if ([textField isEqual:self.numOfPepole]) {
//        DAPopTableViewController *vc = [[DAPopTableViewController alloc] initWithNibName:@"DAPopTableViewController" bundle:nil];
//        
//        NSMutableArray *wList = [NSMutableArray array];
//        for (int i = 0; i < 50; i++) {
//            [wList addObject:[NSString stringWithFormat:@"%d", i]];
//        }
//        [vc initData:@"pepole" list:wList];
//        vc.delegate = self;
//        
//        self.popover = [[UIPopoverController alloc]initWithContentViewController:vc];
//        self.popover.popoverContentSize = CGSizeMake(100, 400);
//        [self.popover presentPopoverFromRect:textField.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
	return NO;
}

- (void)popTableViewSelectRow:(NSString *)tag value:(id)value
{
    if ([@"pepole" isEqualToString:tag]) {
        self.numOfPepole.text = value;
    }
    
    [self.popover dismissPopoverAnimated:YES];
}

- (IBAction)closePopup:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
    }
}

//  换桌
- (IBAction)changeTable:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeTable:)]) {
        [self.delegate changeTable:self.curService._id];
    }
    
    [parentVC dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}
- (IBAction)appendOrder:(id)sender {
    
    
    UIStoryboard *menubookStoryboard = [UIStoryboard storyboardWithName:@"DARootView" bundle:nil];
    DARootViewController *menubookVC = [menubookStoryboard instantiateViewControllerWithIdentifier:@"menubookVC"];
    menubookVC.curService = self.curService;
    menubookVC.willAddItem = @"YES";
    [parentVC.navigationController pushViewController:menubookVC animated:YES];
    [parentVC dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    
}

- (IBAction)backOrder:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    DAMyBackOrderViewController *vc = [[DAMyBackOrderViewController alloc] initWithNibName:@"DAMyBackOrderViewController" bundle:nil];
    vc.closeBackView = ^(){
        if ([self.popover isPopoverVisible]) {
            [self.popover dismissPopoverAnimated:YES];
        }
        [parentVC dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    };
    vc.curService = self.curService;
    
    self.popover = [[UIPopoverController alloc]initWithContentViewController:vc];
    self.popover.popoverContentSize = CGSizeMake(485, 400);
    [self.popover presentPopoverFromRect:btn.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

}

- (IBAction)payTheBill:(id)sender {

//    jp.co.dreamarts.smart.diandian.curWaitterHasCash

        DABillViewController *viewController = [[DABillViewController alloc]
                                                initWithNibName:@"DABillViewController" bundle:nil];
        viewController.curService = self.curService;
        
        [parentVC.navigationController pushViewController:viewController animated:YES];
        [parentVC dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];


}

@end
