//
//  DAOpenTableViewController.m
//  MenuBook
//
//  Created by Antony on 13-11-5.
//  Copyright (c) 2013年 DAC. All rights reserved.
//

#import "DAOpenTableViewController.h"
#import "DAOpenTableViewCell.h"
#import "DAMyTableViewController.h"

@interface DAOpenTableViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation DAOpenTableViewController

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
	// Do any additional setup after loading the view.
    DAMyTableViewController *book = [[DAMyTableViewController alloc] initWithNibName:@"DAMyTableViewController" bundle:nil];
    [self addChildViewController:book];
    
    [self.openTableView addSubview:book.view];//添加到self.view
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
