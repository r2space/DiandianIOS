//
//  DAMyLoginViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-8.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAMyLoginViewController.h"
#import "DAMyTableViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import <SmartSDKIOS/DAMyTable.h>
#import "DAPopTableViewController.h"
#import "NSString+Util.h"

@interface DAMyLoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *tableName;
@property (strong, nonatomic) IBOutlet UITextField *numOfPepole;
@property (strong, nonatomic) IBOutlet UITextField *waitterId;
@property (strong, nonatomic) IBOutlet UITextField *waitterPassword;

@property (strong, nonatomic) IBOutlet UIPopoverController *popover;

@property (retain, nonatomic) NSString *myTableId;
@property (retain, nonatomic) DAMyTable *myTable;
@end

@implementation DAMyLoginViewController
{
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.numOfPepole.delegate = self;
    self.waitterId.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void) show:(DAMyTable*)thisTable parentView :(UIViewController *) parentView
{
    DAMyLoginViewController *vc = [[DAMyLoginViewController alloc]initWithNibName:@"DAMyLoginViewController" bundle:nil];
    vc.delegate = (id)parentView;
    [parentView  presentPopupViewController:vc animationType:MJPopupViewAnimationFade];
    
    [vc setTable:thisTable];
}

- (void) setTable:(DAMyTable*)thisTable
{
    self.myTableId = thisTable.tableId;
    [self loadTableInfo:thisTable];
    
    self.tableName.text = self.myTable.name;
    self.numOfPepole.text = self.myTable.numOfPepole;
    self.waitterId.text = self.myTable.waitterId;
    self.waitterPassword.text = @"";
    
    [self saveTableInfo];
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
        // Init numOfPepole
        self.myTable.numOfPepole = (self.myTable.numOfPepole == nil) ? @"4" : self.myTable.numOfPepole;
    }
//    if (self.myTable == nil) { // init myTable
//        NSMutableDictionary * t = [NSMutableDictionary dictionaryWithCapacity:5];
//        [t setObject:@"_id" forKey:self.myTableId];
//        self.myTable = [[DAMyTable alloc] initWithDictionary:t];
//    }
}

-(BOOL) saveTableInfo
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:self.waitterId.text forKey: @"LastWaiterId"];
    NSLog(@"%@",[defaults objectForKey:@"LastWaiterId"]);
    //[defaults synchronize];
    
    self.myTable.numOfPepole = self.numOfPepole.text;
    self.myTable.waitterId = self.waitterId.text;
    
    NSString *path = [self tableInfoPath];
    if(path != nil){
        BOOL f = [NSKeyedArchiver archiveRootObject:self.myTable toFile:path];
        if (f) {
            return YES;
        } else {
            NSLog(@"save DAMyTable info fail.");
        }
    } else {
        NSLog(@"Path don't exists!");
    }
    
    return NO;
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

- (IBAction)closePopup:(id)sender
{
    [self saveTableInfo];

    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
    }
    
}

- (IBAction)startTable:(id)sender {
    
    [self saveTableInfo];
    // TODO: 密码check
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(startTableButtonClicked:)]) {
        [self.delegate startTableButtonClicked:self];
    }
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
    } else if ([textField isEqual:self.waitterId])
    {
        DAPopTableViewController *vc = [[DAPopTableViewController alloc] initWithNibName:@"DAPopTableViewController" bundle:nil];
        
        NSMutableArray *wList = [NSMutableArray array];
        [wList addObject:@"张三"];
        [wList addObject:@"李四"];
        [wList addObject:@"王二麻子"];
        [wList addObject:@"木头六"];
        [wList addObject:@"张之洞"];
        [wList addObject:@"纪晓岚"];
        [wList addObject:@"赵德芳"];
        [wList addObject:@"越德昭"];
        [wList addObject:@"老杨"];
        [wList addObject:@"小杨"];
        [wList addObject:@"杨胜利"];
        [wList addObject:@"胜利"];
        [wList addObject:@"胜利杨"];
        [vc initData:@"waitter" list:wList];
        vc.delegate = self;
        
        self.popover = [[UIPopoverController alloc]initWithContentViewController:vc];
        self.popover.popoverContentSize = CGSizeMake(120, 400);
        [self.popover presentPopoverFromRect:textField.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
	return NO;
}

- (void)popTableViewSelectRow:(NSString *)tag value:(NSString *)value
{
    if ([@"waitter" isEqualToString:tag]) {
        self.waitterId.text = value;
    } else if ([@"pepole" isEqualToString:tag]) {
        self.numOfPepole.text = value;
    }
    
    [self.popover dismissPopoverAnimated:YES];
}

@end
