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

#import "DATakeoutLoginViewController.h"

UIViewController *parentVC;

@interface DATakeoutViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation DATakeoutViewController
{
    DAServiceList *dataList;
    int listNum;
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
    
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = YES;
    
    dataList = [[DAServiceList alloc] init];
    dataList.items = [[NSArray alloc] init];
    
    UINib *cellNib = [UINib nibWithNibName:@"DATakeoutViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"DATakeoutViewCell"];
    
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadFromApi];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    DDLogWarn(@"didReceiveMemoryWarning  :  %@" ,[self class]);
}

+ (void) show:(UIViewController *) parentView;
{
    DATakeoutViewController *vc = [[DATakeoutViewController alloc]initWithNibName:@"DATakeoutViewController" bundle:nil];
    vc.delegate = (id)parentView;
    parentVC = (id)parentView;
    [parentView  presentPopupViewController:vc animationType:MJPopupViewAnimationFade];
    
    
    //[vc setTable:thisTable];
}

-(void)loadFromApi{
    listNum = 0;
    [[DAServiceModule alloc] getTakeoutServiceList:^(NSError *err, DAServiceList *list) {
        dataList = list ;
        [self.tableView reloadData];
    }];
}

- (IBAction)closePopup:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
    }
}

- (IBAction)addTakeout:(id)sender {
    
    DATakeoutLoginViewController *takeoutLoginVC = [[DATakeoutLoginViewController alloc]initWithNibName:@"DATakeoutLoginViewController" bundle:nil];

    takeoutLoginVC.confirmCallback = ^(){
        [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
        [self loadFromApi];
    };
    [self  presentPopupViewController:takeoutLoginVC animationType:MJPopupViewAnimationFade];
    
    
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
    DATakeoutViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DATakeoutViewCell"];
    DAService *service = [dataList.items objectAtIndex:indexPath.row];
    [cell initData:service parentViewController:parentVC];
    cell.num.text = [NSString stringWithFormat:@"%d",listNum++];
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
