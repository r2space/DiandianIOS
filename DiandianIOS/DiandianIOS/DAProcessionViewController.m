//
//  DAProcessionViewController.m
//  DiandianIOS
//
//  Created by Xu Yang on 11/15/13.
//  Copyright (c) 2013 DAC. All rights reserved.
//

#import "DAProcessionViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "DAProcessionViewCell.h"
#import "DAProcession.h"

@interface DAProcessionViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DAProcessionViewController
{
    NSMutableArray *dataList;
    UIViewController *parentVC;
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
    
    UINib *cellNib = [UINib nibWithNibName:@"DAProcessionViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"DAProcessionViewCell"];

    [self loadFromFile];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void) show:(UIViewController *) parentView
{
    DAProcessionViewController *vc = [[DAProcessionViewController alloc]initWithNibName:@"DAProcessionViewController" bundle:nil];
    vc.delegate = (id)parentView;
    vc->parentVC = (id)parentView;
    [parentView  presentPopupViewController:vc animationType:MJPopupViewAnimationFade];
}

-(void)loadFromFile{
    NSString *pathString = [[NSBundle mainBundle] pathForResource:@"procession" ofType:@"json"];
    NSData *elementsData = [NSData dataWithContentsOfFile:pathString];
    
    NSError *anError = nil;
    NSArray *items = [NSJSONSerialization JSONObjectWithData:elementsData
                                                     options:NSJSONReadingAllowFragments
                                                       error:&anError];
    dataList = [[NSMutableArray alloc]init];
    for (NSDictionary *d in items){
        [dataList addObject: [[DAProcession alloc]initWithDictionary:d]];
    }
    [self.tableView reloadData];
}

- (IBAction)closePopup:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
    }
}

- (IBAction)addProcession:(id)sender {
    static NSInteger tempId = 100000;
    NSInteger num = 0;
    if (dataList && dataList.count > 0) {
        DAProcession *lastProcession;
        lastProcession = [dataList objectAtIndex:(dataList.count - 1)];
        num = [lastProcession.num integerValue];
    }
    
    DAProcession *p = [[DAProcession alloc]init];
    p.processionId = [NSString stringWithFormat:@"%d", tempId++];
    p.num = [NSString stringWithFormat:@"%d", ++num];
    p.numOfPeople = @"4";
    p.order = false;
    
    [dataList addObject:p];
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
    DAProcessionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DAProcessionViewCell"];
    [cell initData:[dataList objectAtIndex:indexPath.row] parentViewController:parentVC];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [dataList removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 43;
}
@end
