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

UIViewController *parentVC;

@interface DAMyTableConfirmController ()
@property (strong, nonatomic) IBOutlet UITextField *tableName;
@property (strong, nonatomic) IBOutlet UITextField *numOfPepole;
@property (strong, nonatomic) IBOutlet UITextField *durationTime;
@property (strong, nonatomic) IBOutlet UITextField *unfinishedCount;

@property (strong, nonatomic) IBOutlet UIPopoverController *popover;

@property (retain, nonatomic) NSString *myTableId;
@property (retain, nonatomic) DAMyTable *myTable;

@end

@implementation DAMyTableConfirmController
{
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.numOfPepole.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void) show:(DAMyTable*)thisTable parentView :(UIViewController *) parentView
{
    DAMyTableConfirmController *vc = [[DAMyTableConfirmController alloc]initWithNibName:@"DAMyTableConfirmController" bundle:nil];
    vc.delegate = (id)parentView;
    [parentView  presentPopupViewController:vc animationType:MJPopupViewAnimationFade];
    
    parentVC = (id)parentView;
    [vc setTable:thisTable];
}

- (void) setTable:(DAMyTable*)thisTable
{
    self.myTableId = thisTable.tableId;
    [self loadTableInfo:thisTable];
    
    self.tableName.text = self.myTable.name;
    self.numOfPepole.text = self.myTable.numOfPepole;
    self.durationTime.text = self.myTable.durationTime;
    self.unfinishedCount.text = self.myTable.unfinishedCount;
}

-(void) loadTableInfo:(DAMyTable*) defaultMyTable
{
    self.myTable = nil;

    NSString *path = [self tableInfoPath];
    if(path != nil){
        // Get MyTable
        self.myTable = [NSKeyedUnarchiver unarchiveObjectWithFile: path];
        if (self.myTable == nil) {
            self.myTable = defaultMyTable;
        }
        // Init waitterId
        NSString *lastWaitterId = [[NSUserDefaults standardUserDefaults] objectForKey: @"LastWaiterId"];
        if ([NSString isNotEmpty:lastWaitterId]) {
            self.myTable.waitterId = lastWaitterId;
        }
    }
}

-(NSString*) tableInfoPath
{
    NSArray*paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                        NSUserDomainMask, YES);
    if([paths count]>0){
        NSString *path =[[paths objectAtIndex:0]
                              stringByAppendingPathComponent:[NSString stringWithFormat:@"data_table_info_%@", self.myTableId]];
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
        DAPopTableViewController *vc = [[DAPopTableViewController alloc] initWithNibName:@"DAPopTableViewController" bundle:nil];
        
        NSMutableArray *wList = [NSMutableArray array];
        for (int i = 0; i < 50; i++) {
            [wList addObject:[NSString stringWithFormat:@"%d", i]];
        }
        [vc initData:@"pepole" list:wList];
        vc.delegate = self;
        
        self.popover = [[UIPopoverController alloc]initWithContentViewController:vc];
        self.popover.popoverContentSize = CGSizeMake(100, 400);
        [self.popover presentPopoverFromRect:textField.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
	return NO;
}

- (void)popTableViewSelectRow:(NSString *)tag value:(NSString *)value
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
        [self.delegate changeTable:self.myTableId];
    }
    
    [parentVC dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}
- (IBAction)appendOrder:(id)sender {
    [parentVC dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    
    UIStoryboard *menubookStoryboard = [UIStoryboard storyboardWithName:@"DARootView" bundle:nil];
    UIViewController *menubookVC = [menubookStoryboard instantiateViewControllerWithIdentifier:@"menubookVC"];
    [parentVC.navigationController pushViewController:menubookVC animated:YES];
}

- (IBAction)backOrder:(id)sender {
    NSLog(@"fdfas");
    UIButton *btn = (UIButton *)sender;
    DAMyBackOrderViewController *vc = [[DAMyBackOrderViewController alloc] initWithNibName:@"DAMyBackOrderViewController" bundle:nil];
    
    NSMutableArray *wList = [NSMutableArray array];
    for (int i = 0; i < 50; i++) {
        [wList addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    
    self.popover = [[UIPopoverController alloc]initWithContentViewController:vc];
    self.popover.popoverContentSize = CGSizeMake(320, 400);
    [self.popover presentPopoverFromRect:btn.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

}

- (IBAction)payTheBill:(id)sender {
    [parentVC dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    DABillViewController *viewController = [[DABillViewController alloc] initWithNibName:@"DABillViewController" bundle:nil];
    [parentVC.navigationController pushViewController:viewController animated:YES];
}

@end
