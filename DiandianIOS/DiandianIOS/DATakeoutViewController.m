//
//  DATakeoutViewController.m
//  DiandianIOS
//
//  Created by Xu Yang on 11/19/13.
//  Copyright (c) 2013 DAC. All rights reserved.
//

#import "DATakeoutViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "DAPopTableViewController.h"
#import "NSString+Util.h"
#import "DATakeoutViewCell.h"
#import "DATakeout.h"

UIViewController *parentVC;

@interface DATakeoutViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation DATakeoutViewController
{
    NSMutableArray *dataList;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:@"DATakeoutViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"DATakeoutViewCell"];
    
    [self loadFromFile];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void) show:(UIViewController *) parentView;
{
    DATakeoutViewController *vc = [[DATakeoutViewController alloc]initWithNibName:@"DATakeoutViewController" bundle:nil];
    vc.delegate = (id)parentView;
    parentVC = (id)parentView;
    [parentView  presentPopupViewController:vc animationType:MJPopupViewAnimationFade];
    
    
    //[vc setTable:thisTable];
}

-(void)loadFromFile{
    NSString *pathString = [[NSBundle mainBundle] pathForResource:@"takeout" ofType:@"json"];
    NSData *elementsData = [NSData dataWithContentsOfFile:pathString];
    
    NSError *anError = nil;
    NSArray *items = [NSJSONSerialization JSONObjectWithData:elementsData
                                                     options:NSJSONReadingAllowFragments
                                                       error:&anError];
    dataList = [[NSMutableArray alloc]init];
    for (NSDictionary *d in items){
        [dataList addObject: [[DATakeout alloc]initWithDictionary:d]];
    }
    [self.tableView reloadData];
}

- (IBAction)closePopup:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
    }
}

- (IBAction)addTakeout:(id)sender {
    static NSInteger tempId = 100000;
    NSInteger num = 0;
    if (dataList && dataList.count > 0) {
        DATakeout *last;
        last = [dataList objectAtIndex:(dataList.count - 1)];
        num = [last.num integerValue];
    }
    
    DATakeout *t = [[DATakeout alloc]init];
    t.takeoutId = [NSString stringWithFormat:@"%d", tempId++];
    t.num = [NSString stringWithFormat:@"%d", ++num];
    t.phoneNumber = @"";
    t.type = @"takeout";
    t.state = @"nothing";
    t.menuId = t.num;// 临时的值，需要后台传过来
    
    [dataList addObject:t];
    [self.tableView reloadData];
    
    // Scroll to botttom
    NSIndexPath *lastRow = [NSIndexPath indexPathForRow:(dataList.count - 1) inSection:0];
    [self.tableView scrollToRowAtIndexPath:lastRow atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DATakeoutViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DATakeoutViewCell"];
    [cell initData:[dataList objectAtIndex:indexPath.row] parentViewController:parentVC];
    return cell;
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [dataList removeObjectAtIndex:indexPath.row];
//    [self.tableView reloadData];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 43;
}

@end
