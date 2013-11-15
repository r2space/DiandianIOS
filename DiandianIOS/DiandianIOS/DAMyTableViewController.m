//
//  DAMyTableViewController.m
//  DiandianIOS
//
//  Created by Antony on 13-11-6.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAMyTableViewController.h"
#import "DAMyTableViewCell.h"
#import "DAMyLoginViewController.h"
#import "DAMyTableConfirmController.h"
#import "UIViewController+MJPopupViewController.h"
#import "DABillViewController.h"
#import "DAMyOrderQueueViewController.h"

#import <TribeSDK/DAMyTable.h>

@interface DAMyTableViewController ()<DAMyLoginDelegate>
{
    MSGridView *gridView;
    NSMutableArray *dataList;
}
@end

@implementation DAMyTableViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    dataList = [[NSMutableArray alloc] init];
    UINib *cellNib = [UINib nibWithNibName:@"DAMyTableViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"DAMyTableViewCell"];
    
    
    self.topmenuView.layer.shadowColor = UIColor.blackColor.CGColor;
    self.topmenuView.layer.shadowRadius = 2;
    self.topmenuView.layer.shadowOpacity = 0.6;
    self.topmenuView.layer.shadowOffset = CGSizeMake(0, 1);
    
    

    self.btnMenuList.layer.shadowColor = UIColor.blackColor.CGColor;
    self.btnMenuList.layer.shadowRadius = 2;
    self.btnMenuList.layer.shadowOpacity = 0.6;
    self.btnMenuList.layer.shadowOffset = CGSizeMake(0, 1);
    
    self.btnAccount.layer.shadowColor = UIColor.blackColor.CGColor;
    self.btnAccount.layer.shadowRadius = 2;
    self.btnAccount.layer.shadowOpacity = 0.6;
    self.btnAccount.layer.shadowOffset = CGSizeMake(0, 1);
    
    self.btnServing.layer.shadowColor = UIColor.blackColor.CGColor;
    self.btnServing.layer.shadowRadius = 2;
    self.btnServing.layer.shadowOpacity = 0.6;
    self.btnServing.layer.shadowOffset = CGSizeMake(0, 1);
    
    self.btnRemove.layer.shadowColor = UIColor.blackColor.CGColor;
    self.btnRemove.layer.shadowRadius = 2;
    self.btnRemove.layer.shadowOpacity = 0.6;
    self.btnRemove.layer.shadowOffset = CGSizeMake(0, 1);
    
    
    self.viewTitle.layer.cornerRadius = 15.0;
    self.viewTitle.layer.masksToBounds = YES;
    
    self.navigationController.navigationBarHidden = YES;
    
    [self loadFromFile];
}

-(void)loadFromFile{
    NSString *pathString = [[NSBundle mainBundle] pathForResource:@"table" ofType:@"json"];
    NSData *elementsData = [NSData dataWithContentsOfFile:pathString];
    
    NSError *anError = nil;
    NSArray *items = [NSJSONSerialization JSONObjectWithData:elementsData
                                                              options:NSJSONReadingAllowFragments
                                                                error:&anError];
    
    for (NSDictionary *d in items){
        [dataList addObject:d];
    }
}

- (void)cancelButtonClicked:(DAMyLoginViewController*)loginViewViewController{
    
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    
}

- (void)startTableButtonClicked:(DAMyLoginViewController*)loginViewViewController{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    UIStoryboard *menubookStoryboard = [UIStoryboard storyboardWithName:@"DARootView" bundle:nil];
    UIViewController *menubookVC = [menubookStoryboard instantiateViewControllerWithIdentifier:@"menubookVC"];
    [self.navigationController pushViewController:menubookVC animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return dataList.count ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
    // we're going to use a custom UICollectionViewCell, which will hold an image and its label
    //
    
    
    NSString *cellIdentifier ;
    
    cellIdentifier = @"DAMyTableViewCell";
    
    DAMyTableViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSDictionary *d = [dataList objectAtIndex:indexPath.row];
    [cell setData:[d objectForKey:@"name"] setState:[d objectForKey:@"state"]];
    cell.imgTable.image = [UIImage imageNamed:[d objectForKey:@"image"]];
    
    cell.imgTable.layer.cornerRadius = 5.0;
    cell.imgTable.layer.masksToBounds = YES;
    
    cell.viewMask.layer.cornerRadius = 5.0;
    cell.viewMask.layer.masksToBounds = YES;

    cell.viewLabel.layer.cornerRadius = 3.0;
    cell.viewLabel.layer.masksToBounds = YES;
    
    
    
    
    if (indexPath.row == 2 || indexPath.row == 5 || indexPath.row == 3 || indexPath.row == 7 || indexPath.row == 9) {
        cell.viewMask.hidden = YES;
    }

    return cell;
}


-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *d = [dataList objectAtIndex:indexPath.row];
    DAMyTable * t = [[DAMyTable alloc] initWithDictionary:d];

    if ([@"empty" isEqualToString:t.state]) {
        [DAMyLoginViewController show: t parentView:self ];
    } else {
        [DAMyTableConfirmController show: t parentView:self ];
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)onReturnTouched:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)showBillTouched:(id)sender {
    DABillViewController *viewController = [[DABillViewController alloc] initWithNibName:@"DABillViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)showMenuList:(id)sender {
    UIStoryboard *menubookStoryboard = [UIStoryboard storyboardWithName:@"DARootView" bundle:nil];
    UIViewController *menubookVC = [menubookStoryboard instantiateViewControllerWithIdentifier:@"menubookVC"];
    [self.navigationController pushViewController:menubookVC animated:YES];
}

- (IBAction)showOrderQueueTouched:(id)sender {
    
    DAMyOrderQueueViewController *viewController = [[DAMyOrderQueueViewController alloc] initWithNibName:@"DAMyOrderQueueViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}
@end
