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
#import "DAMyTable.h"
#import "DAPopTableViewController.h"
#import "NSString+Util.h"
#import "DrawPatternLockViewController.h"
#import "ProgressHUD.h"


@interface DAMyLoginViewController ()
{
    DrawPatternLockViewController *lockVC;
    NSString *curWaitterUserId;
    BOOL lockStatus;
}

@end

@implementation DAMyLoginViewController
{
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    lockVC = [[DrawPatternLockViewController alloc] init];
    self.numOfPepole.delegate = self;
    self.waitterId.delegate = self;
    
    lockStatus = NO;
}



- (void) viewDidAppear:(BOOL)animated
{
    self.tableName.text = self.curDesk.name;
    NSString *WaitterId = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.diandian.curWaitterUserId"];
    NSString *WaitterName = [[NSUserDefaults standardUserDefaults] objectForKey:@"jp.co.dreamarts.smart.diandian.curWaitterUserName"];
    curWaitterUserId = WaitterId;
    self.curUserId = WaitterId;
    self.waitterId.text = WaitterName;
    
}

- (void)lockEntered:(NSString*)key {
    NSLog(@"key: %@", key);
    if (curWaitterUserId != nil && curWaitterUserId.length > 0) {
        
    
        [[DALoginModule alloc]checkPattern:key userId:curWaitterUserId callback:^(NSError *error, NSDictionary *user) {
            NSLog(@"user key %@" ,user);
            NSNumber *isRight = [user objectForKey:@"isRight"];
            
            if (![isRight boolValue]) {
                [ProgressHUD showError:@"手势密码验证错误。"];
            } else {
                self.labelLock.text = @"通过";
                lockStatus = YES;
                [lockVC.view removeFromSuperview];
                if (lockStatus) {
                    if (self.delegate && [self.delegate respondsToSelector:@selector(startTableButtonClicked:)]) {
                        [self.delegate startTableButtonClicked:self];
                    }
                }
                //验证后直接开台
            }
        }];
        
    } else {
        [ProgressHUD showError:@"请选择服务员。"];
    }
    
    if([@"090807" isEqualToString:key]){
        lockStatus = NO;
        [lockVC.view removeFromSuperview];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void) show:(DADesk *)thisTable parentView :(UIViewController *) parentView
{
    DAMyLoginViewController *vc = [[DAMyLoginViewController alloc]initWithNibName:@"DAMyLoginViewController" bundle:nil];
    vc.delegate = (id)parentView;

    
    [parentView  presentPopupViewController:vc animationType:MJPopupViewAnimationFade];
}

-(void) loadTableInfo:(DADesk *) defaultmyDesk
{
//
//
//    NSString *path = [self tableInfoPath];
//    if(path != nil){
//        // Get myDesk
//        self.myDesk = [NSKeyedUnarchiver unarchiveObjectWithFile: path];
//        if (self.myDesk == nil) {
//            self.myDesk = defaultmyDesk;
//        }
//        // Init waitterId
//        NSString *lastWaitterId = [[NSUserDefaults standardUserDefaults] objectForKey: @"LastWaiterId"];
//        if ([NSString isNotEmpty:lastWaitterId]) {
////            self.myDesk.waitterId = lastWaitterId;
//        }
//        
//        
//        
//    }
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
//    
//    self.myDesk.numOfPepole = self.numOfPepole.text;
//    self.myDesk.waitterId = self.waitterId.text;
    
    NSString *path = [self tableInfoPath];
    if(path != nil){
        BOOL f = [NSKeyedArchiver archiveRootObject:self.curDesk toFile:path];
        if (f) {
            return YES;
        } else {
            NSLog(@"save DAmyDesk info fail.");
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
                              stringByAppendingPathComponent:[NSString stringWithFormat:@"data_table_info_%@", self.curDesk._id]];
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

    if(self.waitterId.text.length == 0){
        [ProgressHUD showError:@"请选择操作员。"];
        return;
    }
    self.numOfPepole.text = [NSString stringWithFormat:@"%d",3];
    if(self.numOfPepole.text.length == 0){
        [ProgressHUD showError:@"用餐人数。"];
        return;
    }

    if (lockStatus) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(startTableButtonClicked:)]) {
            [self.delegate startTableButtonClicked:self];
        }
    } else {
        [ProgressHUD showError:@"请验证您的手势密码。"];
        [lockVC setTarget:self withAction:@selector(lockEntered:)];
        lockVC.view.frame = CGRectMake(0, 0, 556, 349);
        [self addChildViewController:lockVC];
        [self.view addSubview:lockVC.view];
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

        [vc initData:@"people" list:wList];
        vc.delegate = self;
        [vc.tableView reloadData];
        //
        self.popover = [[UIPopoverController alloc]initWithContentViewController:vc];
        self.popover.popoverContentSize = CGSizeMake(100, 400);
        [self.popover presentPopoverFromRect:textField.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    } else if ([textField isEqual:self.waitterId]) {
        DAPopTableViewController *vc = [[DAPopTableViewController alloc] initWithNibName:@"DAPopTableViewController" bundle:nil];
        
        NSMutableArray *wList = [NSMutableArray array];

        
        [[DAUserModule alloc]getAllUserList:^(NSError *err, DAUserList *list) {
            for (DAUser *user in list.items) {
                [wList addObject:user];
            }
            [vc initData:@"user" list:wList];
            vc.delegate = self;
            
            self.popover = [[UIPopoverController alloc]initWithContentViewController:vc];
            self.popover.popoverContentSize = CGSizeMake(120, 400);
            [self.popover presentPopoverFromRect:textField.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }];
        

        
    }
	return NO;
}

- (void)popTableViewSelectRow:(NSString *)tag value:(id)value
{
    if ([@"user" isEqualToString:tag]) {
        DAUser *user  = value;
        self.waitterId.text = user.name;
        self.curUserId = user._id;
        curWaitterUserId = user._id;
        
        [[NSUserDefaults standardUserDefaults] setValue:user._id forKey:@"jp.co.dreamarts.smart.diandian.curWaitterUserId"];
        
        [[NSUserDefaults standardUserDefaults] setValue:user.name forKey:@"jp.co.dreamarts.smart.diandian.curWaitterUserName"];
        
        
    } else if ([@"people" isEqualToString:tag]) {
        self.numOfPepole.text = value;
    }
    
    [self.popover dismissPopoverAnimated:YES];
}


- (IBAction)passwordTouched:(id)sender {
    // Do any additional setup after loading the view from its nib.
    [lockVC setTarget:self withAction:@selector(lockEntered:)];
    lockVC.view.frame = CGRectMake(0, 0, 556, 349);
    [self addChildViewController:lockVC];
    [self.view addSubview:lockVC.view];

}


@end
