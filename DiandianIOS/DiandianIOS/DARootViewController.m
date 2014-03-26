//
//  DARootViewController.m
//  MenuBook
//
//  Created by Antony on 13-11-5.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DARootViewController.h"
#import "DABookCell.h"
#import "DAMyBookViewController.h"
#import "DAMyFilterViewController.h"
#import "DAMyOrderViewController.h"
#import "DAMyMenuBookViewController.h"

#import "SmartSDK.h"
#import "NSString+Util.h"


@interface DARootViewController ()
{
    DAMyOrderViewController *orderView;
    
    //api
    DAMenuList *dataList;
    BOOL isAddItem;
    NSMutableArray *searchResult;
    NSMutableArray *searchBase;
}
@end

@implementation DARootViewController

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
    isAddItem = NO;
    if ([@"YES" isEqualToString:self.willAddItem]) {
        isAddItem = YES;
    }

    DAMyMenuBookViewController *book = [[DAMyMenuBookViewController alloc] initWithNibName:@"DAMyMenuBookViewController" bundle:nil];
    book.curService = self.curService;
    [self addChildViewController:book];
    [self.MenuGird addSubview:book.view];
    
    
    DAMyFilterViewController *filter = [[DAMyFilterViewController alloc] initWithNibName:@"DAMyFilterViewController" bundle:nil];
    [self addChildViewController:filter];
    [self.filerListView addSubview:filter.view];
    
    
    
    orderView = [[DAMyOrderViewController alloc] initWithNibName:@"DAMyOrderViewController" bundle:nil];
    
    orderView.curService = self.curService;
    
    [self addChildViewController:orderView];
    [self.orderListView addSubview:orderView.view];
    [self.quickSearchTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"QuickSearchCell"];
    
    

}

-(void)viewDidAppear:(BOOL)animated
{
    if (isAddItem) {
        [orderView loadOldItem];
    }

}
-(void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doSearch:) name:@"QuickSearchRequest" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    DDLogWarn(@"didReceiveMemoryWarning  :  %@" ,[self class]);
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [searchResult count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuickSearchCell" forIndexPath:indexPath];
    DAItem *data =   [searchResult objectAtIndex:indexPath.row];
    cell.textLabel.text =   data.itemName;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TO-Do
    NSNotification *addOrderNotification = [NSNotification notificationWithName:@"menu_addOrder" object:[searchResult objectAtIndex:indexPath.row]];
    [[NSNotificationCenter defaultCenter] postNotification:addOrderNotification];
    NSNotification *searchRequest = [NSNotification notificationWithName:@"QuickSearchRes" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:searchRequest];
}

- (void)doSearch:(NSNotification *)sender
{
    if(self.quickSearchTableView.hidden){
        self.quickSearchTableView.hidden = NO;
    }
    NSString *key = sender.object;
    if([NSString isEmpty:key]){
        searchResult = [[NSMutableArray alloc] init];
        [self.quickSearchTableView reloadData];
        self.quickSearchTableView.hidden = YES;
        return;
    }
    NSError *error;
    NSRegularExpression* regex = [[NSRegularExpression alloc] initWithPattern:[NSString stringWithFormat:@"%@",key] options:NSRegularExpressionCaseInsensitive error:&error];
    if(searchBase == nil){
        searchBase = [[NSMutableArray alloc] init];
        DAMenuList* menuList = [[DAMenuList alloc]unarchiveObjectWithFileWithName:FILE_MENU_LIST];
        for (DAMenu *menu in menuList.items){
               for (NSDictionary* layout in menu.items){
                   DAItemLayout* item = [[DAItemLayout alloc] initWithDictionary:layout];
                   [searchBase addObject:item.item];
               }
        }
    }

    searchResult = [[NSMutableArray alloc] init];
    for (DAItem *item in searchBase){
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:item.searchIndex
                                                       options:0
                                                         range:NSMakeRange(0, [item.searchIndex length])];
        if(firstMatch){
            [searchResult addObject:item];
        }
    }

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (DAItem *item in searchResult) {
        [dict setObject:item forKey:item._id];
    }

    searchResult = [self filterSoldout: dict];

    [self.quickSearchTableView reloadData];

}

-(NSMutableArray *)filterSoldout:(NSMutableDictionary *) searchDic
{

    DASoldoutList *soldout;
    for (UIViewController *controller in self.childViewControllers){
        if([controller isMemberOfClass:[DAMyMenuBookViewController class]]){
            soldout = [(DAMyMenuBookViewController*)controller getSoldout];
        }
    }

    NSMutableArray *keysWillRemove = [[NSMutableArray alloc] init];
    for (NSString *itemKey in [searchDic allKeys]) {
        for (DASoldout *sditem in soldout.items) {
            if ([itemKey isEqualToString:sditem.itemId]) {
                //[searchDic removeObjectForKey:itemKey];
                [keysWillRemove addObject:itemKey];
            }
        }
    }
    for (NSString *key in keysWillRemove){
        [searchDic removeObjectForKey:key];
    }
    NSMutableArray *result = [[NSMutableArray alloc] initWithArray:[searchDic allValues]];
    [result sortUsingComparator: ^ NSComparisonResult(DAItem *d1, DAItem *d2) {
        return [d1._id compare:d2._id];
    }];
    return result;
}

@end
