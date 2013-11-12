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
#import <TribeSDK/DAMyTable.h>

@interface DAMyLoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *tableName;
@property (strong, nonatomic) IBOutlet UITextField *numOfPeople;
@property (strong, nonatomic) IBOutlet UITextField *waitterId;
@property (strong, nonatomic) IBOutlet UITextField *waitterPassword;
@property (strong, nonatomic) IBOutlet UIPickerView *waitterId2;

@property (retain, nonatomic) NSString *myTableId;
@property (retain, nonatomic) DAMyTable *myTable;
@end

@implementation DAMyLoginViewController

{
    NSArray *pickerArray;
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
    pickerArray = [NSArray arrayWithObjects:@"LiLin",@"XiaoBei",@"YaPing",@"LaoYang", @"LiZheng", @"LiHao", @"XuYang", nil];
    
    self.waitterId2.delegate = self;
    self.waitterId2.dataSource = self;
    
    self.myTableId = thisTable._id;
    [self loadTableInfo];
    if (self.myTable == nil) {
        self.myTable = thisTable;
    }
    
    self.myTable.numOfPepole = (self.myTable.numOfPepole == nil) ? @"0" : self.myTable.numOfPepole;
    
    [self saveTableInfo];
    
    self.tableName.text = self.myTable.name;
    self.numOfPeople.text = self.myTable.numOfPepole;
    self.waitterId.text = self.myTable.waitterId;
    self.waitterPassword.text = @"";
}

-(void) loadTableInfo
{
    self.myTable = nil;

    NSString *path = [self tableInfoPath];
    if(path != nil){
        self.myTable = [NSKeyedUnarchiver unarchiveObjectWithFile: path];
    }
//    if (self.myTable == nil) { // init myTable
//        NSMutableDictionary * t = [NSMutableDictionary dictionaryWithCapacity:5];
//        [t setObject:@"_id" forKey:self.myTableId];
//        self.myTable = [[DAMyTable alloc] initWithDictionary:t];
//    }
}

-(BOOL) saveTableInfo
{
    self.myTable.numOfPepole = self.numOfPeople.text;
    self.myTable.waitterId = [pickerArray objectAtIndex:[self.waitterId2 selectedRowInComponent:0]];
    
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

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerArray count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
