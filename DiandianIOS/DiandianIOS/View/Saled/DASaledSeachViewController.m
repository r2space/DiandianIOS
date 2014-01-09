//
//  DASaledSeachViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-12-23.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DASaledSeachViewController.h"
#import "TMCache.h"

@interface DASaledSeachViewController ()
{
    DATagList *tagDataList;
    NSMutableArray *tagList;
    NSMutableArray *tmpTagList;
    BOOL tagLoadFlag;
    BOOL loading;
}
@end

@implementation DASaledSeachViewController

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
    tagLoadFlag = NO;
    loading = NO;
    tagList = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view from its nib.
    UINib *cellNib = [UINib nibWithNibName:@"DATagListCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"DATagListCell"];
    self.tableView.backgroundColor = [UIColor clearColor];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(noticeReload:)
                                                 name:@"TagsReload" object:nil];
}

- (void)noticeReload:(NSNotification *)notification {
    loading = NO;
    NSMutableArray *tmpObject = [notification object];

    
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    for (int i = 0 ;i <[tmpObject count] ;i++) {
        DATag *tag = [DATag alloc];
        tag.name = [NSString stringWithFormat:@"%@",[tmpObject objectAtIndex:i]];
        [tmpArray addObject:tag];
    }

    

    if (!tagLoadFlag) {
        tmpTagList = tmpObject;
        tagLoadFlag = YES;
        tagDataList.items = [[NSArray alloc ]initWithArray:tmpArray];
        [self.tableView reloadData];
    } else {
        tmpTagList = tmpObject;
        [self.tableView reloadData];
        
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[TMCache sharedCache] objectForKey:@"cache.taglist" block:^(TMCache *cache, NSString *key, id object) {
        if (object) {
            NSLog(@"cache.taglist  cached");
            tagDataList = (DATagList *)object;
//            [self.tableView reloadData];
            return;
        }
        NSLog(@"miss  cache.taglist  cache");
        [[DAItemModule alloc] getTagList:^(NSError *err, DATagList *list) {
            if (err!=nil) {

                return;
            }
            tagDataList = list;
//            [self.tableView reloadData];
            [[TMCache sharedCache] setObject:list forKey:@"cache.taglist"];
        }];
    }];

}

- (void)selectedTag:(NSString *)tagName{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message"
                                                    message:[NSString stringWithFormat:@"You tapped tag %@", tagName]
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tagDataList.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DATagListCell" forIndexPath:indexPath];
    DATag *tag = [tagDataList.items objectAtIndex:indexPath.row];
    tag.should = @"0";
    tag.selected = @"0";
    
    for (NSString *tagName in tmpTagList) {
        if ([tag.name isEqualToString:tagName]) {
            tag.should = @"1";
        }
    }
    for (NSString *tagName in tagList) {
        if ([tag.name isEqualToString:tagName]) {
            tag.selected = @"1";
        }
    }
    
    
    if ([tag.should isEqualToString:@"1"]) {
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.contentView.alpha = 1;

    } else {
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.contentView.alpha = 0.3;
    }
    
    UILabel     *labelName  = (UILabel *)[cell viewWithTag:10];
    if ([tag.selected isEqualToString:@"1"]) {

        labelName.text = [NSString stringWithFormat:@"%@ √",tag.name];
    } else {
        labelName.text = tag.name;
    }


    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (loading) {
        return NO;
    }
    DATag *tag = [tagDataList.items objectAtIndex:indexPath.row];
    tag.should = @"0";
    for (NSString *tagName in tmpTagList) {
        if ([tag.name isEqualToString:tagName]) {
            tag.should = @"1";
        }
    }

    if ([tag.should isEqualToString:@"1"]) {
        return YES;
    } else {
        return NO;
    }
    


}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    loading = YES;
    DATag *tag = [tagDataList.items objectAtIndex:indexPath.row];
    for (NSString *tmpName in tagList) {
        if ([tmpName isEqualToString:tag.name]) {
            [tagList removeObject:tag.name];
            NSNotification *addOrderNotification = [NSNotification notificationWithName:@"DAItemListReload" object:tagList];
            
            [[NSNotificationCenter defaultCenter] postNotification:addOrderNotification];
            
            return;
        }
    }
    
    [tagList addObject:tag.name];
    NSNotification *addOrderNotification = [NSNotification notificationWithName:@"DAItemListReload" object:tagList];
    
    [[NSNotificationCenter defaultCenter] postNotification:addOrderNotification];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DATag *tag = [tagDataList.items objectAtIndex:indexPath.row];
    [tagList removeObject:tag.name];
    NSNotification *addOrderNotification = [NSNotification notificationWithName:@"DAItemListReload" object:tagList];
    
    [[NSNotificationCenter defaultCenter] postNotification:addOrderNotification];
}

@end
