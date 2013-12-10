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
#import "DAScheduleViewController.h"


@interface DAProcessionViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DAProcessionViewController
{
    DAScheduleList *dataList;
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
//    
//    self.view.layer.cornerRadius = 10;
//    self.view.layer.masksToBounds = YES;
    
    UINib *cellNib = [UINib nibWithNibName:@"DAProcessionViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"DAProcessionViewCell"];

    [self loadFromApi];
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

-(void)loadFromApi{
    [[DAScheduleModule alloc]getScheduleList:0 count:20 callback:^(NSError *err, DAScheduleList *list) {
        dataList = list;
        [self.tableView reloadData];
    }];
    
    
}

- (IBAction)closePopup:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
    }
}

- (IBAction)addProcession:(id)sender {


    DAScheduleViewController *scheduleVC = [[DAScheduleViewController alloc]initWithNibName:@"DAScheduleViewController" bundle:nil];
    scheduleVC.closeCallback =^(){
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
        [self loadFromApi];
    };
    [self presentPopupViewController:scheduleVC animationType:MJPopupViewAnimationFade];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataList.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DAProcessionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DAProcessionViewCell"];
    DASchedule *schedule = [dataList.items objectAtIndex:indexPath.row];
    [cell initData:schedule parentViewController:parentVC row:(indexPath.row + 1)];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    DASchedule *schedule = [dataList.items objectAtIndex:indexPath.row];
    [[DAScheduleModule alloc]removeScheduleById:schedule._id callback:^(NSError *err, DASchedule *schedule) {
        [self loadFromApi];
        [self.tableView reloadData];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 43;
}
@end
